#include "vsignal.hpp"

#include "create.hpp"
#include "vcompute.hpp"
#include "xtensor-signal/fft.hpp"
#include "vatensor/vfunc/entrypoints.hpp"

std::shared_ptr<va::VArray> va::fft_freq(VStoreAllocator& allocator, std::size_t n, double_t d) {
	// From NumPy docs:
	// f = [0, 1, ...,   n/2-1,     -n/2, ..., -1] / (d*n)   if n is even
	// f = [0, 1, ..., (n-1)/2, -(n-1)/2, ..., -1] / (d*n)   if n is odd

	auto array = va::empty(allocator, DType::Float64, shape_type { n });
	auto data = std::get<compute_case<double_t*>>(array->data);

	const auto center_idx = n / 2;
	const double_t factor = d * static_cast<double_t>(n);

	for (int i = 0; i < center_idx; ++i) data(i) = i / factor;
	for (int i = 1; i <= center_idx; ++i) data(n - i) = -i / factor;

	return array;
}
