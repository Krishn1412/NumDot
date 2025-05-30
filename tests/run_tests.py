import enum
import pathlib
import importlib
from dataclasses import dataclass
from typing import Optional

import numpy as np
import pandas as pd
import os

import argparse
import subprocess

gen_folder = pathlib.Path(__file__).parent / "gen"
results_folder = gen_folder / "results"
results_folder.mkdir(parents=True, exist_ok=True)

dtype_names_nd: dict[np.dtype, str] = {
	np.dtype(np.int8): "Int8",
	np.dtype(np.int16): "Int16",
	np.dtype(np.int32): "Int32",
	np.dtype(np.int64): "Int64",
	np.dtype(np.uint8): "UInt8",
	np.dtype(np.uint16): "UInt16",
	np.dtype(np.uint32): "UInt32",
	np.dtype(np.uint64): "UInt64",
	np.dtype(np.bool): "Bool",
	np.dtype(np.float32): "Float32",
	np.dtype(np.float64): "Float64",
	np.dtype(np.complex64): "Complex64",
	np.dtype(np.complex128): "Complex128",
}

@dataclass
class Test:
	name: str
	np_code: Optional[str] = None
	nd_code: Optional[str] = None
	gd_code: Optional[str] = None

@dataclass
class Arg:
	pass

@dataclass
class Scalar(Arg):
	value: str
	dtype: np.dtype

@dataclass
class Full(Arg):
	size: int
	value: str
	dtype: np.dtype

@dataclass
class ARange(Arg):
	size: int
	start: int
	dtype: np.dtype

def as_file_path(string):
	if os.path.isfile(string):
		return pathlib.Path(string)
	else:
		raise FileNotFoundError(string)

def _func_to_gdscript(func, nin, dtype_out):
	# TODO This is a bad proxy for is_complex...
	is_complex = dtype_out == np.dtype(np.complex64) or dtype_out == np.dtype(np.complex128)

	if nin == 1:
		if func == "positive":
			return "+{}"
		if func == "negative":
			return "-{}"
		if func == "square":
			return "{1} * {1}"
		if func == "bitwise_not":
			return "~{}"
		if func == "logical_not":
			return "not {}"
		if func == "rad2deg":
			return "rad_to_deg({})"
		if func == "deg2rad":
			return "deg_to_rad({})"
		if func == "rint":
			return "round({})"
		if func == "trunc":
			return "int({})"
		if is_complex and (
				"sin" in func
				or "cos" in func
				or "tan" in func
				or func == "sqrt"
				or func == "exp"
				or func == "log"
		):
			return f"Vector2({func}({{1}}.x), {func}({{1}}.y))"
		if is_complex and func == "abs":
			return f"Vector2(sqrt({{1}}.x * {{1}}.x + {{1}}.y * {{1}}.y), 0)"  # TODO should be set in a float array to be fair
		return f"{func}({{}})"
	elif nin == 2:
		if func == "maximum":
			func = "max"
		if func == "minimum":
			func = "min"
		if is_complex and (
				func == "pow"
				or func == "max"
				or func == "min"
		):
			return f"Vector2({func}({{1}}.x, {{2}}.x), {func}({{1}}.y, {{2}}.y))"
		if func == "add":
			return "{} + {}"
		if func == "subtract":
			return "{} - {}"
		if func == "multiply":
			return "{} * {}"
		if func == "divide":
			return "{} / {}"
		if func == "greater":
			return "{} > {}"
		if func == "greater_equal":
			return "{} <= {}"
		if func == "less":
			return "{} < {}"
		if func == "less_equal":
			return "{} >= {}"
		if func == "equal":
			return "{} == {}"
		if func == "not_equal":
			return "{} != {}"
		if func == "logical_and":
			return "{} and {}"
		if func == "logical_or":
			return "{} or {}"
		if func == "logical_xor":
			return "bool({}) != bool({})"
		if func == "bitwise_and":
			return "{} & {}"
		if func == "bitwise_or":
			return "{} | {}"
		if func == "bitwise_xor":
			return "{} ^ {}"
		if func == "bitwise_left_shift":
			return "{} << {}"
		if func == "bitwise_right_shift":
			return "{} >> {}"
		if func == "matmul":
			return None
		if func == "remainder":
			if dtype_out in [np.dtype(np.float32), np.dtype(np.float64)]:
				return "fmod({}, {})"
			else:
				return "{} % {}"
		return f"{func}({{}}, {{}})"
	else:
		raise NotImplementedError

def func_to_gdscript(func, nin, dtype_out):
	create_string = _func_to_gdscript(func, nin, dtype_out)
	if create_string is None:
		return None

	if dtype_out == np.dtype(np.bool):
		# Bools don't have dedicated packed arrays, so we're using byte array
		create_string = f"int({create_string})"
	if "{}" in create_string:
		return "{} = " + create_string
	else:
		return "{0} = " + create_string

def make_test_func_np(name, args, stmt):
	return \
f"""
def {name}({args}):
\treturn {stmt}
"""

def make_test_func_np_benchmark(name, args, stmt):
	return \
f"""
def {name}({args}n):
\t_t0 = _timer()
\tfor _n in range(n):
\t\t{stmt}
\t_t1 = _timer()
\treturn _t1 - _t0
"""

def make_test_func_nd(name, args, stmt):
	return \
f"""
func __{name}({args}test_name):
\tvar result = {stmt}
\tTestUtil.store_result(result, "{results_folder}/" + test_name + ".npy")
"""

def make_test_func_nd_benchmark(name, args, stmt):
	return \
f"""
func __{name}({args}n):
\tvar _t0 = Time.get_ticks_usec()
\tfor _n in n:
\t\t{stmt}
\tvar _t1 = Time.get_ticks_usec()
\treturn _t1 - _t0
"""

def make_test_func_gd(name, args, dtype_out, stmt):
	# We don't count array creation to the time because the user may assign to the array itself, or pre-allocate.
	return \
f"""
func __{name}({args}n):
\tvar out = TestUtil.to_packed(nd.empty([x.size()], nd.{dtype_names_nd[dtype_out]}))
\tout.resize(x.size())
\tvar _t0 = Time.get_ticks_usec()
\tfor _n in n:
{stmt}
\tvar _t1 = Time.get_ticks_usec()
\treturn _t1 - _t0
"""

def make_np_call(function_name, kwargs: dict[str, Arg], n: str):
	def arg_to_str(arg: Arg):
		if isinstance(arg, ARange):
			return f"np.arange({arg.start}, {arg.start + arg.size}, dtype=np.{arg.dtype})"
		elif isinstance(arg, Full):
			return f"np.full([{arg.size}], fill_value={arg.value}, dtype=np.{arg.dtype})"
		elif isinstance(arg, Scalar):
			return f"np.array({arg.value}, dtype=np.{arg.dtype})"
		raise Exception()

	args_str = "".join(f'{name}={arg_to_str(value)}, ' for name, value in kwargs.items())
	return f"gen.tests.{function_name}({args_str}{n})"

def nd_arg_to_str(arg: Arg):
	if isinstance(arg, ARange):
		return f"nd.arange({arg.start}, {arg.start + arg.size}, 1, nd.{dtype_names_nd[arg.dtype]})"
	elif isinstance(arg, Full):
		return f"nd.full([{arg.size}], {arg.value}, nd.{dtype_names_nd[arg.dtype]})"
	elif isinstance(arg, Scalar):
		return f"nd.array({arg.value}, nd.{dtype_names_nd[arg.dtype]})"
	raise Exception()

def make_nd_call(function_name, test_number: int, kwargs: dict[str, Arg], n: str):
	args_str = "".join(f'{nd_arg_to_str(value)}, ' for name, value in kwargs.items())
	return f"\tprint(\"{test_number} \", __{function_name}({args_str}{n}))"

def make_gd_call(function_name, test_number: int, kwargs: dict[str, Arg], n: int):
	args_str = "".join(f'TestUtil.to_packed({nd_arg_to_str(value)}), ' for name, value in kwargs.items())
	return f"\tprint(\"{test_number} \", __{function_name}({args_str}{n}))"

TEST_UFUNCS = [
	"abs",
	"acos",
	"acosh",
	"add",
	# "all",
	# "angle",  # Not a ufunc apparently
	# "any",
	"asin",
	"asinh",
	"atan",
	"atan2",
	"atanh",
	"bitwise_and",
	"bitwise_left_shift",
	"bitwise_not",
	"bitwise_or",
	"bitwise_right_shift",
	"bitwise_xor",
	"ceil",
	# "clip",  # Not a ufunc apparently
	"cos",
	"cosh",
	# "count_nonzero",
	"deg2rad",
	"divide",
	# "dot",  # Not a ufunc apparently
	"equal",
	"exp",
	# "fft",  # Not a ufunc apparently
	"floor",
	"greater",
	"greater_equal",
	# "is_close",  # TODO Renamed
	# "is_finite",  # TODO Renamed
	# "is_inf",  # TODO Renamed
	# "is_nan",  # TODO Renamed
	"less",
	"less_equal",
	"log",
	"logical_and",
	"logical_not",
	"logical_or",
	"logical_xor",
	"matmul",
	# "max",
	"maximum",
	# "mean",  # TODO Not a ufunc
	# "median",  # TODO Not a ufunc
	# "min",  # TODO Not a ufunc
	"minimum",
	"multiply",
	"negative",
	# "norm",  # TODO Not a ufunc
	"not_equal",
	"positive",
	"pow",
	# "prod",  # TODO Not a ufunc
	"rad2deg",
	"remainder",
	"rint",
	# "round",  # TODO Not a ufunc
	"sign",
	"sin",
	"sinh",
	"sqrt",
	"square",
	# "std",  # TODO Not a ufunc
	"subtract",
	# "sum",  # TODO Not a ufunc
	"tan",
	"tanh",
	"trunc",
	# "var",  # TODO Not a ufunc
]

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument('--godot', type=as_file_path, required=True, help='Godot binary location')
arg_parser.add_argument('--benchmark', action="store_true", help='Run benchmark tests instead of unit tests.')
arg_parser.add_argument('--benchmark-numdot-only', action="store_true", help='Run benchmark tests instead of unit tests, but only NumDot.')

def main():
	cli_args = arg_parser.parse_args()
	godot_location = cli_args.godot
	is_benchmark_numdot_only = cli_args.benchmark_numdot_only
	is_benchmark = cli_args.benchmark or is_benchmark_numdot_only

	test_code_np = \
"""import numpy as np
import time
_timer = time.perf_counter
"""

	test_code_nd = "extends RefCounted\n\n"
	test_code_gd = "extends RefCounted\n\n"

	tests: list[Test] = []

	normal_n = 40_000  # for benchmarks
	added_functions = set()

	# TODO No support for reductions yet
	# TODO Should automatically (?) determine what NumDot has?
	for ufunc_name in TEST_UFUNCS:
		np_ufunc = getattr(np, ufunc_name)
		ufunc_args = "xyz"[:np_ufunc.nin]

		test_function_name_untyped = f"{ufunc_name}"

		args_str = "".join(f"{arg}, " for arg in ufunc_args)
		if not is_benchmark:
			test_code_np += make_test_func_np(test_function_name_untyped, args_str, f"np.{ufunc_name}({args_str})")
			test_code_nd += make_test_func_nd(test_function_name_untyped, args_str, f"nd.{ufunc_name}({args_str})")
		else:
			test_code_np += make_test_func_np_benchmark(test_function_name_untyped, args_str, f"np.{ufunc_name}({args_str})")
			test_code_nd += make_test_func_nd_benchmark(test_function_name_untyped, args_str, f"nd.{ufunc_name}({args_str})")

		for type_str in np_ufunc.types:
			dtype_in = np.dtype(type_str[0])
			dtype_out = np.dtype(type_str[-1])

			if dtype_in not in dtype_names_nd or dtype_out not in dtype_names_nd:
				continue  # Skip what NumDot doesn't support anyway.

			test_function_name_typed = f"{ufunc_name}_{dtype_in}"

			if test_function_name_typed in added_functions:
				continue  # TODO Figure out why
			added_functions.add(test_function_name_typed)

			has_gd_test = False
			if is_benchmark:
				gdscript_code = func_to_gdscript(ufunc_name, len(ufunc_args), dtype_out)
				if gdscript_code is not None:
					test_code = "\t\tfor i in x.size():\n\t\t\t"""
					test_code += gdscript_code.format("out[i]", *[f"{arg}[i]" for arg in ufunc_args])

					args_str_def = "".join(f"{arg}, " for arg in ufunc_args)
					test_code_gd += make_test_func_gd(test_function_name_typed, args_str_def, dtype_out, test_code)
					has_gd_test = True

			for s in [1, 50, 1_000, 20000]:
				test = Test(f"{ufunc_name}_{dtype_in}_{s}")
				can_use_arange = (
					dtype_in not in [np.dtype(bool), np.dtype(np.complex64), np.dtype(np.complex128)]
					and "atan" not in ufunc_name
					and "sinh" not in ufunc_name
					and "cosh" not in ufunc_name
					and "tanh" not in ufunc_name
				)
				test_kwargs = {
					arg: Scalar(value="5", dtype=dtype_in) if s == 1
						else ARange(start=1, size=s, dtype=dtype_in) if can_use_arange
						else Full(s, "0", dtype=dtype_in)
					for arg in ufunc_args
				}
				test_n = 20 * normal_n // s  # a bunch of iterations, but normalized by array size

				current_test_number = len(tests)
				test.np_code = make_np_call(test_function_name_untyped, test_kwargs, f"n={test_n}" if is_benchmark else f"")
				test.nd_code = make_nd_call(test_function_name_untyped, current_test_number, test_kwargs, str(test_n) if is_benchmark else f"\"{test.name}\"")
				if has_gd_test:
					test.gd_code = make_gd_call(test_function_name_typed, current_test_number, test_kwargs, test_n)

				tests.append(test)

	py_test_file_path = pathlib.Path(__file__).parent / "gen" / "tests.py"
	py_test_file_path.parent.mkdir(exist_ok=True)
	py_test_file_path.write_text(test_code_np)

	def run_godot_tests(text, test_prop):
		start_numdot_tests_string = "Starting NumDot tests..."
		text += \
f"""
func run():
\tprint("{start_numdot_tests_string}")
"""
		for test in tests:
			if test_code := getattr(test, test_prop):
				text += f"{test_code}\n"

		godot_test_file_path = pathlib.Path(__file__).parent.parent / "demo" / "tests" / "gen" / "tests.gd"
		godot_test_file_path.parent.mkdir(exist_ok=True)
		godot_test_file_path.write_text(text)

		print(f"Running {len(tests)} tests in godot...")

		demo_path = pathlib.Path(__file__).parent / ".." / "demo"
		gd_out = subprocess.check_output(
			[godot_location, "--path", demo_path, "--headless", "res://tests/run_tests.tscn", "--quit"],
			encoding='UTF-8'
		)
		if is_benchmark:
			gd_out_lines = gd_out[gd_out.index(start_numdot_tests_string):].split("\n")[1:]

			res = dict()
			for line in gd_out_lines:
				split = line.split(" ")
				if len(split) == 1:
					continue
				test_num = int(split[0])

				try:
					test_duration_s =  int(split[1]) / 1_000_000
				except:
					continue

				res[tests[test_num].name] = test_duration_s
			return res

	if not is_benchmark:
		for test_result_path in results_folder.glob("*.npy"):
			test_result_path.unlink()

		run_godot_tests(test_code_nd, "nd_code")

		print(f"Running {len(tests)} tests in python...")
		import gen.tests
		failed_tests_num = 0
		passed_tests_num = 0
		skipped_tests_num = 0
		for test in tests:
			try:
				test_result_np: np.ndarray = eval(test.np_code)
			except KeyboardInterrupt:
				raise
			except Exception as e:
				print(f"[{test.name}] Invalid test: {e}")
				skipped_tests_num += 1
				continue

			try:
				test_result_nd_path = results_folder / f"{test.name}.npy"
				if not test_result_nd_path.exists():
					print(f"[{test.name}] Failed in Godot")
					failed_tests_num += 1
					continue
				test_result_nd: np.ndarray = np.load(test_result_nd_path)
			except KeyboardInterrupt:
				raise
			except Exception as e:
				print(f"[{test.name}] Error loading npy file: {e}")
				failed_tests_num += 1
				continue

			try:
				if test_result_nd.shape != test_result_np.shape:
					print(f"[{test.name}] Shape unequal (nd: {test_result_nd.shape}, np: {test_result_np.shape})")
					failed_tests_num += 1
					continue
				if test_result_nd.dtype != test_result_np.dtype:
					print(f"[{test.name}] DType unequal (nd: {test_result_nd.dtype}, np: {test_result_np.dtype})")
					failed_tests_num += 1
					continue

				if test_result_np.dtype in [np.dtype(np.float32), np.dtype(np.float64), np.dtype(np.complex64), np.dtype(np.complex128)]:
					if not np.allclose(test_result_nd, test_result_np, equal_nan=True):
						diff = np.abs(test_result_nd - test_result_np)
						print(f"[{test.name}] Array unequal max-diff: {np.max(diff[~np.isnan(diff)])}")
						failed_tests_num += 1
						continue
				else:
					if not np.array_equal(test_result_nd, test_result_np):
						if test_result_np.dtype == np.dtype(np.bool):
							print(f"[{test.name}] Array unequal; {np.sum(test_result_nd != test_result_np)} mismatched bool elements")
						else:
							print(f"[{test.name}] Array unequal max-diff: {np.max(np.abs(test_result_nd - test_result_np))}")
						failed_tests_num += 1
						continue

				passed_tests_num += 1
			except KeyboardInterrupt:
				raise
			except Exception as e:
				print(f"[{test.name}] Error comparing test results: {e}")
				skipped_tests_num += 1
				continue

		print("Tests completed.")
		print(f"Passed: {passed_tests_num}; Failed: {failed_tests_num}; Skipped: {skipped_tests_num}")
	else:
		result_columns = dict()

		result_columns["numdot"] = run_godot_tests(test_code_nd, "nd_code")

		if not is_benchmark_numdot_only:
			result_columns["godot"] = run_godot_tests(test_code_gd, "gd_code")

			def run_numpy_benchmark():
				print(f"Running {len(tests)} tests in python...")
				import gen.tests
				results_np = dict()
				for test in tests:
					try:
						results_np[test.name] = eval(test.np_code)
					except KeyboardInterrupt:
						raise
					except Exception:
						continue
				return results_np

			result_columns["numpy"] = run_numpy_benchmark()

		pd.DataFrame(result_columns).to_csv(gen_folder / "benchmark.csv")
		print(gen_folder / "benchmark.csv")

if __name__ == "__main__":
	main()
