#lang racket

#|
SE 3 Funktional Blatt 6
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)
;
; kopfstueck ist eine lineare Rekursion, da pro else-Aufruf,
; die Funktion nur einmal sich selbst aufruft.
; Daher kann kopfstueck keine Baumrekursion sein.
; kopfstueck wird auch nicht als Argument für kopfstueck verwendet,
; womit auch geschachtelte Rekursion mit nein zu beantworten ist.
; Da sich kopfstueck direkt rekursiv aufruft, ist es eine direkte
; und keine indirekte Rekursion.

; endstueck ist ebenso linear, keine Baumrekursion, keine geschachtelte
; Rekursion, eine direkte Rekursion und keine indirekte Rekursion.

; merge ist eine lineare Rekursion, da pro Fallunterscheidung
; merge nur einmal aufgerufen wird. Demnach ist es keine Baumrekursion.
; Es ist ebenso wenig eine geschachtelte Rekursion, da es sich selbst
; nicht als Argument übergeben wird.
; merge ist eine direkte Rekursion, da es sich direkt aufruft.
; Deswegen ist merge keine indirekte Rekursion.

; merge-sort ist keine lineare Rekursion, da es in jeder Fallunterscheidung
; zweimal aufgerufen wird. merge-sort ist keine geschachtelte Rekursion,
; da es sich selbst nicht als Argument übergeben wird.
; merge-sort ist eine direkte Rekursion, da es sich direkt aufruft.
; Demnach ist merge-sort keine indirekte Rekursion.

;  ___________________________________________________________________________________________________________________
; |            | lineare Rekursion | Baumrekursion | geschachtelte Rekursion | direkte Rekursion | indirekte Rekursion|
; |____________|___________________|_______________|_________________________|___________________|____________________|
; | kopfstueck |        ja         |      nein     |       nein              |        ja         |          nein      |
; | endstueck  |        ja         |      nein     |       nein              |        ja         |          nein      |
; | merge      |        ja         |      nein     |       nein              |        ja         |          nein      |
; | merge-sort |        nein       |      ja       |       nein              |        ja         |          nein      |
; --------------------------------------------------------------------------------------------------------------------

; 2)
(require 2htdp/image)
(require lang/posn)

; erzeugt einen Tannenbaum mit n Ebenen
(define (tannenbaum n)
  (letrec ((leaves (λ (width x result)
                     (if [= x 0]
                         result
                         ; rekursiver Aufruf, um die nächsthöhere Ebene zu generieren
                         (leaves 
                          (/ width 1.5) 
                          (- x 1) 
                          (cons 
                           ; erzeugt ein Trapez, welches als eine Ebene fungiert
                           (polygon 
                            (list (make-posn 0 0)
                                  (make-posn width 0)
                                  (make-posn (+ (/ width 2) (* (/ width 2) 0.2)) (* -1 (/ width 4)))
                                  (make-posn (- (/ width 2) (* (/ width 2) 0.2)) (* -1 (/ width 4))))
                            "solid" 
                            "darkgreen")                            
                           result)))
                     )))
    ; Anwenden von above/align auf alle Blätter, den Stamm und den Stern
    (apply above/align
           (cons "center" 
                 (cons (star-polygon 20 5 2 "solid" "gold")
                       (leaves 180 n `(,(rectangle 30 30 "solid" "brown") . ()))
                       )))
    
    ))

; erzeugt einen Monitor
(define (monitor content)
  (above/align
   "center"
   (overlay 
    (text content 24 "red")
    (rectangle 160 90 "solid" "blue")
    (rectangle 165 95 "solid" "gray")
    )
   (polygon
    (list (make-posn 0 0)
          (make-posn 80 0)
          (make-posn 55 -10)
          (make-posn 25 -10))
    "solid"
    "gray")
   ))

; erzeugt ein Star Citizen Poster
(define scPoster (overlay
                  (above
                   (text "Star Citizen" 34 "gold")
                   (text "Squadron 42" 28 "gold"))
                  (rectangle 185 85 "solid" "royalblue")
                  (rectangle 200 100 "solid" "black")))

; linker Tannenbaum
(display (tannenbaum 8))
; Monitor
(display (monitor "cout << 0x2a;"))
; Abstand zwischen Monitor und Poster
(display " ")
; Star Citizen Poster
(display scPoster)
; Abstand zwischen Monitor und Poster
(display " ")
; Monitor
(display (monitor "6.12.13"))
; rechter Tannenbaum
(display (tannenbaum 8))