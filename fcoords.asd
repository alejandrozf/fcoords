;;;; fcoords.asd

(asdf:defsystem #:fcoords
  :description "Some utilities to organize and visualize a functional based coordinate transformation"
  :author "Alejandro Zamora <ale2014.zamora@gmail.com>"
  :license "MIT"
  :serial t
  :depends-on ("vgplot")
  :components ((:file "package")
               (:file "fcoords")))
