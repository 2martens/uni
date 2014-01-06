#lang racket

#|
SE 3 Funktional Blatt 8
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)

; 1.

; Wenn die Funktion mindestens eine Funktion als Parameter erwartet oder
; eine Funktion zurückgibt.

; 2.
; (a): foldl ist eine Funktion höherer Ordnung, da als erster Parameter
; eine Funktion erwartet wird.

; (b): Die Funktion ist eine Funktion höherer Ordnung, da
; sie entweder car oder cdr zurückgibt, welches jeweils Funktionen sind.

; (c) ist eine Funktion höherer Ordnung, da für den Parameter f
; eine Funktion erwartet wird und eine Funktion zurückgegeben wird.

; (d) ist keine Funktion höherer Ordnung, da keine Funktion 
; zurückgegeben wird und auch keine Funktion erwartet wird.

; 3.

; Nach der inneren Reduktion wird zunächst (pimento + 1) ausgeführt.
; Dabei wird f an + gebunden und arg1 wird an 1 gebunden.
; Der zurückgegebenen Closure wird nun 3 als Argument übergeben. 
; Damit wird arg2 an 3 gebunden. Schließlich wird (+ 1 3) ausgeführt
; und als Ergebnis 4 zurückgegeben.

; 4.

; (foldl (curry * 2) 1 '(1 2 3)) -> 48, weil zunächst (curry * 2)
; aufgelöst wird zu einer Closure, die sich wie * verhält, aber
; bereits den Faktor 2 auf jeden Fall im Endprodukt hat.
; Anschließend wird foldl ausgeführt und verwendet die Elemente der Liste
; als Argumente für die Closure. 1 wird als letztes Argument verwendet.
; (* 2 1 2 3 1) -> 48

; (map cons '(1 2 3) '(1 2 3)) -> '((1 . 1) (2 . 2) (3 . 3)),
; weil cons auf die Elemente der übergebenen Listen angewendet wird.
; Es wird mit dem jeweils ersten Element der Listen begonnen.
; Daraus ergibt sich dann:
; (cons 1 1) -> (1 . 1)
; (cons 2 2) -> (2 . 2)
; (cons 3 3) -> (3 . 3)
; Die Ergebnisse der Aufrufe von cons landen dann in der Reihenfolge
; in der Ergebnisliste.

; (filter pair? '((a b ) () 1 (()))) -> '((a b) (())), weil
; filter eine Liste solcher Elemente zurückgibt, für die pair?
; true zurückgibt. 
; (pair? '(a b)) -> #t
; (pair? '()) -> #f
; (pair? 1) -> #f
; (pair? '(())) -> #t
; Daraus ergibt sich die oben genannte Rückgabeliste.

; (map (compose (curry - 32) (curry * 1.8)) 
;     '(5505 100 0 -273.15)) -> '(-9877.0 -148.0 32 523.67), weil
; zunächst nach der inneren Reduktion die beiden curry-Aufrufe
; je eine Closure zurückgeben. Anschließend wird compose ausgeführt
; und erzeugt eine Nacheinanderausführung (closure) der beiden Closures,
; wobei die zweite Closure zuerst und die erste Closure danach
; ausgeführt wird.
; Schließlich wird map aufgerufen und führt die erstellte Nacheinanderausführung
; nacheinander für jedes Listenelement aus.
; Daraus ergibt sich:
; (closure 5505) -> (- 32 (* 1.8 5505)) -> -9877.0
; (closure 100) -> (- 32 (* 1.8 100)) -> -148.0
; (closure 0) -> (- 32 (* 1.8 0)) -> 32
; (closure -273.15) -> (- 32 (* 1.8 -273.15)) -> 523.67

; 2)
(define xs '(1 -2 3 -4 5 -6 7 9))
; 1.
(map abs xs)

; 2.
(filter 
 (λ (x)
   (= 0 (modulo x 7)))
 xs)

; 3.
(foldl +
       0
       (filter 
        (λ (x)
          (and [odd? x]
               [> x 3])
          )
        xs))

; 4.
(define (split pred xs)
  (letrec ((rec (λ (xs acc1 acc2)
                  (if (empty? xs)
                      (list acc1 acc2)
                      (if (pred (car xs))
                          (rec 
                              (cdr xs) 
                            (cons (car xs) acc1) 
                            acc2)
                          (rec
                              (cdr xs)
                            acc1
                            (cons (car xs) acc2))
                          )))))
    (rec xs '() '())))
(split odd? xs)

; 3)

; 1.

(define (key->wert key tafel)
  (cdr (assoc key tafel)))

; Datenstruktur für mögliche Ausprägungen
(define ausprägungen
  `((Form . ,'(Oval Rechteck Welle))
    (Farbe . ,'(rot blau grün))
    (Anzahl . ,'(ein zwei drei))
    (Füllung . ,'(Linie Schraffur Fläche))))

(define translationList
  `((Oval . oval)
    (Rechteck . rectangle)
    (Welle . waves)
    (rot . red)
    (blau . blue)
    (grün . green)
    (ein . 1)
    (zwei . 2)
    (drei . 3)
    (Linie . outline)
    (Schraffur . hatched)
    (Fläche . solid)))

; Eine Spielkarte ist repräsentiert durch eine Liste, die von vorne
; nach hinten die Form, Farbe, Anzahl und Füllung durch ihre Elemente angibt.

; 2. 
; erzeugt die Spielkarten
(define (erzeugeSpielkarten)
  (letrec ((rec (λ (acc cards)
                  (if (= -1 cards)
                      acc
                      (let ((d (modulo cards 3))
                            (c (modulo (floor (/ cards 3)) 3))
                            (b (modulo (floor (/ cards 9)) 3))
                            (a (modulo (floor (/ cards 27)) 3)))
                        (rec (cons (list
                                    (list-ref (key->wert 'Form ausprägungen) a)
                                    (list-ref (key->wert 'Farbe ausprägungen) b)
                                    (list-ref (key->wert 'Anzahl ausprägungen) c)
                                    (list-ref (key->wert 'Füllung ausprägungen) d))
                                   acc)
                          (- cards 1)))))))
    (rec '() 80)))

(require se3-bib/setkarten-module)

; zeigt eine Set-Karte
(define (zeigeKarte karte)
  (show-set-card
   (key->wert (third karte) translationList)
   (key->wert (first karte) translationList)
   (key->wert (fourth karte) translationList)
   (key->wert (second karte) translationList)))

(define (zeigeKarten karten)
  (map zeigeKarte karten))

; 3.

(define (is-a-set? karten)
  (let* ([gleich (λ (wert1 wert2 wert3)
                   (and 
                    (equal? wert1 wert2)
                    (equal? wert1 wert3)
                    ))]
         [verschieden (λ (wert1 wert2 wert3)
                        (and
                         (not (equal? wert1 wert2))
                         (not (equal? wert1 wert3))
                         (not (equal? wert2 wert3))
                         ))]
         [qualified (λ (wert1 wert2 wert3)
                      (or
                       (gleich wert1 wert2 wert3)
                       (verschieden wert1 wert2 wert3)
                       ))])
    (and 
     (qualified (first (first karten))
                (first (second karten))
                (first (third karten)))
     (qualified (second (first karten))
                (second (second karten))
                (second (third karten)))
     (qualified (third (first karten))
                (third (second karten))
                (third (third karten)))
     (qualified (fourth (first karten))
                (fourth (second karten))
                (fourth (third karten))))))

(display "is-a-set?(#t): ")
(is-a-set? '((Oval rot ein Linie)
             (Rechteck rot zwei Linie)
             (Welle rot drei Linie)))
(display "is-a-set?(#f): ")
(is-a-set? '((Oval rot ein Linie)
             (Oval blau zwei Fläche)
             (Welle rot drei Linie)))

