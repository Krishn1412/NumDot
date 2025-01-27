#include "ufunc_features.hpp"

#undef UNARY_TABLES
#define UNARY_TABLES(UFUNC_NAME)\
UFuncTableUnary UFUNC_NAME;

#undef BINARY_TABLES
#define BINARY_TABLES(UFUNC_NAME)\
UFuncTableBinary UFUNC_NAME; UFuncTableBinary UFUNC_NAME##_scalarRight; UFuncTableBinary UFUNC_NAME##_scalarLeft;

#undef BINARY_TABLES_COMMUTATIVE
#define BINARY_TABLES_COMMUTATIVE(UFUNC_NAME)\
UFuncTableBinary UFUNC_NAME; UFuncTableBinary UFUNC_NAME##_scalarRight;

namespace va::vfunc::tables {
	UNARY_TABLES(negative)
	UNARY_TABLES(sign)
	UNARY_TABLES(abs)
	UNARY_TABLES(square)
	UNARY_TABLES(sqrt)
	UNARY_TABLES(exp)
	UNARY_TABLES(log)
	UNARY_TABLES(rad2deg)
	UNARY_TABLES(deg2rad)

	BINARY_TABLES_COMMUTATIVE(add)
	BINARY_TABLES(subtract)
	BINARY_TABLES_COMMUTATIVE(multiply)
	BINARY_TABLES(divide)
	BINARY_TABLES(remainder)
	BINARY_TABLES(pow)
	BINARY_TABLES_COMMUTATIVE(minimum)
	BINARY_TABLES_COMMUTATIVE(maximum)

	UNARY_TABLES(sin)
	UNARY_TABLES(cos)
	UNARY_TABLES(tan)
	UNARY_TABLES(asin)
	UNARY_TABLES(acos)
	UNARY_TABLES(atan)
	BINARY_TABLES(atan2);
	UNARY_TABLES(sinh)
	UNARY_TABLES(cosh)
	UNARY_TABLES(tanh)
	UNARY_TABLES(asinh)
	UNARY_TABLES(acosh)
	UNARY_TABLES(atanh)

	UNARY_TABLES(ceil)
	UNARY_TABLES(floor)
	UNARY_TABLES(trunc)
	UNARY_TABLES(round)
	UNARY_TABLES(rint)

	UNARY_TABLES(logical_not)
	BINARY_TABLES_COMMUTATIVE(logical_and);
	BINARY_TABLES_COMMUTATIVE(logical_or);
	BINARY_TABLES_COMMUTATIVE(logical_xor);

	UNARY_TABLES(bitwise_not)
	BINARY_TABLES_COMMUTATIVE(bitwise_and);
	BINARY_TABLES_COMMUTATIVE(bitwise_or);
	BINARY_TABLES_COMMUTATIVE(bitwise_xor);
	BINARY_TABLES(bitwise_left_shift);
	BINARY_TABLES(bitwise_right_shift);

	BINARY_TABLES_COMMUTATIVE(equal);
	BINARY_TABLES_COMMUTATIVE(not_equal);
	BINARY_TABLES(less);
	BINARY_TABLES(less_equal);
	BINARY_TABLES(greater);
	BINARY_TABLES(greater_equal);
	UNARY_TABLES(isnan)
	UNARY_TABLES(isfinite)
	UNARY_TABLES(isinf)
}
