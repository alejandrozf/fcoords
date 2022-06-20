;;;; fcoords.lisp

(in-package #:fcoords)

(defun back-transformation (x y f &key (g #'identity) (add #'+) (substract #'-))
  "Converts a single point transformed to normal coordinates"
  (values (funcall add (funcall g x) (funcall f y))
          (funcall substract (funcall g y) (funcall f x))))

(defun back-transformation-sequence (x y n f &key (g #'identity) (add #'+) (substract #'-))
  "Runs 'n' times the back f-g-transformation over an initial point"
  (let ((x-points ())
        (y-points ())
        (x0 x)
        (y0 y))
    (dotimes (i n (1+ i))
      (push x0 x-points)
      (push y0 y-points)
      (multiple-value-bind (x1 y1)
          (back-transformation x0 y0 f :g g :add add :substract substract)
        (setf x0 x1
              y0 y1)))
    (list x-points y-points)))

(defun back-transformation-sequence-multiple (x y transform-list)
  "Apply a list of f-g-transformation over an initial point"
  (let ((x-points ())
        (y-points ())
        (x0 x)
        (y0 y))
    (dolist (f transform-list)
      (push x0 x-points)
      (push y0 y-points)
      (multiple-value-bind (x1 y1)
          (funcall f x0 y0)
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
