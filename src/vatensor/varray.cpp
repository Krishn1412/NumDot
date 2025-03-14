#include "varray.h"

#include <cstddef>                         // for size_t
#include <stdexcept>                       // for runtime_error
#include <type_traits>                     // for decay_t
#include "xtensor/xoperation.hpp"          // for cast
#include "xtensor/xstrided_view_base.hpp"  // for strided_view_args

va::DType va::VArray::dtype() const {
    return DType(store.index());
}

size_t va::VArray::size() const {
    return std::visit([](auto&& carray) { return carray.size(); }, to_compute_variant());
}

size_t va::VArray::dimension() const {
    return std::visit([](auto&& carray) { return carray.dimension(); }, to_compute_variant());
}

va::VArray va::VArray::slice(const xt::xstrided_slice_vector &slices) const {
    return std::visit([slices, this](auto &store) -> VArray {
        xt::detail::strided_view_args<xt::detail::no_adj_strides_policy> args;
        args.fill_args(
            shape,
            strides,
            offset,
            layout,
            slices
        );

        auto result = VArray{
            store,  // Implicit copy
            std::move(args.new_shape),
            std::move(args.new_strides),
            args.new_offset,
            args.new_layout
        };

        return result;
    }, store);
}

void va::VArray::fill(VConstant value) const {
    return std::visit([](auto&& carray, auto value) {
        // Cast first to reduce number of combinations down the line.
        using T = typename std::decay_t<decltype(carray)>::value_type;
        carray.fill(static_cast<T>(value));
    }, to_compute_variant(), value);
}

void va::VArray::set_with_array(const VArray &value) const {
    return std::visit([](auto&& carray, auto&& cvalue) {
        using T = typename std::decay_t<decltype(carray)>::value_type;
        // Cast first to reduce number of combinations down the line.
        carray.computed_assign(xt::cast<T>(std::forward<decltype(cvalue)>(cvalue)));
    }, to_compute_variant(), value.to_compute_variant());
}

va::ComputeVariant va::VArray::to_compute_variant() const {
    return std::visit([this](const auto& store) -> ComputeVariant {
        return va::to_compute_variant(store, *this);
    }, store);
}

size_t va::VArray::size_of_array_in_bytes() const {
    return std::visit([](auto&& carray){
        using V = typename std::decay_t<decltype(carray)>::value_type;
        return carray.size() * sizeof(V);
    }, to_compute_variant());
}

va::VConstant va::dtype_to_variant(DType dtype) {
    switch (dtype) {
        case DType::Float32:
            return float_t();
        case DType::Float64:
            return double_t();
        case DType::Int8:
            return int8_t();
        case DType::Int16:
            return int16_t();
        case DType::Int32:
            return int32_t();
        case DType::Int64:
            return int64_t();
        case DType::UInt8:
            return uint8_t();
        case DType::UInt16:
            return uint16_t();
        case DType::UInt32:
            return uint32_t();
        case DType::UInt64:
            return int64_t();
        default:
            throw std::runtime_error("Invalid dtype.");
    }
}

size_t va::size_of_dtype_in_bytes(DType dtype) {
    return std::visit([](auto dtype){
        return sizeof(dtype);
    }, dtype_to_variant(dtype));
}

va::VConstant va::constant_to_dtype(VConstant v, DType dtype) {
    return std::visit([](auto v, const auto t) -> va::VConstant {
        using T = std::decay_t<decltype(t)>;
        return static_cast<T>(v);
    }, v, dtype_to_variant(dtype));
}

va::VConstant va::VArray::to_single_value() const {
    return std::visit([](const auto& carray) -> va::VConstant {
        if (carray.size() != 1) {
            throw std::runtime_error("Expected a single element after slicing.");
        }
        return *carray.data();
        // TODO I expected this to work, but it doesn't. See https://xtensor.readthedocs.io/en/latest/indices.html#operator
        // But at least the above is a view, so no copy is made.
        // return V(array[slice]);
    }, to_compute_variant());
}
