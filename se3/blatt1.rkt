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
; Helferfunktion, um dG in Bogenmaß zu errechnen
(define (calculateDG widthARad widthBRad distanceLengthRad)
  ; ausrechnen von dG im Bogenmaß
  (acos
   ; ausrechnen von cos dG im Bogenmaß
   (+ (*
       (sin widthARad)
       (sin widthBRad)
       )
      (* (cos widthARad)
         (cos widthBRad)
         (cos distanceLengthRad)
         )
      )
   )
  )

; Helferfunktion, um Differenz der Länge in Bogenmaß zu errechnen
(define (calculateDistanceLengthRad lengthA lengthB)
  ; Differenz geographische Längen
  (define distanceLength
    (- lengthB lengthA)
    )
  ; Differenz in Radiant umrechnen
  (degreeToRadian distanceLength)
  )

; breiteA laengeA breiteB laengeB alle in Grad angegeben
; westliche Länge und südliche Breite negativ angeben
(define (distanzAB breiteA laengeA breiteB laengeB)
  ; Parameter in Radiant umrechnen
  (define breiteARad (degreeToRadian breiteA))
  (define breiteBRad (degreeToRadian breiteB))
  (define distanzLaengeRad (calculateDistanceLengthRad laengeA laengeB))
  (define dG (calculateDG breiteARad breiteBRad distanzLaengeRad))
  ; umrechen in Kilometer
  (nmToKM
   ; ermitteln der Entfernung in Seemeilen
   (* 60
      ; umwandeln in Grad
      (radianToDegree dG)
      )
   )
  )

; ausrechnen der Entfernung zwischen den angegebenen Städten
(display "Entfernung Oslo - Hongkong (in km): ") 
(distanzAB 59.93 10.75 22.2 114.1)
(display "Entfernung San Francisco - Honolulu (in km): ")
(distanzAB 37.75 -122.45 21.32 -157.83)
(display "Entfernung Osterinsel - Lima (in km): ")
(distanzAB -27.1 -109.4 -12.1 -77.05)

; 2.2
; breiteA laengeA breiteB laengeB alle in Grad angegeben
; westliche Länge und südliche Breite negativ angeben
(define (kurswinkel breiteA laengeA breiteB laengeB)
  ; benötigte Variablen bereitstellen
  (define distanzLaengeRad (calculateDistanceLengthRad laengeA laengeB))
  (define breiteARad (degreeToRadian breiteA))
  (define breiteBRad (degreeToRadian breiteB))
  (define dG (calculateDG breiteARad breiteBRad distanzLaengeRad))
  ; cos alpha r errechnen
  (define cosAlphaR (/
                     (- (sin breiteBRad)
                        (* (cos dG)
                           (sin breiteARad)
                           )
                        )
                     (* (cos breiteARad)
                        (sin dG)
                        )
                     )
    )
  ; alpha R bestimmen und in Grad umrechnen.
  (define alphaR (acos cosAlphaR))
  (define alphaRGrad (radianToDegree alphaR))
  ; bestimmen, ob Kurs nach Osten geht
  (define isEastboundA (if (> laengeB laengeA) true false))
  (define checkNecessary (> 0
                            (* laengeA
                               laengeB)
                            )
    )
  ; überprüfen, ob offensichtliche Richtung tatsächlich kürzer ist
  (define isEastbound (if checkNecessary 
                          (if (> (- 360
                                    (+ (abs laengeB)
                                       (abs laengeA)
                                       )
                                    )
                                 (+ (abs laengeB)
                                    (abs laengeA)
                                    )
                                 )
                              isEastboundA
                              (not isEastboundA)
                              )
                          isEastboundA
                          )
    )
  ; abhängig von der Richtung den Kurswinkel bestimmen
  (if isEastbound alphaRGrad (- 360
                                alphaRGrad)
      )
  )

; ausrechnen der Kurswinkel auf den angegebenen Routen
(display "Kurswinkel Oslo - Hongkong: ") 
(kurswinkel 59.93 10.75 22.2 114.1)
(display "Kurswinkel San Francisco - Honolulu: ")
(kurswinkel 37.75 -122.45 21.32 -157.83)
(display "Kurswinkel Osterinsel - Lima: ")
(kurswinkel -27.1 -109.4 -12.1 -77.05)

; 2.3
; winkelGrad darf maximal eine Nachkommastelle haben und muss in Grad
; angegeben sein
(define (gradToHimmelsrichtung winkelGrad)
  ; N=0,NNE=22.5,NE=45,ENE=67.5,E=90,ESE=112.5,SE=135,SSE=157.5,S=180
  ; SSW=202.5,SW=225,WSW=247.5,W=270,WNW=292.5,NW=315,NNW=337.5,N=360
  ; ein Kurswinkel ist also immer maximal 11.25 Grad von der nächsten fest
  ; definierten Himmelsrichtung entfernt
  (define winkelGradModuloReady (* 10 winkelGrad))
  (define abstand (/ (modulo winkelGradModuloReady 225) 10.0))
  (define aufrunden (>= abstand 11.25))
  (define richtungGrad1 (- winkelGrad abstand))
  (define richtungGrad (if aufrunden
                           (+ richtungGrad1 22.5)
                           richtungGrad1
                           )
    )
  (case richtungGrad
    [(0) "N"]
    [(22.5) "NNE"]
    [(45) "NE"]
    [(67.5) "ENE"]
    [(90) "E"]
    [(112.5) "ESE"]
    [(135) "SE"]
    [(157.5) "SSE"]
    [(180) "S"]
    [(202.5) "SSW"]
    [(225) "SW"]
    [(247.5) "WSW"]
    [(270) "W"]
    [(292.5) "WNW"]
    [(315) "NW"]
    [(337.5) "NNW"]
    [(360) "N"]
    )
  )

; ausgeben der Himmelsrichtungen für die eben berechneten Kurswinkel
(display "Flugrichtung Oslo - Hongkong: ")
(gradToHimmelsrichtung 67.4)
(display "Flugrichtung San Francisco - Honolulu: ")
(gradToHimmelsrichtung 251.8)
(display "Flugrichtung Osterinsel - Lima: ")
(gradToHimmelsrichtung 70.0)

; richtung muss als String in Form einer Himmelsrichtung gegeben werden
(define (himmelsrichtungToGrad richtung)
  (case richtung
    [("N") 0]
    [("NNE") 22.5]
    [("NE") 45]
    [("ENE") 67.5]
    [("E") 90]
    [("ESE") 112.5]
    [("SE") 135]
    [("SSE") 157.5]
    [("S") 180]
    [("SSW") 202.5]
    [("SW") 225]
    [("WSW") 247.5]
    [("W") 270]
    [("WNW") 292.5]
    [("NW") 315]
    [("NNW") 337.5]
    )
  )