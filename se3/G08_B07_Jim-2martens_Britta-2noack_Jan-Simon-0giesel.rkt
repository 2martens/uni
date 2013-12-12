#lang racket

#|
SE 3 Funktional Blatt 7
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)

; allgemeine rekursive Version
(define (produkt1 n f)
  (letrec ((rec (λ (xs r)
                  (if [empty? xs]
                      r
                      (rec 
                          (cdr xs)
                        (cons (* (car xs) f) r))))))
    (reverse (rec n '()))))

; endrekursive Version
(define (produkt2 n f)
  (let ((revList (reverse n)))
    (letrec ((rec (λ (xs acc)
                    (if (empty? xs)
                        acc
                        (rec 
                            (cdr xs) 
                          (cons (* (car xs) f) acc)
                          )
                        ))))
      (rec revList '()))))

; Funktionen höherer Ordnung
(define (produkt3 n f)
  (map (curryr * f) n))

; 2)

; 2.1
; Eine Liste mit sieben Elementen, die je eine Leuchtdiode 
; repräsentieren. Jedes Element ist entweder #f oder #t.
; -1-
;|   |
;2   3
;|   |
; -4-
;|   |
;5   6
;|   |
; -7-

; Die Leuchtdioden werden in dieser Reihenfolge in der Liste
; angegeben.

; Die möglichen Zustände für die Zahlen 0-9 werden mithilfe
; einer Liste von oben beschriebenen Listen realisiert.

(define zustandstabelle
  '((0 . (#t #t #t #f #t #t #t))
    (1 . (#f #f #t #f #f #t #f))
    (2 . (#t #f #t #t #t #f #t))
    (3 . (#t #f #t #t #f #t #t))
    (4 . (#f #t #t #t #f #t #f))
    (5 . (#t #t #f #t #f #t #t))
    (6 . (#t #t #f #t #t #t #t))
    (7 . (#t #f #t #f #f #t #f))
    (8 . (#t #t #t #t #t #t #t))
    (9 . (#t #t #t #t #f #t #t))))

(define (key->value key tabelle)
  (cdr (assoc key tabelle)))

; 2.2
(require 2htdp/image)

; erzeugte ein senkrechtes Segment
(define (zeichneSegmentSenkrecht active)
  (if active
      (rectangle 10 80 "solid" "Red")
      (rectangle 10 80 "solid" "DimGray")
      ))

; erzeugt ein waagerechtes Segment
(define (zeichneSegmentWaagerecht active)
  (if active
      (rectangle 80 10 "solid" "Red")
      (rectangle 80 10 "solid" "DimGray")
      ))

; zeichnet die Segmente
(define (zeichneSegmente zustand)
  (beside
   ; Segmente 2 und 5
   (above
    (zeichneSegmentSenkrecht (cadr zustand))
    (rectangle 10 10 "solid" "Black")
    (zeichneSegmentSenkrecht (cadddr (cdr zustand)))
    )
   ; Segmente 1, 4 und 7
   (above
    (zeichneSegmentWaagerecht (car zustand))
    (rectangle 80 80 "solid" "Black")
    (zeichneSegmentWaagerecht (cadddr zustand))
    (rectangle 80 80 "solid" "Black")
    (zeichneSegmentWaagerecht (cadddr (cdddr zustand)))
    )
   ; Segmente 3 und 6
   (above 
    (zeichneSegmentSenkrecht (caddr zustand))
    (rectangle 10 10 "solid" "Black")
    (zeichneSegmentSenkrecht (cadddr (cddr zustand)))
    )
   ))

; zeigt eine Sieben-Segment-Anzeige
(define (zeigeSiebenSegment zustand)
  (overlay
   (zeichneSegmente zustand)
   (rectangle 100 200 "solid" "Black")
   ))

; 2.3
(define (zeige-7segment t)
  (let ((zustand (floor (/ t 28))))
    (if (and [exact? zustand]
             [< zustand 10])
        (zeigeSiebenSegment (key->value zustand zustandstabelle))
        (zeigeSiebenSegment (key->value (- zustand 10) zustandstabelle)))))

(require 2htdp/universe)
; zum Animieren auskommentieren
;(animate zeige-7segment)

; 2.4
; Für die Darstellung von 6 Anzeigen müssen 6 Zustands-
; variablen eingeführt werden, die den Zustand für jede
; der sechs Anzeigen repräsentieren.

; Dazu muss die eben definierte Funktion dahingehend 
; erweitert werden.

; Die Anzeigen seien von links nach rechts mit 1 bis 6 bezeichnet.
; modT entspricht dem Rest der Division t durch 2419200.
; Anzeige 6 schaltet auf 1, wenn modT 28 ist und auf 2 wenn modT 56 ist, etc.
; Anzeige 5 schaltet auf 1, wenn Anzeige 1 auf 10 ist und
; auf 2 wenn 6 auf 20 ist, etc.
; Anzeige 4 schaltet auf 1, wenn Anzeige 5 auf 6 ist und
; auf 2 wenn 5 auf 12 ist, etc.
; Anzeige 3 schaltet auf 1, wenn Anzeige 4 auf 10 ist und
; auf 2 wenn 4 auf 20 ist, etc.
; Anzeige 2 schaltet auf 1, wenn Anzeige 3 auf 6 ist und
; auf 2 wenn 3 auf 12 ist, etc.
; Anzeige 1 schaltet auf 1, wenn Anzeige 2 auf 10 ist und
; auf 2 wenn 2 auf 20 ist, etc.

(define trenner
  (underlay/xy 
   (underlay/xy 
    (rectangle 100 200 'solid  'black) 
    40 
    70 
    (rectangle 20 20 'solid 'red)
    )
   40
   140
   (rectangle 20 20 'solid 'red)
   ))

(define trenner2
  (rectangle 10 200 "solid" "Black"))

(define (zeigedauer t)
  (let* ((modT (modulo t 2419200)) ; 2419200 entspricht 24h
         (zustand6 (floor (/ modT 28)))
         (zustand5 (floor (/ zustand6 10)))
         (zustand4 (floor (/ zustand5 6)))
         (zustand3 (floor (/ zustand4 10)))
         (zustand2 (floor (/ zustand3 6)))
         (zustand1 (floor (/ zustand2 10))))
    (beside
     (zeigeSiebenSegment (key->value (modulo zustand1 6) zustandstabelle))
     trenner2
     (zeigeSiebenSegment (key->value (modulo zustand2 10) zustandstabelle))
     trenner
     (zeigeSiebenSegment (key->value (modulo zustand3 6) zustandstabelle))
     trenner2
     (zeigeSiebenSegment (key->value (modulo zustand4 10) zustandstabelle))
     trenner
     (zeigeSiebenSegment (key->value (modulo zustand5 6) zustandstabelle))
     trenner2
     (zeigeSiebenSegment (key->value (modulo zustand6 10) zustandstabelle)))
    ))

; zum Animieren auskommentieren
; (animate zeigedauer)

