#include "conversion_ints.hpp"

#include <cstdint>                                  // for int64_t
#include <algorithm>                                 // for copy
#include <cstddef>                                   // for ptrdiff_t, size_t
#include <stdexcept>                                 // for runtime_error
#include <type_traits>                               // for decay_t
#include <variant>                                   // for visit
#include <vector>                                    // for vector
#include <vatensor/vpromote.hpp>
#include <vatensor/vcarray.hpp>                        // fill_c_array_flat
#include "conversion_array.hpp"
#include "godot_cpp/classes/object.hpp"              // for Object
#include "godot_cpp/core/object.hpp"                 // for Object::cast_to
#include "godot_cpp/variant/array.hpp"               // for Array
#include "godot_cpp/variant/packed_byte_array.hpp"   // for PackedByteArray
#include "godot_cpp/variant/packed_int32_array.hpp"  // for PackedInt32Array
#include "godot_cpp/variant/packed_int64_array.hpp"  // for PackedInt64Array
#include "godot_cpp/variant/variant.hpp"             // for Variant
#include "godot_cpp/variant/vector2i.hpp"            // for Vector2i
#include "godot_cpp/variant/vector3i.hpp"            // for Vector3i
#include "godot_cpp/variant/vector4i.hpp"            // for Vector4i
#include "ndarray.hpp"                                 // for NDArray
#include "xtensor/xiterator.hpp"                     // for operator==
#include "xtensor/xlayout.hpp"                       // for layout_type
#include "xtl/xiterator_base.hpp"                    // for operator!=

template<typename C>
C variant_as_int_strict(const Variant& variant) {
	switch (variant.get_type()) {
		case Variant::OBJECT: {
			if (const auto ndarray = Object::cast_to<NDArray>(variant)) {
				return std::visit(
					[](const auto& carray) -> C {
						using V = typename std::decay_t<decltype(carray)>::value_type;

						if constexpr (!va::promote::is_integer_t<V>::value) {
							throw std::runtime_error("incompatible dtype; must be int");
						}
						else {
							switch (carray.dimension()) {
								case 0:
									return va::static_cast_scalar<C>(*carray.data());
								default:
									throw std::runtime_error("array must be zero-dimensional");
							}
						}
					}, ndarray->array->data
				);
			};
		}
		case Variant::INT:
			return static_cast<C>(static_cast<int64_t>(variant));
		default:
			break;
	}

	throw std::runtime_error("Variant cannot be converted to an axis type.");
}

template<typename C, typename T>
T variant_as_ints_(const Variant& variant) {
	switch (variant.get_type()) {
		case Variant::OBJECT: {
			if (const auto ndarray = Object::cast_to<NDArray>(variant)) {
				return std::visit(
					[](const auto& carray) -> T {
						using V = typename std::decay_t<decltype(carray)>::value_type;

						if constexpr (!std::is_integral_v<V>) {
							throw std::runtime_error("incompatible dtype; must be int");
						}
						else {
							switch (carray.dimension()) {
								case 0:
									return T { C(*carray.data()) };
								case 1: {
									T ints;
									ints.resize(carray.size());
									va::util::fill_c_array_flat(ints.data(), carray);
									return ints;
								}
								default:
									throw std::runtime_error("array must be zero-dimensional or one-dimensional");
							}
						}
					}, ndarray->array->data
				);
			}
			break;
		}
		case Variant::ARRAY: {
			const Array axes_array = variant;
			auto axes = T(axes_array.size());
			for (int64_t i = 0; i < axes_array.size(); i++) {
				axes[i] = variant_as_int_strict<C>(axes_array[i]);
			}
			return axes;
		}
		case Variant::INT:
			return { C(static_cast<int64_t>(variant)) };
		case Variant::PACKED_BYTE_ARRAY:
			return packed_as_array<T>(PackedByteArray(variant));
		case Variant::PACKED_INT32_ARRAY:
			return packed_as_array<T>(PackedInt32Array(variant));
		case Variant::PACKED_INT64_ARRAY:
			return packed_as_array<T>(PackedInt64Array(variant));
		case Variant::VECTOR2I: {
			auto vector = Vector2i(variant);
			return { C(vector.x), C(vector.y) };
		}
		case Variant::VECTOR3I: {
			auto vector = Vector3i(variant);
			return { C(vector.x), C(vector.y), C(vector.z) };
		}
		case Variant::VECTOR4I: {
			auto vector = Vector4i(variant);
			return { C(vector.x), C(vector.y), C(vector.z), C(vector.w) };
		}
		default:
			break;
	}

	throw std::runtime_error("Unsupported type");
}

va::shape_type variant_to_shape(const Variant& variant) {
	return variant_as_ints_<std::size_t, std::vector<std::size_t>>(variant);
}

std::ptrdiff_t variant_to_axis(const Variant& variant) {
	return variant_as_int_strict<std::ptrdiff_t>(variant);
}

va::axes_type variant_to_axes(const Variant& variant) {
	return variant_as_ints_<std::ptrdiff_t, va::axes_type>(variant);
}

va::axes_type variants_to_axes(const Variant** args, GDExtensionInt arg_count, GDExtensionCallError& error) {
	auto axes = va::axes_type(arg_count);
	for (int i = 0; i < arg_count; i++) {
		axes[i] = variant_as_int_strict<std::ptrdiff_t>(*args[i]);
	}
	return axes;
}

PadVariant variant_to_pad_variant(const Variant& variant) {
	switch (variant.get_type()) {
		case Variant::INT:
			return static_cast<std::size_t>(static_cast<int64_t>(variant));
		case Variant::ARRAY: {
			const Array array = variant;
			std::vector<std::vector<std::size_t>> pad_width(array.size());
			for (int64_t i = 0; i < array.size(); i++) {
				switch (array[i].get_type()) {
					case Variant::INT:
						goto just_use_1d;
					default:
						break;
				}

				pad_width[i] = variant_as_ints_<std::size_t, std::vector<std::size_t>>(array[i]);
				if (pad_width[i].size() != 2) throw std::runtime_error("pad_width elements must be [before, after]");
			}
			return pad_width;
		}
		default:
			break;
	}
	just_use_1d:

	auto ints = variant_as_ints_<std::size_t, std::vector<std::size_t>>(variant);
	if (ints.size() != 2) throw std::runtime_error("pad_width must be [before, after]");
	return ints;
}
