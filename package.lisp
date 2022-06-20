;;;; package.lisp

(defpackage #:fcoords
  (:use #:cl)
  (:export
   ;; main transformation functions
   :back-transformation
   :back-transformation-sequence
   :back-transformation-sequence-multiple
   ;; some axis functions
   :axis-log :axis-sqrt))
