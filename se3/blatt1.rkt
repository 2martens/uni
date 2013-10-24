#lang racket

#|
SE 3 Funktional Blatt 1
Abgebende: Jim 2martens, 2noack, 0giebel
|#

; 1.1

(define (degreeToRadian degrees)
  (/ (* degrees pi) 180)
  )

(define (radianToDegree radians)
  (/ (* radians 180) pi)
  )

; 1.2
(define (my-acos cosinus)
  ; berechnen von alpha
  (atan 
   ; berechnen des tangens
   (/
    ; berechnen des Sinus
    (sqrt (- 1 (sqr cosinus)))
    cosinus
    )
   )
  )

; 1.3
(define (nmToKM nauticMiles)
  (* nauticMiles 1.852)
  )