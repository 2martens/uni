#lang lazy

#|
SE 3 Funktional Blatt 10
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)

; 1.1
(define (every pred xs)
  (foldl (λ (x best) (and x best)) 
         #t 
         (map pred xs))
  )

(define (some pred xs)
  (foldl (λ (x best) 
           (if [pred x]
               x
               best))
         #f
         xs)
  )

; 1.2
(define (symmetrisch? r)
  (every (λ (x)
           (some (λ (y)
                   (and (eq? (cdr y)
                             (car x))
                        (eq? (car y)
                             (cdr x))))
                 r))
         r))

(define (asymmetrisch? r)
  (every (λ (x)
           (let ((t1 (some (λ (y)
                             (and (eq? (cdr y)
                                       (car x))
                                  (eq? (car y)
                                       (cdr x)))
                             ))))
             r))))

(define (reflexiv? r)
  (every (λ (x)
           (and (some (λ (y)
                        (and (eq? (car y)
                                  (car x))
                             (eq? (cdr y)
                                  (car x))))
                      r)
                (some (λ (y)
                        (and (eq? (car y)
                                  (cdr x))
                             (eq? (cdr y)
                                  (cdr x))))
                      r)))
         r))

(define (transitiv? r)
  (every (λ (x)
           (let ((t1 (some (λ (y)
                             (and (eq? (cdr x)
                                       (car y))
                                  (not (eq? (cdr x)
                                            (cdr y)))))
                           r)))
             (if t1
                 (some (λ (z)
                         (and (eq? (car x)
                                   (car z))
                              (eq? (cdr t1)
                                   (cdr z))))
                       r)
                 #t)))
         r))

(define (aequi? r)
  (and (reflexiv? r)
       (symmetrisch? r)
       (transitiv? r)))

(define (ord? r)
  (and (reflexiv? r)
       (not (symmetrisch? r))
       (transitiv? r)))
; 2)

; 1.
(define (Kreuzprodukt m1 m2)
  (letrec ((inner (λ (x ys acc)
                    (if (empty? ys)
                        acc
                        (inner x
                               (cdr ys)
                               (cons (list x
                                           (car ys))
                                     acc)))))
           (outer (λ (xs ys acc)
                    (if (empty? xs)
                        acc
                        (outer (cdr xs)
                               ys
                               (inner (car xs)
                                      ys
                                      acc))))))
    (outer (reverse m1) (reverse m2) '())))

; 2.

;(define (Produkt xs)

; 3.
; abhängig von k machen.
(define (Kombination k M)
  (letrec ((inner (λ (x ys acc)
                    (if (empty? ys)
                        acc
                        (inner x
                               (cdr ys)
                               (cons (list x (car ys))
                                     acc)))))
           (outer (λ (xs acc)
                    (if (empty? xs)
                        acc
                        (outer (cdr xs)
                               (inner (car xs)
                                      (cdr xs)
                                      acc))))))
    (reverse (outer M '()))))


; 3)

; 1.

; (a) -> -1, weil 2-3 = -1 und -1 < 2 und -1 >= -1
; (b) -> '(+ -2 2), weil quasi-quote und (- 2 4) dennoch ausgeführt wird (wg. ,)
; (c) -> Alle, weil Alle erstes Element der Liste
; (d) -> '(auf (dem See))
; (e) -> '(Listen sind einfach)
; (f) -> '(Paare . auch)
; (g) -> #t, da beide Listen gleiche Werte haben
; (h) -> #f, da die beiden Listen nicht identisch sind
; (i) -> '(1 8 27)
; (j) -> '(1 3 5)
; (k) -> 2, da 2 < 6
; (l) -> #t, da 2 = 2

; 2.

; *a* hat ein wohldefinierten Wert und evaluiert zu 10
; (+ *a* *b*) hat keinen wohldefinierten Wert
; (+ (eval *a*) (eval *b*)) hat keinen wohldefinierten Wert
; (and (> *a* 10) (> *b* 3)) hat wohldefinierten Wert und evaluiert zu #f
; (or (> *a* 10) (/ *a* 0)) hat keinen wohldefinierten Wert
; (+ 2 (merke 3)) hat keinen wohldefinierten Wert
; (+ 2 ((merke 3))) hat einen wohldefinierten Wert und evaluiert zu 5
; (test 4) hat keinen wohldefinierten Wert

; 3. 
; (a)
(+ (* 3 4) (* 5 6))
; (b)
(define wurzel (λ (x) (sqrt (- 1 (sqr (sin x))))))

; 4.
(define (c a b)
  (sqrt (+ (sqr a) (sqr b))))
(define (mythan a)
  (/ (sin a)
     (sqrt (- 1 (sqr (sin a))))))

; 5.
; (a)
(- (+ 1 (/ 4 2)) 1)
; (b)
(/ (- 2 (/ (+ 1 3) (+ 3 (* 2 3)))) (sqrt 3))

; 6.
; (1 + 2 + 3) * (2 - 3 - (2 - 1))

; 7. 
(define (laengen xss)
  (map length xss))

(define (laengenRekEnd xss)
  (letrec ((rec (λ (xs acc)
                  (if (empty? xs)
                      acc
                      (rec (cdr xs)
                        (cons (length (car xs))
                              acc))))))
    (reverse (rec xss '()))))

(define (laengenRekNorm xss)
  (if (empty? xss)
      '()
      (cons (length (car xss))
            (laengenRekNorm (cdr xss)))))


; 8.
; (a)
(define (make-length value unit)
  (list value unit))
; (b)
(define (value-of-length len)
  (car len))
(define (unit-of-length len)
  (cadr len))
; (c)
(define (scale-length len fac)
  (list (* (car len) fac) (cadr len)))
; (d)
(define *conversiontable* ;
  '( ; (unit . factor)
    (m . 1)
    (cm . 0.01)
    (mm . 0.001)
    (km . 1000)
    (inch . 0.0254)
    (feet . 0.3048)
    (yard . 0.9144)))
(define (factor unit)
  (cdr (assoc unit *conversiontable*)))
(define (length->meter len)
  (list (car (scale-length len (factor (cadr len))))
        'm))
(define (length< len1 len2)
  (< (car (length->meter len1)) (car (length->meter len2))))
(define (length= len1 len2)
  (= (car (length->meter len1)) (car (length->meter len2))))
(define (length+ len1 len2)
  (list (+ (car (length->meter len1)) (car (length->meter len2)))
        'm))
(define (length- len1 len2)
  (list (- (car (length->meter len1)) (car (length->meter len2)))
        'm))
; (e)
(define xs '((6 km) (2 feet) (1 cm) (3 inch)))

(map length->meter xs)
(filter (λ (x) (< (car x) 1)) (map length->meter xs))
(foldl (λ (x best) (+ (car x) best)) 0 (map length->meter xs))
