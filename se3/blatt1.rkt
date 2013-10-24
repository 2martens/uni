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

; 2.1
(define (distanzAB breiteA laengeA breiteB laengeB)
  ; Parameter in Radiant umrechnen
  (define breiteARad (degreeToRadian breiteA))
  (define breiteBRad (degreeToRadian breiteB))
  ; Differenz geographische Längen
  (define distanzLaenge 
    (- laengeB laengeA)
    )
  ; Differenz in Radiant umrechnen
  (define distanzLaengeRad (degreeToRadian distanzLaenge))
  (define cosDG
    ; ausrechnen von cos dG im Bogenmaß
    (+ (*
        (sin breiteARad)
        (sin breiteBRad)
        )
       (* (cos breiteARad)
          (cos breiteBRad)
          (cos distanzLaengeRad)
          )
       )
    )
  ; umrechen in Kilometer
  (nmToKM
   ; ermitteln der Entfernung in Seemeilen
   (* 60
      ; umwandeln in Grad
      (radianToDegree cosDG)
      )
   )
  )
