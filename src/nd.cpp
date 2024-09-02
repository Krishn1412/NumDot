#include "nd.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/godot.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

#include <iostream>
#include "xtensor/xadapt.hpp"
#include "xtensor/xview.hpp"
#include "xtensor/xlayout.hpp"

#include "xtv.h"

using namespace godot;

void nd::_bind_methods() {
	godot::ClassDB::bind_static_method("nd", D_METHOD("asarray", "array", "dtype"), &nd::asarray, DEFVAL(nullptr), DEFVAL(NDArray::DType::DTypeMax));
	godot::ClassDB::bind_static_method("nd", D_METHOD("array", "array", "dtype"), &nd::array, DEFVAL(nullptr), DEFVAL(NDArray::DType::DTypeMax));
	godot::ClassDB::bind_static_method("nd", D_METHOD("zeros", "shape", "dtype"), &nd::zeros, DEFVAL(nullptr), DEFVAL(NDArray::DType::Float64));
	godot::ClassDB::bind_static_method("nd", D_METHOD("ones", "shape", "dtype"), &nd::ones, DEFVAL(nullptr), DEFVAL(NDArray::DType::Float64));

	godot::ClassDB::bind_static_method("nd", D_METHOD("add", "a", "b"), &nd::add);
	godot::ClassDB::bind_static_method("nd", D_METHOD("subtract", "a", "b"), &nd::subtract);
	godot::ClassDB::bind_static_method("nd", D_METHOD("multiply", "a", "b"), &nd::multiply);
	godot::ClassDB::bind_static_method("nd", D_METHOD("divide", "a", "b"), &nd::divide);
}

nd::nd() {
}

nd::~nd() {
	// Add your cleanup here.
}

template <typename T>
bool _asshape(Variant shape, T &target) {
	auto type = shape.get_type();

	if (Variant::can_convert(type, Variant::Type::INT)) {
		target = { uint64_t(shape) };
		return true;
	}
	if (Variant::can_convert(type, Variant::Type::PACKED_INT32_ARRAY)) {
		auto shape_array = PackedInt32Array(shape);
		uint64_t size = shape_array.size();

		xt::static_shape<std::size_t, 1> shape_of_shape = { size };

		target = xt::adapt(shape_array.ptrw(), size, xt::no_ownership(), shape_of_shape);
		return true;
	}

	ERR_FAIL_V_MSG(false, "Variant cannot be converted to a shape.");
}

bool _asarray(Variant array, std::shared_ptr<xtv::Variant> &target) {
	auto type = array.get_type();

	if (type == Variant::OBJECT) {
		if (auto ndarray = dynamic_cast<NDArray*>((Object*)(array))) {
			target = ndarray->array;
			return true;
		}
	}

	if (Variant::can_convert(type, Variant::Type::INT)) {
		target = std::make_shared<xtv::Variant>(xt::xarray<int64_t>());
		return true;
	}
	if (Variant::can_convert(type, Variant::Type::FLOAT)) {
		target = std::make_shared<xtv::Variant>(xt::xarray<double_t>(double_t(array)));
		return true;
	}
	if (Variant::can_convert(type, Variant::Type::PACKED_FLOAT64_ARRAY)) {
		auto shape_array = PackedInt32Array(array);
		uint64_t size = shape_array.size();

		xt::static_shape<std::size_t, 1> shape_of_shape = { size };

		target = std::make_shared<xtv::Variant>(
			xt::xarray<double_t>(xt::adapt(shape_array.ptrw(), size, xt::no_ownership(), shape_of_shape))
		);
		return true;
	}

	ERR_FAIL_V_MSG(false, "Variant cannot be converted to an array.");
}

Variant nd::asarray(Variant array, xtv::DType dtype) {
	auto type = array.get_type();

	// Can we take a view?
	if (type == Variant::OBJECT) {
		if (auto ndarray = dynamic_cast<NDArray*>((Object*)(array))) {
			if (dtype == xtv::DType::DTypeMax || ndarray->dtype() == dtype) {
				return array;
			}
		}
	}

	// Ok, we need a copy of the data.
	return nd::array(array, dtype);
}

Variant nd::array(Variant array, xtv::DType dtype) {
	auto type = array.get_type();

	std::shared_ptr<xtv::Variant> existing_array;
	if (!_asarray(array, existing_array)) {
		return nullptr;
	}

	if (dtype == xtv::DType::DTypeMax) {
		dtype = xtv::DType((*existing_array).index());
	}

	auto result = xtv::array(*existing_array, dtype);
	if (result == nullptr) {
		ERR_FAIL_V_MSG(nullptr, "Dtype must be set for this operation.");\
	}
	
	return Variant(memnew(NDArray(result)));
}

Variant nd::zeros(Variant shape, xtv::DType dtype) {
	xt::xarray<size_t> shape_array;
	if (!_asshape(shape, shape_array)) {
		return nullptr;
	}

	auto result = xtv::zeros(shape_array, dtype);
	if (result == nullptr) {
		ERR_FAIL_V_MSG(nullptr, "Dtype must be set for this operation.");\
	}
	
	return Variant(memnew(NDArray(result)));
}

Variant nd::ones(Variant shape, xtv::DType dtype) {
	xt::xarray<size_t> shape_array;
	if (!_asshape(shape, shape_array)) {
		return nullptr;
	}

	auto result = xtv::ones(shape_array, dtype);
	if (result == nullptr) {
		ERR_FAIL_V_MSG(nullptr, "Dtype must be set for this operation.");\
	}
	
	return Variant(memnew(NDArray(result)));
}

template <typename operation>
inline Variant binOp(Variant a, Variant b) {
	std::shared_ptr<xtv::Variant> a_;
	if (!_asarray(a, a_)) {
		return nullptr;
	}
	std::shared_ptr<xtv::Variant> b_;
	if (!_asarray(b, b_)) {
		return nullptr;
	}

	return Variant(memnew(NDArray(xtv::operation<operation>(*a_, *b_))));
}

Variant nd::add(Variant a, Variant b) {
	// godot::UtilityFunctions::print(xt::has_simd_interface<xt::xarray<int64_t>>::value);
	// godot::UtilityFunctions::print(xt::has_simd_type<xt::xarray<int64_t>>::value);
	return binOp<xtv::Add>(a, b);
}

Variant nd::subtract(Variant a, Variant b) {
	return binOp<xtv::Subtract>(a, b);
}

Variant nd::multiply(Variant a, Variant b) {
	return binOp<xtv::Multiply>(a, b);
}

Variant nd::divide(Variant a, Variant b) {
	return binOp<xtv::Divide>(a, b);
}
