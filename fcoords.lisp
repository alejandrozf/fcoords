;;;; fcoords.lisp

(in-package #:fcoords)

(defun back-transformation (x y f &optional (g #'identity))
  "Converts a single point transformed to normal coordinates"
  (values (- (funcall g x) (funcall f y))
          (+ (funcall g y) (funcall f x))))

(defun back-tranformation-sequence (x y n f &optional (g #'identity))
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

;;TODO1: use 'https://github.com/volkers/vgplot' to plot the data generated by 'back-tranformation-sequence'
;;TODO2: add vgplot as a dependency for the project
;;TODO3: use (lambda (x) (if (> x 0) (sqrt x) (- (sqrt (abs x))))) for tests

;; Example (in REPL) :
;; (setf sqrt-axis (lambda (x) (if (> x 0) (sqrt x) (- (sqrt (abs x))))))
;; (setf data (fcoords:back-tranformation-sequence 20 31 1500 #'sqrt-axis))
;; (vgplot:plot (first data) (second data))
