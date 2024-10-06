#ifndef ALLOCATE_H
#define ALLOCATE_H

#include "auto_defines.hpp"
#include "varray.hpp"

namespace va {
	std::shared_ptr<VArray> full(VScalar fill_value, shape_type shape);
	std::shared_ptr<VArray> empty(DType dtype, shape_type shape);
	std::shared_ptr<VArray> eye(DType dtype, shape_type shape, int k);

	std::shared_ptr<VArray> copy(const VRead& read);
	std::shared_ptr<VArray> copy_as_dtype(const VArray& other, DType dtype);
}

#endif //ALLOCATE_H
