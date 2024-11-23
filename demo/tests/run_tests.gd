extends Node


func __square(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.square(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __sqrt(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.sqrt(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __abs(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.abs(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __sin(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.sin(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __cos(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.cos(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __tan(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.tan(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __asin(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.asin(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __acos(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.acos(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __atan(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.atan(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __sinh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.sinh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __cosh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.cosh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __tanh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.tanh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __asinh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.asinh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __acosh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.acosh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __atanh(x, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.atanh(x, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __add(x, y, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.add(x, y, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __subtract(x, y, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.subtract(x, y, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __multiply(x, y, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.multiply(x, y, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __divide(x, y, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.divide(x, y, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func __pow(x, y, n):
	var _t0 = Time.get_ticks_usec()
	for _n in n:
		nd.pow(x, y, )
	var _t1 = Time.get_ticks_usec()
	return _t1 - _t0

func _ready():
	print("Starting NumDot tests...")
	print(0, __square(nd.full([50], 0.5, nd.Int8), 800))
	print(1, __square(nd.full([1000], 0.5, nd.Int8), 40))
	print(2, __square(nd.full([20000], 0.5, nd.Int8), 2))
	print(3, __square(nd.full([50], 0.5, nd.UInt8), 800))
	print(4, __square(nd.full([1000], 0.5, nd.UInt8), 40))
	print(5, __square(nd.full([20000], 0.5, nd.UInt8), 2))
	print(6, __square(nd.full([50], 0.5, nd.Int16), 800))
	print(7, __square(nd.full([1000], 0.5, nd.Int16), 40))
	print(8, __square(nd.full([20000], 0.5, nd.Int16), 2))
	print(9, __square(nd.full([50], 0.5, nd.UInt16), 800))
	print(10, __square(nd.full([1000], 0.5, nd.UInt16), 40))
	print(11, __square(nd.full([20000], 0.5, nd.UInt16), 2))
	print(12, __square(nd.full([50], 0.5, nd.Int32), 800))
	print(13, __square(nd.full([1000], 0.5, nd.Int32), 40))
	print(14, __square(nd.full([20000], 0.5, nd.Int32), 2))
	print(15, __square(nd.full([50], 0.5, nd.UInt32), 800))
	print(16, __square(nd.full([1000], 0.5, nd.UInt32), 40))
	print(17, __square(nd.full([20000], 0.5, nd.UInt32), 2))
	print(18, __square(nd.full([50], 0.5, nd.Int64), 800))
	print(19, __square(nd.full([1000], 0.5, nd.Int64), 40))
	print(20, __square(nd.full([20000], 0.5, nd.Int64), 2))
	print(21, __square(nd.full([50], 0.5, nd.UInt64), 800))
	print(22, __square(nd.full([1000], 0.5, nd.UInt64), 40))
	print(23, __square(nd.full([20000], 0.5, nd.UInt64), 2))
	print(24, __square(nd.full([50], 0.5, nd.Int64), 800))
	print(25, __square(nd.full([1000], 0.5, nd.Int64), 40))
	print(26, __square(nd.full([20000], 0.5, nd.Int64), 2))
	print(27, __square(nd.full([50], 0.5, nd.UInt64), 800))
	print(28, __square(nd.full([1000], 0.5, nd.UInt64), 40))
	print(29, __square(nd.full([20000], 0.5, nd.UInt64), 2))
	print(30, __square(nd.full([50], 0.5, nd.Complex64), 800))
	print(31, __square(nd.full([1000], 0.5, nd.Complex64), 40))
	print(32, __square(nd.full([20000], 0.5, nd.Complex64), 2))
	print(33, __square(nd.full([50], 0.5, nd.Complex128), 800))
	print(34, __square(nd.full([1000], 0.5, nd.Complex128), 40))
	print(35, __square(nd.full([20000], 0.5, nd.Complex128), 2))
	print(36, __sqrt(nd.full([50], 0.5, nd.Complex64), 800))
	print(37, __sqrt(nd.full([1000], 0.5, nd.Complex64), 40))
	print(38, __sqrt(nd.full([20000], 0.5, nd.Complex64), 2))
	print(39, __sqrt(nd.full([50], 0.5, nd.Complex128), 800))
	print(40, __sqrt(nd.full([1000], 0.5, nd.Complex128), 40))
	print(41, __sqrt(nd.full([20000], 0.5, nd.Complex128), 2))
	print(42, __abs(nd.full([50], 0.5, nd.Bool), 800))
	print(43, __abs(nd.full([1000], 0.5, nd.Bool), 40))
	print(44, __abs(nd.full([20000], 0.5, nd.Bool), 2))
	print(45, __abs(nd.full([50], 0.5, nd.Int8), 800))
	print(46, __abs(nd.full([1000], 0.5, nd.Int8), 40))
	print(47, __abs(nd.full([20000], 0.5, nd.Int8), 2))
	print(48, __abs(nd.full([50], 0.5, nd.UInt8), 800))
	print(49, __abs(nd.full([1000], 0.5, nd.UInt8), 40))
	print(50, __abs(nd.full([20000], 0.5, nd.UInt8), 2))
	print(51, __abs(nd.full([50], 0.5, nd.Int16), 800))
	print(52, __abs(nd.full([1000], 0.5, nd.Int16), 40))
	print(53, __abs(nd.full([20000], 0.5, nd.Int16), 2))
	print(54, __abs(nd.full([50], 0.5, nd.UInt16), 800))
	print(55, __abs(nd.full([1000], 0.5, nd.UInt16), 40))
	print(56, __abs(nd.full([20000], 0.5, nd.UInt16), 2))
	print(57, __abs(nd.full([50], 0.5, nd.Int32), 800))
	print(58, __abs(nd.full([1000], 0.5, nd.Int32), 40))
	print(59, __abs(nd.full([20000], 0.5, nd.Int32), 2))
	print(60, __abs(nd.full([50], 0.5, nd.UInt32), 800))
	print(61, __abs(nd.full([1000], 0.5, nd.UInt32), 40))
	print(62, __abs(nd.full([20000], 0.5, nd.UInt32), 2))
	print(63, __abs(nd.full([50], 0.5, nd.Int64), 800))
	print(64, __abs(nd.full([1000], 0.5, nd.Int64), 40))
	print(65, __abs(nd.full([20000], 0.5, nd.Int64), 2))
	print(66, __abs(nd.full([50], 0.5, nd.UInt64), 800))
	print(67, __abs(nd.full([1000], 0.5, nd.UInt64), 40))
	print(68, __abs(nd.full([20000], 0.5, nd.UInt64), 2))
	print(69, __abs(nd.full([50], 0.5, nd.Int64), 800))
	print(70, __abs(nd.full([1000], 0.5, nd.Int64), 40))
	print(71, __abs(nd.full([20000], 0.5, nd.Int64), 2))
	print(72, __abs(nd.full([50], 0.5, nd.UInt64), 800))
	print(73, __abs(nd.full([1000], 0.5, nd.UInt64), 40))
	print(74, __abs(nd.full([20000], 0.5, nd.UInt64), 2))
	print(75, __sin(nd.full([50], 0.5, nd.Complex64), 800))
	print(76, __sin(nd.full([1000], 0.5, nd.Complex64), 40))
	print(77, __sin(nd.full([20000], 0.5, nd.Complex64), 2))
	print(78, __sin(nd.full([50], 0.5, nd.Complex128), 800))
	print(79, __sin(nd.full([1000], 0.5, nd.Complex128), 40))
	print(80, __sin(nd.full([20000], 0.5, nd.Complex128), 2))
	print(81, __cos(nd.full([50], 0.5, nd.Complex64), 800))
	print(82, __cos(nd.full([1000], 0.5, nd.Complex64), 40))
	print(83, __cos(nd.full([20000], 0.5, nd.Complex64), 2))
	print(84, __cos(nd.full([50], 0.5, nd.Complex128), 800))
	print(85, __cos(nd.full([1000], 0.5, nd.Complex128), 40))
	print(86, __cos(nd.full([20000], 0.5, nd.Complex128), 2))
	print(87, __tan(nd.full([50], 0.5, nd.Complex64), 800))
	print(88, __tan(nd.full([1000], 0.5, nd.Complex64), 40))
	print(89, __tan(nd.full([20000], 0.5, nd.Complex64), 2))
	print(90, __tan(nd.full([50], 0.5, nd.Complex128), 800))
	print(91, __tan(nd.full([1000], 0.5, nd.Complex128), 40))
	print(92, __tan(nd.full([20000], 0.5, nd.Complex128), 2))
	print(93, __asin(nd.full([50], 0.5, nd.Complex64), 800))
	print(94, __asin(nd.full([1000], 0.5, nd.Complex64), 40))
	print(95, __asin(nd.full([20000], 0.5, nd.Complex64), 2))
	print(96, __asin(nd.full([50], 0.5, nd.Complex128), 800))
	print(97, __asin(nd.full([1000], 0.5, nd.Complex128), 40))
	print(98, __asin(nd.full([20000], 0.5, nd.Complex128), 2))
	print(99, __acos(nd.full([50], 0.5, nd.Complex64), 800))
	print(100, __acos(nd.full([1000], 0.5, nd.Complex64), 40))
	print(101, __acos(nd.full([20000], 0.5, nd.Complex64), 2))
	print(102, __acos(nd.full([50], 0.5, nd.Complex128), 800))
	print(103, __acos(nd.full([1000], 0.5, nd.Complex128), 40))
	print(104, __acos(nd.full([20000], 0.5, nd.Complex128), 2))
	print(105, __atan(nd.full([50], 0.5, nd.Complex64), 800))
	print(106, __atan(nd.full([1000], 0.5, nd.Complex64), 40))
	print(107, __atan(nd.full([20000], 0.5, nd.Complex64), 2))
	print(108, __atan(nd.full([50], 0.5, nd.Complex128), 800))
	print(109, __atan(nd.full([1000], 0.5, nd.Complex128), 40))
	print(110, __atan(nd.full([20000], 0.5, nd.Complex128), 2))
	print(111, __sinh(nd.full([50], 0.5, nd.Complex64), 800))
	print(112, __sinh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(113, __sinh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(114, __sinh(nd.full([50], 0.5, nd.Complex128), 800))
	print(115, __sinh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(116, __sinh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(117, __cosh(nd.full([50], 0.5, nd.Complex64), 800))
	print(118, __cosh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(119, __cosh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(120, __cosh(nd.full([50], 0.5, nd.Complex128), 800))
	print(121, __cosh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(122, __cosh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(123, __tanh(nd.full([50], 0.5, nd.Complex64), 800))
	print(124, __tanh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(125, __tanh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(126, __tanh(nd.full([50], 0.5, nd.Complex128), 800))
	print(127, __tanh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(128, __tanh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(129, __asinh(nd.full([50], 0.5, nd.Complex64), 800))
	print(130, __asinh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(131, __asinh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(132, __asinh(nd.full([50], 0.5, nd.Complex128), 800))
	print(133, __asinh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(134, __asinh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(135, __acosh(nd.full([50], 0.5, nd.Complex64), 800))
	print(136, __acosh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(137, __acosh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(138, __acosh(nd.full([50], 0.5, nd.Complex128), 800))
	print(139, __acosh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(140, __acosh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(141, __atanh(nd.full([50], 0.5, nd.Complex64), 800))
	print(142, __atanh(nd.full([1000], 0.5, nd.Complex64), 40))
	print(143, __atanh(nd.full([20000], 0.5, nd.Complex64), 2))
	print(144, __atanh(nd.full([50], 0.5, nd.Complex128), 800))
	print(145, __atanh(nd.full([1000], 0.5, nd.Complex128), 40))
	print(146, __atanh(nd.full([20000], 0.5, nd.Complex128), 2))
	print(147, __add(nd.full([50], 0.5, nd.Bool), nd.full([50], 0.5, nd.Bool), 800))
	print(148, __add(nd.full([1000], 0.5, nd.Bool), nd.full([1000], 0.5, nd.Bool), 40))
	print(149, __add(nd.full([20000], 0.5, nd.Bool), nd.full([20000], 0.5, nd.Bool), 2))
	print(150, __add(nd.full([50], 0.5, nd.Int8), nd.full([50], 0.5, nd.Int8), 800))
	print(151, __add(nd.full([1000], 0.5, nd.Int8), nd.full([1000], 0.5, nd.Int8), 40))
	print(152, __add(nd.full([20000], 0.5, nd.Int8), nd.full([20000], 0.5, nd.Int8), 2))
	print(153, __add(nd.full([50], 0.5, nd.UInt8), nd.full([50], 0.5, nd.UInt8), 800))
	print(154, __add(nd.full([1000], 0.5, nd.UInt8), nd.full([1000], 0.5, nd.UInt8), 40))
	print(155, __add(nd.full([20000], 0.5, nd.UInt8), nd.full([20000], 0.5, nd.UInt8), 2))
	print(156, __add(nd.full([50], 0.5, nd.Int16), nd.full([50], 0.5, nd.Int16), 800))
	print(157, __add(nd.full([1000], 0.5, nd.Int16), nd.full([1000], 0.5, nd.Int16), 40))
	print(158, __add(nd.full([20000], 0.5, nd.Int16), nd.full([20000], 0.5, nd.Int16), 2))
	print(159, __add(nd.full([50], 0.5, nd.UInt16), nd.full([50], 0.5, nd.UInt16), 800))
	print(160, __add(nd.full([1000], 0.5, nd.UInt16), nd.full([1000], 0.5, nd.UInt16), 40))
	print(161, __add(nd.full([20000], 0.5, nd.UInt16), nd.full([20000], 0.5, nd.UInt16), 2))
	print(162, __add(nd.full([50], 0.5, nd.Int32), nd.full([50], 0.5, nd.Int32), 800))
	print(163, __add(nd.full([1000], 0.5, nd.Int32), nd.full([1000], 0.5, nd.Int32), 40))
	print(164, __add(nd.full([20000], 0.5, nd.Int32), nd.full([20000], 0.5, nd.Int32), 2))
	print(165, __add(nd.full([50], 0.5, nd.UInt32), nd.full([50], 0.5, nd.UInt32), 800))
	print(166, __add(nd.full([1000], 0.5, nd.UInt32), nd.full([1000], 0.5, nd.UInt32), 40))
	print(167, __add(nd.full([20000], 0.5, nd.UInt32), nd.full([20000], 0.5, nd.UInt32), 2))
	print(168, __add(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(169, __add(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(170, __add(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(171, __add(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(172, __add(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(173, __add(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(174, __add(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(175, __add(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(176, __add(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(177, __add(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(178, __add(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(179, __add(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(180, __add(nd.full([50], 0.5, nd.Complex64), nd.full([50], 0.5, nd.Complex64), 800))
	print(181, __add(nd.full([1000], 0.5, nd.Complex64), nd.full([1000], 0.5, nd.Complex64), 40))
	print(182, __add(nd.full([20000], 0.5, nd.Complex64), nd.full([20000], 0.5, nd.Complex64), 2))
	print(183, __add(nd.full([50], 0.5, nd.Complex128), nd.full([50], 0.5, nd.Complex128), 800))
	print(184, __add(nd.full([1000], 0.5, nd.Complex128), nd.full([1000], 0.5, nd.Complex128), 40))
	print(185, __add(nd.full([20000], 0.5, nd.Complex128), nd.full([20000], 0.5, nd.Complex128), 2))
	print(186, __subtract(nd.full([50], 0.5, nd.Int8), nd.full([50], 0.5, nd.Int8), 800))
	print(187, __subtract(nd.full([1000], 0.5, nd.Int8), nd.full([1000], 0.5, nd.Int8), 40))
	print(188, __subtract(nd.full([20000], 0.5, nd.Int8), nd.full([20000], 0.5, nd.Int8), 2))
	print(189, __subtract(nd.full([50], 0.5, nd.UInt8), nd.full([50], 0.5, nd.UInt8), 800))
	print(190, __subtract(nd.full([1000], 0.5, nd.UInt8), nd.full([1000], 0.5, nd.UInt8), 40))
	print(191, __subtract(nd.full([20000], 0.5, nd.UInt8), nd.full([20000], 0.5, nd.UInt8), 2))
	print(192, __subtract(nd.full([50], 0.5, nd.Int16), nd.full([50], 0.5, nd.Int16), 800))
	print(193, __subtract(nd.full([1000], 0.5, nd.Int16), nd.full([1000], 0.5, nd.Int16), 40))
	print(194, __subtract(nd.full([20000], 0.5, nd.Int16), nd.full([20000], 0.5, nd.Int16), 2))
	print(195, __subtract(nd.full([50], 0.5, nd.UInt16), nd.full([50], 0.5, nd.UInt16), 800))
	print(196, __subtract(nd.full([1000], 0.5, nd.UInt16), nd.full([1000], 0.5, nd.UInt16), 40))
	print(197, __subtract(nd.full([20000], 0.5, nd.UInt16), nd.full([20000], 0.5, nd.UInt16), 2))
	print(198, __subtract(nd.full([50], 0.5, nd.Int32), nd.full([50], 0.5, nd.Int32), 800))
	print(199, __subtract(nd.full([1000], 0.5, nd.Int32), nd.full([1000], 0.5, nd.Int32), 40))
	print(200, __subtract(nd.full([20000], 0.5, nd.Int32), nd.full([20000], 0.5, nd.Int32), 2))
	print(201, __subtract(nd.full([50], 0.5, nd.UInt32), nd.full([50], 0.5, nd.UInt32), 800))
	print(202, __subtract(nd.full([1000], 0.5, nd.UInt32), nd.full([1000], 0.5, nd.UInt32), 40))
	print(203, __subtract(nd.full([20000], 0.5, nd.UInt32), nd.full([20000], 0.5, nd.UInt32), 2))
	print(204, __subtract(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(205, __subtract(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(206, __subtract(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(207, __subtract(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(208, __subtract(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(209, __subtract(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(210, __subtract(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(211, __subtract(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(212, __subtract(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(213, __subtract(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(214, __subtract(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(215, __subtract(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(216, __subtract(nd.full([50], 0.5, nd.Complex64), nd.full([50], 0.5, nd.Complex64), 800))
	print(217, __subtract(nd.full([1000], 0.5, nd.Complex64), nd.full([1000], 0.5, nd.Complex64), 40))
	print(218, __subtract(nd.full([20000], 0.5, nd.Complex64), nd.full([20000], 0.5, nd.Complex64), 2))
	print(219, __subtract(nd.full([50], 0.5, nd.Complex128), nd.full([50], 0.5, nd.Complex128), 800))
	print(220, __subtract(nd.full([1000], 0.5, nd.Complex128), nd.full([1000], 0.5, nd.Complex128), 40))
	print(221, __subtract(nd.full([20000], 0.5, nd.Complex128), nd.full([20000], 0.5, nd.Complex128), 2))
	print(222, __multiply(nd.full([50], 0.5, nd.Bool), nd.full([50], 0.5, nd.Bool), 800))
	print(223, __multiply(nd.full([1000], 0.5, nd.Bool), nd.full([1000], 0.5, nd.Bool), 40))
	print(224, __multiply(nd.full([20000], 0.5, nd.Bool), nd.full([20000], 0.5, nd.Bool), 2))
	print(225, __multiply(nd.full([50], 0.5, nd.Int8), nd.full([50], 0.5, nd.Int8), 800))
	print(226, __multiply(nd.full([1000], 0.5, nd.Int8), nd.full([1000], 0.5, nd.Int8), 40))
	print(227, __multiply(nd.full([20000], 0.5, nd.Int8), nd.full([20000], 0.5, nd.Int8), 2))
	print(228, __multiply(nd.full([50], 0.5, nd.UInt8), nd.full([50], 0.5, nd.UInt8), 800))
	print(229, __multiply(nd.full([1000], 0.5, nd.UInt8), nd.full([1000], 0.5, nd.UInt8), 40))
	print(230, __multiply(nd.full([20000], 0.5, nd.UInt8), nd.full([20000], 0.5, nd.UInt8), 2))
	print(231, __multiply(nd.full([50], 0.5, nd.Int16), nd.full([50], 0.5, nd.Int16), 800))
	print(232, __multiply(nd.full([1000], 0.5, nd.Int16), nd.full([1000], 0.5, nd.Int16), 40))
	print(233, __multiply(nd.full([20000], 0.5, nd.Int16), nd.full([20000], 0.5, nd.Int16), 2))
	print(234, __multiply(nd.full([50], 0.5, nd.UInt16), nd.full([50], 0.5, nd.UInt16), 800))
	print(235, __multiply(nd.full([1000], 0.5, nd.UInt16), nd.full([1000], 0.5, nd.UInt16), 40))
	print(236, __multiply(nd.full([20000], 0.5, nd.UInt16), nd.full([20000], 0.5, nd.UInt16), 2))
	print(237, __multiply(nd.full([50], 0.5, nd.Int32), nd.full([50], 0.5, nd.Int32), 800))
	print(238, __multiply(nd.full([1000], 0.5, nd.Int32), nd.full([1000], 0.5, nd.Int32), 40))
	print(239, __multiply(nd.full([20000], 0.5, nd.Int32), nd.full([20000], 0.5, nd.Int32), 2))
	print(240, __multiply(nd.full([50], 0.5, nd.UInt32), nd.full([50], 0.5, nd.UInt32), 800))
	print(241, __multiply(nd.full([1000], 0.5, nd.UInt32), nd.full([1000], 0.5, nd.UInt32), 40))
	print(242, __multiply(nd.full([20000], 0.5, nd.UInt32), nd.full([20000], 0.5, nd.UInt32), 2))
	print(243, __multiply(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(244, __multiply(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(245, __multiply(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(246, __multiply(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(247, __multiply(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(248, __multiply(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(249, __multiply(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(250, __multiply(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(251, __multiply(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(252, __multiply(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(253, __multiply(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(254, __multiply(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(255, __multiply(nd.full([50], 0.5, nd.Complex64), nd.full([50], 0.5, nd.Complex64), 800))
	print(256, __multiply(nd.full([1000], 0.5, nd.Complex64), nd.full([1000], 0.5, nd.Complex64), 40))
	print(257, __multiply(nd.full([20000], 0.5, nd.Complex64), nd.full([20000], 0.5, nd.Complex64), 2))
	print(258, __multiply(nd.full([50], 0.5, nd.Complex128), nd.full([50], 0.5, nd.Complex128), 800))
	print(259, __multiply(nd.full([1000], 0.5, nd.Complex128), nd.full([1000], 0.5, nd.Complex128), 40))
	print(260, __multiply(nd.full([20000], 0.5, nd.Complex128), nd.full([20000], 0.5, nd.Complex128), 2))
	print(261, __divide(nd.full([50], 0.5, nd.Complex64), nd.full([50], 0.5, nd.Complex64), 800))
	print(262, __divide(nd.full([1000], 0.5, nd.Complex64), nd.full([1000], 0.5, nd.Complex64), 40))
	print(263, __divide(nd.full([20000], 0.5, nd.Complex64), nd.full([20000], 0.5, nd.Complex64), 2))
	print(264, __divide(nd.full([50], 0.5, nd.Complex128), nd.full([50], 0.5, nd.Complex128), 800))
	print(265, __divide(nd.full([1000], 0.5, nd.Complex128), nd.full([1000], 0.5, nd.Complex128), 40))
	print(266, __divide(nd.full([20000], 0.5, nd.Complex128), nd.full([20000], 0.5, nd.Complex128), 2))
	print(267, __pow(nd.full([50], 0.5, nd.Int8), nd.full([50], 0.5, nd.Int8), 800))
	print(268, __pow(nd.full([1000], 0.5, nd.Int8), nd.full([1000], 0.5, nd.Int8), 40))
	print(269, __pow(nd.full([20000], 0.5, nd.Int8), nd.full([20000], 0.5, nd.Int8), 2))
	print(270, __pow(nd.full([50], 0.5, nd.UInt8), nd.full([50], 0.5, nd.UInt8), 800))
	print(271, __pow(nd.full([1000], 0.5, nd.UInt8), nd.full([1000], 0.5, nd.UInt8), 40))
	print(272, __pow(nd.full([20000], 0.5, nd.UInt8), nd.full([20000], 0.5, nd.UInt8), 2))
	print(273, __pow(nd.full([50], 0.5, nd.Int16), nd.full([50], 0.5, nd.Int16), 800))
	print(274, __pow(nd.full([1000], 0.5, nd.Int16), nd.full([1000], 0.5, nd.Int16), 40))
	print(275, __pow(nd.full([20000], 0.5, nd.Int16), nd.full([20000], 0.5, nd.Int16), 2))
	print(276, __pow(nd.full([50], 0.5, nd.UInt16), nd.full([50], 0.5, nd.UInt16), 800))
	print(277, __pow(nd.full([1000], 0.5, nd.UInt16), nd.full([1000], 0.5, nd.UInt16), 40))
	print(278, __pow(nd.full([20000], 0.5, nd.UInt16), nd.full([20000], 0.5, nd.UInt16), 2))
	print(279, __pow(nd.full([50], 0.5, nd.Int32), nd.full([50], 0.5, nd.Int32), 800))
	print(280, __pow(nd.full([1000], 0.5, nd.Int32), nd.full([1000], 0.5, nd.Int32), 40))
	print(281, __pow(nd.full([20000], 0.5, nd.Int32), nd.full([20000], 0.5, nd.Int32), 2))
	print(282, __pow(nd.full([50], 0.5, nd.UInt32), nd.full([50], 0.5, nd.UInt32), 800))
	print(283, __pow(nd.full([1000], 0.5, nd.UInt32), nd.full([1000], 0.5, nd.UInt32), 40))
	print(284, __pow(nd.full([20000], 0.5, nd.UInt32), nd.full([20000], 0.5, nd.UInt32), 2))
	print(285, __pow(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(286, __pow(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(287, __pow(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(288, __pow(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(289, __pow(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(290, __pow(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(291, __pow(nd.full([50], 0.5, nd.Int64), nd.full([50], 0.5, nd.Int64), 800))
	print(292, __pow(nd.full([1000], 0.5, nd.Int64), nd.full([1000], 0.5, nd.Int64), 40))
	print(293, __pow(nd.full([20000], 0.5, nd.Int64), nd.full([20000], 0.5, nd.Int64), 2))
	print(294, __pow(nd.full([50], 0.5, nd.UInt64), nd.full([50], 0.5, nd.UInt64), 800))
	print(295, __pow(nd.full([1000], 0.5, nd.UInt64), nd.full([1000], 0.5, nd.UInt64), 40))
	print(296, __pow(nd.full([20000], 0.5, nd.UInt64), nd.full([20000], 0.5, nd.UInt64), 2))
	print(297, __pow(nd.full([50], 0.5, nd.Complex64), nd.full([50], 0.5, nd.Complex64), 800))
	print(298, __pow(nd.full([1000], 0.5, nd.Complex64), nd.full([1000], 0.5, nd.Complex64), 40))
	print(299, __pow(nd.full([20000], 0.5, nd.Complex64), nd.full([20000], 0.5, nd.Complex64), 2))
	print(300, __pow(nd.full([50], 0.5, nd.Complex128), nd.full([50], 0.5, nd.Complex128), 800))
	print(301, __pow(nd.full([1000], 0.5, nd.Complex128), nd.full([1000], 0.5, nd.Complex128), 40))
	print(302, __pow(nd.full([20000], 0.5, nd.Complex128), nd.full([20000], 0.5, nd.Complex128), 2))
