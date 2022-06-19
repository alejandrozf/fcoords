;;;; fcoords.lisp

(in-package #:fcoords)

(defun back-transformation (x y f &optional (g #'identity))
  "Converts a single point transformed to normal coordinates"
  (values (- (funcall g x) (funcall f y))
          (+ (funcall g y) (funcall f x))))

(defun back-transformation-sequence (x y n f &optional (g #'identity))
  "Runs 'n' times the back f-g-transformation over an initial point"
  (let ((x-points ())
        (y-points ())
        (x0 x)
        (y0 y))
    (dotimes (i n (1+ i))
      (push x0 x-points)
      (push y0 y-points)
      (multiple-value-bind (x1 y1)
          (back-transformation x0 y0 f g)
        (setf x0 x1
              y0 y1)))
    (list x-points y-points)))

(defun axis-sqrt (x)
  "Function sqrt-like modified to be ready for being a transformation axis"
  (if (> x 0)
      (sqrt x)
      (- (sqrt (abs x)))))

(defun axis-log (x)
  "Function log-like modified to be ready for being a transformation axis"
  (if (> x 0) (log (1+ x)) (- (log (1+ (abs x))))))

(defun back-transformation-plot (init-x init-y iterations func)
  "Plot back-transformation graphic"
  (let ((data (fcoords:back-transformation-sequence init-x init-y iterations func)))
    (vgplot:plot (first data) (second data))))
