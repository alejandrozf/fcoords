;;;; fcoords.lisp

(in-package #:fcoords)

(defun back-transformation (x y f &optional (g #'identity))
  "Converts a single point transformed to normal coordinates"
  (values (- (funcall g x) (funcall f y))
          (+ (funcall g y) (funcall f x))))

(defun back-tranformation-sequence (x y n f &optional (g #'identity))
  "Runs 'n' times the back f-g-transformation over an initial point"
  (let ((result ())
        (x0 x)
        (y0 y))
    (dotimes (i n (1+ i))
      (push `(,x0 ,y0) result)
      (multiple-value-bind (x1 y1)
          (back-transformation x0 y0 f g)
        (setf x0 x1
              y0 y1)))
    result))
