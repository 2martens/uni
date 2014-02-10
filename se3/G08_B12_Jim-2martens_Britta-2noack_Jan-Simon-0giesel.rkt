#lang racket

#|
SE 3 Funktional Blatt 12
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)

; 1.
(define (wert-rec xs)
  (letrec ((rec (λ (ys potenz acc)
                  (if (empty? ys)
                      acc
                      (rec 
                          (cdr ys)
                        (+ 1 potenz)
                        (+ (* (car ys) (expt 10 potenz)) acc))))))
    (rec xs 0 0)))
; 2.
(define (wert-higher xs)
  (foldl 
   + 
   0
   (map * xs 
        (let ((l (length xs)))
          (letrec ((rec (λ (x acc)
                          (if (= x 0) acc
                              (rec (- x 1)
                                (cons 
                                 (expt 10 (- x 1)) 
                                 acc))))))
            (rec l '()))))
   ))

; 2)

; 2.1
(define kryptoStructure
  '((A . 1)
    (B . 2)
    (C . 3)
    (D . 4)
    (E . 5)
    (F . 6)
    (G . 7)
    (H . 8)
    (I . 9)
    (J . 10)
    (K . 11)
    (L . 12)
    (M . 13)
    (N . 14)
    (O . 15)
    (P . 16)
    (Q . 17)
    (R . 18)
    (S . 19)
    (T . 20)
    (U . 21)
    (V . 22)
    (W . 23)
    (X . 24)
    (Y . 25)
    (Z . 26)))

(define (key->wert key struktur)
  (cdr (assoc key struktur)))

; 2.2

(andmap (λ (x) #t) '(1 2 3))