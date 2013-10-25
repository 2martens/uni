#lang racket

#|
SE 3 Funktional Blatt 1
Abgebende: Jim 2martens, 2noack, 0giebel
|#

; 1.1
; degrees ist eine positive Zahl in Grad
(define (degreeToRadian degrees)
  (/ (* degrees pi) 180)
  )
; radians ist eine Zahl in Bogenmaß
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
; nauticMiles ist eine positive Zahl in nautischen Meilen
(define (nmToKM nauticMiles)
  (* nauticMiles 1.852)
  )

; 2.1
; breiteA laengeA breiteB laengeB alle in Grad angegeben
; westliche Länge und südliche Breite negativ angeben
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
  (define dG (acos cosDG))
  ; umrechen in Kilometer
  (nmToKM
   ; ermitteln der Entfernung in Seemeilen
   (* 60
      ; umwandeln in Grad
      (radianToDegree dG)
      )
   )
  )

; ausrechnen der Entfernung von Oslo und Hongkong
(display "Entfernung Oslo - Hongkong (in km): ") 
(distanzAB 59.93 10.75 22.2 114.1)
(display "Entfernung San Francisco - Honolulu (in km): ")
(distanzAB 37.75 -122.45 21.32 -157.83)
(display "Entfernung Osterinsel - Lima (in km): ")
(distanzAB -27.1 -109.4 -12.1 -77.05)
