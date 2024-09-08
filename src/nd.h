#ifndef NUMDOT_ND_H
#define NUMDOT_ND_H

#include <godot_cpp/godot.hpp>
#include <godot_cpp/classes/ref.hpp>
#include <godot_cpp/core/binder_common.hpp>

#include "xtensor/xio.hpp"

#include "ndarray.h"
#include "ndrange.h"
#include "xtv.h"

using namespace godot;

// From https://github.com/xtensor-stack/xtensor/issues/1413
template <class E>
String xt_to_string(const xt::xexpression<E>& e)
{
    std::ostringstream out;
    out << e;
    return String(out.str().c_str());
}

StringName newaxis() {
	const StringName newaxis = StringName("newaxis");
	return newaxis;
}

class nd : public Object {
	GDCLASS(nd, Object)

protected:
	static void _bind_methods();

public:
	// Godot needs nd::DType here.
	using DType = xtv::DType;

	nd();
	~nd();

	// Constants.
	static StringName newaxis();

	// Range.
	static Ref<NDRange> range(Variant start_or_stop = static_cast<int64_t>(0), Variant stop = nullptr, Variant step = DEFVAL(nullptr));
	static Ref<NDRange> from(int64_t start);
	static Ref<NDRange> to(int64_t stop);

	// Property access.
	static DType dtype(Variant array);
	static uint64_t size_of_dtype_in_bytes(DType dtype);
	static PackedInt64Array shape(Variant array);
	static uint64_t size(Variant array);
	static uint64_t ndim(Variant array);
	
	// Array interpretation.
	static Ref<NDArray> as_type(Variant array, DType dtype);
	static Ref<NDArray> as_array(Variant array, DType dtype = DType::DTypeMax);
	static Ref<NDArray> array(Variant array, DType dtype = DType::DTypeMax);

	// Array creation.
	static Ref<NDArray> empty(Variant shape, DType dtype = DType::Float64);
	static Ref<NDArray> full(Variant shape, Variant fill_value, DType dtype = DType::Float64);
	static Ref<NDArray> zeros(Variant shape, DType dtype = DType::Float64);
	static Ref<NDArray> ones(Variant shape, DType dtype = DType::Float64);

	// Basic math functions.
	static Ref<NDArray> add(Variant a, Variant b);
	static Ref<NDArray> subtract(Variant a, Variant b);
	static Ref<NDArray> multiply(Variant a, Variant b);
	static Ref<NDArray> divide(Variant a, Variant b);
	static Ref<NDArray> remainder(Variant a, Variant b);
	static Ref<NDArray> pow(Variant a, Variant b);

	static Ref<NDArray> abs(Variant a);
	static Ref<NDArray> sqrt(Variant a);

	static Ref<NDArray> exp(Variant a);
	static Ref<NDArray> log(Variant a);

	// Trigonometric functions.
	static Ref<NDArray> sin(Variant a);
	static Ref<NDArray> cos(Variant a);
	static Ref<NDArray> tan(Variant a);

	// Reductions.
	static Ref<NDArray> sum(Variant a, Variant axes);
	static Ref<NDArray> prod(Variant a, Variant axes);
	static Ref<NDArray> mean(Variant a, Variant axes);
	static Ref<NDArray> var(Variant a, Variant axes);
	static Ref<NDArray> std(Variant a, Variant axes);
	static Ref<NDArray> max(Variant a, Variant axes);
	static Ref<NDArray> min(Variant a, Variant axes);
};

VARIANT_ENUM_CAST(nd::DType);

#endif
