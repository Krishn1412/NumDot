#include "vcall.hpp"

#include "array_store.hpp"
#include "create.hpp"

using namespace va;

VData& va::evaluate_target(VStoreAllocator& allocator, const VArrayTarget& target, DType dtype, const shape_type& result_shape, std::shared_ptr<VArray>& temp) {
	if (const auto target_data = std::get_if<VData*>(&target)) {
		VData& data = **target_data;
		if (!xt::broadcastable(result_shape, va::shape(data))) {
			throw std::runtime_error("Incompatible shape of tensor destination");
		}
		if (va::dtype(data) == dtype) {
			return data;
		}

		temp = va::empty(allocator, dtype, result_shape);
		return temp->data;
	}
	else {
		auto& target_varray = *std::get<std::shared_ptr<VArray>*>(target);
		target_varray = va::empty(allocator, dtype, result_shape);
		return target_varray->data;
	}
}

void va::shape_reduce_axes(va::shape_type& shape, const va::axes_type& axes) {
	bool mask[shape.size()];
	std::fill_n(mask, shape.size(), true);

	for (const auto axis : axes)
	{
		const size_t axis_normal = va::util::normalize_axis(axis, shape.size());
		if (!mask[axis_normal]) {
			throw std::runtime_error("Duplicate value in 'axis'.");
		}
		mask[axis_normal] = false;
	}

	shape.erase(
		std::remove_if(
			shape.begin(),
			shape.end(),
			[&mask, index = 0](int) mutable { return !mask[index++]; }
		),
		shape.end()
	);
}

va::shape_type va::combined_shape(const shape_type& a_shape, const shape_type& b_shape) {
	va::shape_type result_shape = shape_type(std::max(a_shape.size(), b_shape.size()));
	std::fill_n(result_shape.begin(), result_shape.size(), std::numeric_limits<shape_type::value_type>::max());

	xt::broadcast_shape(a_shape, result_shape);
	xt::broadcast_shape(b_shape, result_shape);

	return result_shape;
}
