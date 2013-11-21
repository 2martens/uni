#lang racket

#|
SE 3 Funktional Blatt 3
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1.1
; Diese Datenstruktur in Form einer Funktion erlaubt das Zurückgeben einer
; Liste, die an erster Stelle den Buchstaben und an zweiter Stelle dessen
; Zuordnung im Buchstabieralphabet als Symbol enthält.

; Die Rückgabe einer Liste mit dem Buchstaben an erster Stelle und einer
; Liste als zweitem Element, die wiederum den Schlüssel an erster Stelle
; enthält, erlaubt ein einfaches Auswerten der Zuordnung.
(define buchstabiertafel
  '((#\A . Alfa)
    (#\B . Bravo)
    (#\C . Charlie)
    (#\D . Delta)
    (#\E . Echo)
    (#\F . Foxtrott)
    (#\G . Golf)
    (#\H . Hotel)
    (#\I . India)
    (#\J . Juliett)
    (#\K . Kilo)
    (#\L . Lima)
    (#\M . Mike)
    (#\N . November)
    (#\O . Oscar)
    (#\P . Papa)
    (#\Q . Quebec)
    (#\R . Romeo)
    (#\S . Sierra)
    (#\T . Tango)
    (#\U . Uniform)
    (#\V . Viktor)
    (#\W . Whiskey)
    (#\X . X-ray)
    (#\Y . Yankee)
    (#\Z . Zulu)
    (#\0 . Nadazero)
    (#\1 . Unaone)
    (#\2 . Bissotwo)
    (#\3 . Terrathree)
    (#\4 . Kartefour)
    (#\5 . Pantafive)
    (#\6 . Sosisix)
    (#\7 . Setteseven)
    (#\8 . Oktoeight)
    (#\9 . Novenine)
    (#\, . Decimal)
    (#\. . Stop)
    ))

; 1.2
(define (char->schlüssel char tafel)
  (cdr (assoc (char->upper char) tafel)))

; 1.3
(define (char->upper char)
  (let ([charInt (char->integer char)])
    (cond ([<= 96 charInt 122] (integer->char (- charInt 32)))
          ([<= 65 charInt 90] (integer->char charInt))
          (else char))))
                            
; 1.4
(define (buchstabiere text tafel)
  (letrec ((rec (λ (xs)
                  (if (null? xs)
                      null
                      (cons (char->schlüssel (car xs) tafel)
                            (rec (cdr xs)))))))
    (rec (string->list text))))

(require se3-bib/flaggen-module)
; 2.1
; Analoger Entwurf wie bei 1.1, diesmal mit den Flaggen.
(define flaggentafel
  `((#\A . ,A)
    (#\B . ,B)
    (#\C . ,C)
    (#\D . ,D)
    (#\E . ,E)
    (#\F . ,F)
    (#\G . ,G)
    (#\H . ,H)
    (#\I . ,I)
    (#\J . ,J)
    (#\K . ,K)
    (#\L . ,L)
    (#\M . ,M)
    (#\N . ,N)
    (#\O . ,O)
    (#\P . ,P)
    (#\Q . ,Q)
    (#\R . ,R)
    (#\S . ,S)
    (#\T . ,T)
    (#\U . ,U)
    (#\V . ,V)
    (#\W . ,W)
    (#\X . ,X)
    (#\Y . ,Y)
    (#\Z . ,Z)
    (#\0 . ,Z0)
    (#\1 . ,Z1)
    (#\2 . ,Z2)
    (#\3 . ,Z3)
    (#\4 . ,Z4)
    (#\5 . ,Z5)
    (#\6 . ,Z6)
    (#\7 . ,Z7)
    (#\8 . ,Z8)
    (#\9 . ,Z9)
    ))