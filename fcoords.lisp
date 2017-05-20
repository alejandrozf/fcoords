;;;; fcoords.lisp

(in-package #:fcoords)

;;; "fcoords" goes here. Hacks and glory await!

(defun back-transformation (x y f &optional (g #'identity))
  "Converts a single point transformed to normal coordinates"
  (cons (- (funcall g x) (funcall f y))
        (+ (funcall g y) (funcall f x))))
