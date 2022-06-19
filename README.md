Some utilities to organize a coordinate transformation

Quickstart

```
CL-USER> (ql:quickload :fcoords)
To load "fcoords":
  Load 1 ASDF system:
    fcoords
; Loading "fcoords"

(:FCOORDS)
CL-USER> (in-package :fcoords)
#<PACKAGE FCOORDS>
FCOORDS> (back-transformation 1 2 #'identity)
3 (2 bits, #x3, #o3, #b11)
1 (1 bit, #x1, #o1, #b1)
FCOORDS> (back-transformation 1 2 (lambda (c) (* c c c)))
9 (4 bits, #x9, #o11, #b1001)
1 (1 bit, #x1, #o1, #b1)
FCOORDS> (back-transformation 1 2 #'axis-log)
2.0986123
1.3068528 (130.68529%)
FCOORDS> (back-transformation 1 2 #'axis-sqrt)
2.4142137
1.0 (100.0%)
FCOORDS> (back-transformation-sequence 1 3 10 #'identity)
((64 16 -16 -24 -16 -4 4 6 4 1) (32 48 32 8 -8 -12 -8 -2 2 3))
FCOORDS> ;for support for Big decimals (ABCL only)
; No values
FCOORDS> (ql:quickload :abcl-big-decimals)
To load "abcl-big-decimals":
  Load 1 ASDF system:
    abcl-big-decimals
; Loading "abcl-big-decimals"

(:ABCL-BIG-DECIMALS)
FCOORDS> (defun axis-x5 (x)
           (abcl-big-decimals::pow x 5))
AXIS-X5
FCOORDS> (back-transformation (abcl-big-decimals:make-big-decimal 1.0342)
                              (abcl-big-decimals:make-big-decimal 3.3456)
                              #'axis-x5
                              :add #'abcl-big-decimals:add :substract #'abcl-big-decimals:subtract)
#<java.math.BigDecimal 420.1847166045971576492230692266.... {6F5F5BCC}>
#<java.math.BigDecimal 2.162496854180966852585012059381.... {7172EC07}>
FCOORDS> (back-transformation-sequence (abcl-big-decimals:make-big-decimal 1)
                                       (abcl-big-decimals:make-big-decimal 3)
                                       10 #'axis-x5
                                       :add #'abcl-big-decimals:add :substract #'abcl-big-decimals:subtract)
((#<java.math.BigDecimal 1.415511779254395408594812684715.... {528A4600}>
  #<java.math.BigDecimal -4.49550173611286487381685312951.... {5B60117B}>
  #<java.math.BigDecimal -9.24775976995593540739593051057.... {AB1038B}>
  #<java.math.BigDecimal 1.164423942796962582908605997927.... {5A220723}>
  #<java.math.BigDecimal 1.314139476391488959907197761254.... {1E720A67}>
  #<java.math.BigDecimal -9.17581069416690740296038822487.... {3C611325}>
  #<java.math.BigDecimal -4.83888898425127536270960191250.... {3E4EF279}>
  #<java.math.BigDecimal 276 {741FF18C}>
  #<java.math.BigDecimal 244 {7AB0EC5A}>
  #<java.math.BigDecimal 1 {4EFC3012}>)
 (#<java.math.BigDecimal 1.836076823478606255345552948934.... {768DE8E}>
  #<java.math.BigDecimal 6.763674475385749504910853945685.... {C70DC7E}>
  #<java.math.BigDecimal -2.14069913681449458916829010505.... {71DF2396}>
  #<java.math.BigDecimal -3.91928917413115439838474704116.... {5E0CE11F}>
  #<java.math.BigDecimal 6.504624421482493957585355735039.... {1FD1D8FE}>
  #<java.math.BigDecimal 2.652945280346645821349991403611.... {15486456}>
  #<java.math.BigDecimal -2466434713598 {1D8336FA}>
  #<java.math.BigDecimal -864866612222 {24BE284C}>
  #<java.math.BigDecimal 2 {3539120D}>
  #<java.math.BigDecimal 3 {6305BA28}>))
FCOORDS> (apply #'mapcar
                (lambda (c d)
                  (cons (abcl-big-decimals:big-decimal->string c)
                        (abcl-big-decimals:big-decimal->string d)))
                *)
(("1.415511779254395408594812684715740E+932574"
  . "1.836076823478606255345552948934341E+193633")
 ("-4.495501736112864873816853129518520E+38726"
  . "6.763674475385749504910853945685879E+186514")
 ("-9.247759769955935407395930510577579E+37302"
  . "-2.140699136814494589168290105050643E+7745")
 ("1.164423942796962582908605997927205E+1549"
  . "-3.919289174131154398384747041161026E+7460")
 ("1.314139476391488959907197761254179E+1492"
  . "6.504624421482493957585355735039029E+309")
 ("-9.175810694166907402960388224876064E+61"
  . "2.652945280346645821349991403611400E+298")
 ("-4.838888984251275362709601912505016E+59" . "-2466434713598")
 ("276" . "-864866612222") ("244" . "2") ("1" . "3"))
FCOORDS>
```
