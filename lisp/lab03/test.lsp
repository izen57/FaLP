(load "d:/filp/lisp/quad.lsp")
(ql:quickload "fiveam")
(use-package :fiveam)

(test test-quad
	(is (equalp (quad 1 -3 0) '(3 0)) "c = 0, b != 0")
	(is (equalp (quad 1 0 -6) '(2.4494898 -2.4494898)) "b = 0, c != 0, D > 0")
	(is (equalp (quad 1 0 6) '(#C(0.0 2.4494898) #C(0.0 -2.4494898))) "b = 0, c != 0, D < 0")
	(is (equalp (quad 1 -5 6) '(3.0 2.0)) "c != 0, b != 0, D > 0")
	(is (equalp (quad 1 -5 7) '(#C(2.5 0.8660254) #C(2.5 -0.8660254))) "c != 0, b != 0, D < 0")
	(is (equalp (quad 1 -10 25) '(5)) "c != 0, b != 0, D = 0")
	(is (equalp (quad 0 2 3) '(-3/2)) "a > 0")
	(is (equalp (quad 0 0 0) t) "a = b = c = 0")
	(is (equalp (quad 0 0 7) nil) "a = b = 0, c != 0"))

(fiveam:run!)