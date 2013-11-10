#lang racket

#|
SE 3 Funktional Blatt 2
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1) Definitionen
(define miau 'Katze)
(define plueschi miau)
(define peter 'miau)
(define (welcherNameGiltWo PersonA PersonB)
  (let ((PersonA 'Sam)
        (PersonC PersonA))
    PersonC))
(define xs1 '(0 1 2 miau plueschi))
(define xs3 (list miau plueschi))
(define xs2 (cons plueschi miau))

#| 1. zu 'Katze, da miau als 'Katze definiert wurde
2. zu 'Katze, da plueschi als miau definiert wurde, 
welches als 'Katze definiert wurde
bei der Ausführung werden Symbole so lange ausgewertet, bis ein ' auftaucht
oder eine Zahl/ein String
3. zu 'miau, da peter als 'miau definiert wurde und ' die Auswertung von miau verhindert
4. zu 'plueschi, da die Funktion quote das Symbol selbst ohne Auswertung zurückgibt
5. zu 'Katze, da eval den Inhalt von peter auswertet, welcher das Symbol miau ist
6. wirft Fehler, da kein Symbol Katze definiert wurde, eben dieses aber in miau als Inhalt steht
durch eval wird nun versucht den Inhalt von miau auszuwerten, also den Inhalt von Katze zu finden
das geschieht, weil vor Ausführung von eval bereits plueschi zu 'Katze ausgewertet wird
7. zu 'Katze, da nun das Symbol plueschi selbst ausgewertet wird durch eval, was miau und damit 'Katze ergibt
8. zu 'Ich, da das Symbol Ich den Wert 'Sam zugewiesen bekommt und PersonC den Wert 'Ich
bei der anschließenden Rückgabe von PersonC wird daher 'Ich zurückgegeben
9. zu '(miau plueschi), da die ersten drei Listenglieder durch cdddr entfernt werden
und nur die verbleibende Liste zurückgegeben wird
10. zu 'Katze, da (cons plueschi miau) ein Paar mit den Werten 'Katze und 'Katze erzeugt
cdr gibt nun das zweite Element zurück
11. zu '(Katze), da (list plueschi miau) eine Liste '('Katze 'Katze) erzeugt
cdr schneidet das erste Element ab und gibt die verbleibende Liste zurück
12. zu 0.1411200080598672, da zunächst der Sinus von 3 berechnet wird 
und eval einer Zahl eben diese zurückgibt
13. zu 'peter, da der Aufruf von welcherNameGiltWo 'peter zurückgibt
eval wird also mit ''peter aufgerufen; die Auswertung durch eval ergibt daher 'peter
14. zu 'miau, da der Aufruf von welcherNameGiltWo 'peter zurückgibt
eval wird also mit 'peter aufgerufen; eval wertet damit das Symbol peter aus, welches den Wert 'miau hat
|#

; 2.1
(define (fakultaet n)
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x)
                     ; 0! ergibt 1
                     (cond ([= 0 x] 1)
                           ; ansonsten ergibt sich x! aus x*(x-1)!
                           (else (* x (helper (- x 1)))
                                 )
                           )
                     )
                   )
           )
    ; aufrufen der rekursiven Hilfsfunktion
    (helper n)
    )
  )

; 2.2
(define (power r n)
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x y)
                     ; r⁰ ergibt immer 1
                     (cond ([= 0 y] 1)
                           ; wenn y gerade ist, dann rechne (x^(y/2))² 
                           ([even? y] 
                            (sqr (expt x (/ y 2)))
                            )
                           ; ansonsten rechne x*x^(y-1)
                           (else 
                            (* (expt x (- y 1)) x)
                            )
                           )
                     )
                   )
           )
    ; aufrufen der rekursiven Hilfsfunktion
    (helper r n)
    )
  )

; 2.3
; berechnen des Limits hier aus Gründen der Optimierung
(define limit (power 10 1000))
(define e 
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x y)
                     ; wenn x kleiner als 1/(10^1000) ist, breche ab
                     (cond ([< x (/ 1 limit)] 0)
                           ; ansonsten addiere x mit dem Ergebnis aus einem weiteren Aufruf
                           ; der Hilfsfunktion
                           (else 
                            (+ x (helper (/ 1 (fakultaet (+ y 1))) (+ y 1) ))
                            )
                           )
                     )
                   )
           )
    ; aufrufen der Hilfsfunktion und multiplizieren des Ergebnisses mit
    ; 10^1001
    (* (helper 1 0) 10 limit)
    )
  )

; 2.4
(define my-pi 
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x plus?)
                     ; wenn x größer ist als 22000, breche ab
                     (cond ([> x 22000] 0)
                           ; andernfalls fahre fort
                           (else
                            ; und addiere 1/x
                            (cond (plus?
                                   (+ (/ 1 x) (helper (+ x 2) #f))
                                   )
                                  ; oder -1/x mit dem Ergebnis eines weiteren Aufrufs der Hilfsfunktion
                                  (else 
                                   (+ (* -1 (/ 1 x)) (helper (+ x 2) #t))
                                   )
                                  )
                            )
                           )
                     )
                   ))
    ; aufrufen der Hilfsfunktion und anschließendes Multiplizieren mit
    ; 4 und 10^1000
    (* (* (helper 1 #t) 4) limit)
    )
  )

; 3
; Typbestimmung
(define (type-of input)
  (cond ([boolean? input] 'boolean)
        ([list? input] 'list)
        ([pair? input] 'pair)
        ([symbol? input] 'symbol)
        ([number? input] 'number)
        ([char? input] 'char)
        ([string? input] 'string)
        ([vector? input] 'vector)
        ([procedure? input] 'procedure)
        (else 'noneOfThem)
        )
  )

; Ausgaben
(display "(type-of (+ 3 7)): ")
(type-of (+ 3 7))
; zu 'number, da (+ 3 7) zunächst zu 10 und damit einer number ausgewertet wird
(display "(type-of type-of): ")
(type-of type-of)
; zu 'procedure, da type-of eine Funktion ist
(display "(type-of (type-of type-of)): ")
(type-of (type-of type-of))
; zu 'symbol, da (type-of type-of) 'procedure zurückgibt und dies ein Symbol ist
(display "(type-of (string-ref \"Schneewitchen_und_die_7_Zwerge\" 2)): ")
(type-of (string-ref "Schneewitchen_und_die_7_Zwerge" 2))
; zu 'char, da string-ref den char an der Position 2 zurückgibt
(display "(type-of (lambda (x) x)): ")
(type-of (lambda (x) x))
; zu 'procedure, da lambda eine Funktion erstellt
(define (id z) z)
(display "(type-of (id cos)): ")
(type-of (id cos))
; zu 'procedure, da id den Parameter zurückgibt, welcher eine Funktion ist
(display "(type-of '(1 2 3)): ")
(type-of '(1 2 3))
; zu 'list, da '(1 2 3) eine Liste ist
(display "(type-of '()): ")
(type-of '())
; zu 'list, da '() eine leere Liste ist
