(defun discr-equal-zero (output x1 x2 x3)
	(and (= 0 x1 x2 x3)
		(not (format output "Все коэффициенты равны нулю.~%Уравнение имеет бесконечное количество корней."))
		(return-from discr-equal-zero nil))

	(and (/= x3 0) (= x1 x2 0)
		(not (format output "Третий коэффициент не равен 0, но первые два равны.~%Уравнение не имеет корней."))
		(return-from discr-equal-zero t))

	(format output "Дискриминант равен 0.~%Корень кратности 2: ~d" (/ (- x2) (* 2 x1)))

	(list (/ (- x2) (* 2 x1))))

(defun discr-less-zero (output discr x1 x2)
	(format output "Дискриминант меньше 0.~%")
	(format output "Первый корень: ~d~%" (/ (+ (- x2) (sqrt discr)) (* 2 x1)))
	(format output "Второй корень: ~d" (/ (- (- x2) (sqrt discr)) (* 2 x1)))

	(list (/ (+ (- x2) (sqrt discr)) (* 2 x1)) (/ (- (- x2) (sqrt discr)) (* 2 x1))))

(defun discr-bigger-zero (output discr x1 x2 x3)
	(format output "Дискриминант больше 0.~%")
	(and (= x1 0)
		(not (format output "Уравнение не квадратное.~%Корень: ~d" (/ (- x3) x2)))
		(return-from discr-bigger-zero (list (/ (- x3) x2))))

	(format output "Первый корень: ~d~%" (/ (+ (- x2) (sqrt discr)) (* 2 x1)))
	(format output "Второй корень: ~d" (/ (- (- x2) (sqrt discr)) (* 2 x1)))

	(list (/ (+ (- x2) (sqrt discr)) (* 2 x1)) (/ (- (- x2) (sqrt discr)) (* 2 x1))))

(defun discriminant (x1 x2 x3)
	(- (* x2 x2) (* 4 x1 x3)))

(defun quad (x1 x2 x3)
	(check-type x1 number)
	(check-type x2 number)
	(check-type x3 number)
	(locally (declare (number x1 x2 x3)))

	(let ((*discr* (discriminant x1 x2 x3)))
		(with-open-file (output "results.txt"
						:direction :output
						:if-does-not-exist :create
						:if-exists :supersede)

			(or
				(and (= *discr* 0)
					(discr-equal-zero output x1 x2 x3))
				(and (> *discr* 0)
					(discr-bigger-zero output *discr* x1 x2 x3))
				(and (< *discr* 0)
					(discr-less-zero output *discr* x1 x2))))))

(quad 0 0 0)