#ifndef VATENSOR_UFUNC_CONFIG_HPP
#define VATENSOR_UFUNC_CONFIG_HPP

#include "util.hpp"
#include "vatensor/vcall.hpp"
#include "vatensor/vfunc/tables.hpp"

namespace va {
	DEFINE_VFUNC_CALLER_UNARY0(negative)
	DEFINE_VFUNC_CALLER_UNARY0(sign)
	DEFINE_VFUNC_CALLER_UNARY0(abs)
	DEFINE_VFUNC_CALLER_UNARY0(square)
	DEFINE_VFUNC_CALLER_UNARY0(sqrt)
	DEFINE_VFUNC_CALLER_UNARY0(exp)
	DEFINE_VFUNC_CALLER_UNARY0(log)
	DEFINE_VFUNC_CALLER_UNARY0(rad2deg)
	DEFINE_VFUNC_CALLER_UNARY0(deg2rad)

	DEFINE_VFUNC_CALLER_UNARY0(conjugate)

	DEFINE_VFUNC_CALLER_BINARY0(add)
	DEFINE_VFUNC_CALLER_BINARY0(subtract)
	DEFINE_VFUNC_CALLER_BINARY0(multiply)
	DEFINE_VFUNC_CALLER_BINARY0(divide)
	DEFINE_VFUNC_CALLER_BINARY0(remainder)
	DEFINE_VFUNC_CALLER_BINARY0(pow)
	DEFINE_VFUNC_CALLER_BINARY0(minimum)
	DEFINE_VFUNC_CALLER_BINARY0(maximum)

	DEFINE_RFUNC_CALLER_UNARY0(sum)
	DEFINE_RFUNC_CALLER_UNARY0(prod)

	DEFINE_VFUNC_CALLER_UNARY0(sin)
	DEFINE_VFUNC_CALLER_UNARY0(cos)
	DEFINE_VFUNC_CALLER_UNARY0(tan)
	DEFINE_VFUNC_CALLER_UNARY0(asin)
	DEFINE_VFUNC_CALLER_UNARY0(acos)
	DEFINE_VFUNC_CALLER_UNARY0(atan)
	DEFINE_VFUNC_CALLER_BINARY0(atan2)
	DEFINE_VFUNC_CALLER_UNARY0(sinh)
	DEFINE_VFUNC_CALLER_UNARY0(cosh)
	DEFINE_VFUNC_CALLER_UNARY0(tanh)
	DEFINE_VFUNC_CALLER_UNARY0(asinh)
	DEFINE_VFUNC_CALLER_UNARY0(acosh)
	DEFINE_VFUNC_CALLER_UNARY0(atanh)

	DEFINE_VFUNC_CALLER_UNARY0(ceil)
	DEFINE_VFUNC_CALLER_UNARY0(floor)
	DEFINE_VFUNC_CALLER_UNARY0(trunc)
	DEFINE_VFUNC_CALLER_UNARY0(round)
	DEFINE_VFUNC_CALLER_UNARY0(rint)

	DEFINE_VFUNC_CALLER_UNARY0(logical_not)
	DEFINE_VFUNC_CALLER_BINARY0(logical_and)
	DEFINE_VFUNC_CALLER_BINARY0(logical_or)
	DEFINE_VFUNC_CALLER_BINARY0(logical_xor)

	DEFINE_VFUNC_CALLER_UNARY0(bitwise_not)
	DEFINE_VFUNC_CALLER_BINARY0(bitwise_and)
	DEFINE_VFUNC_CALLER_BINARY0(bitwise_or)
	DEFINE_VFUNC_CALLER_BINARY0(bitwise_xor)
	DEFINE_VFUNC_CALLER_BINARY0(bitwise_left_shift)
	DEFINE_VFUNC_CALLER_BINARY0(bitwise_right_shift)

	DEFINE_VFUNC_CALLER_BINARY0(equal)
	DEFINE_VFUNC_CALLER_BINARY0(not_equal)
	DEFINE_VFUNC_CALLER_BINARY0(less)
	DEFINE_VFUNC_CALLER_BINARY0(less_equal)
	DEFINE_VFUNC_CALLER_BINARY0(greater)
	DEFINE_VFUNC_CALLER_BINARY0(greater_equal)

	DEFINE_VFUNC_CALLER_UNARY0(isnan)
	DEFINE_VFUNC_CALLER_UNARY0(isfinite)
	DEFINE_VFUNC_CALLER_UNARY0(isinf)
	DEFINE_UFUNC_CALLER_BINARY3(is_close, double, double, bool)
}

#endif //VATENSOR_UFUNC_CONFIG_HPP
