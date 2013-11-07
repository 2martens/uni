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
                     (cond ([= 0 x] 1)
                           (else (* x (helper (- x 1)))
                                 )
                           )
                     )
                   )
           )
    (helper n)
    )
  )

; 2.2
(define (power r n)
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x y)
                     (cond ([= 0 y] 1)
                           ([even? y] 
                            (sqr (expt x (/ y 2)))
                            )
                           (else 
                            (* (expt x (- y 1)) x)
                            )
                           )
                     )
                   )
           )
    (helper r n)
    )
  )

; 2.3
(define e 
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x y)
                     (cond ([< x (/ 1 (power 10 1000))] 0)
                           (else 
                            (+ x (helper (/ 1 (fakultaet (+ y 1))) (+ y 1) ))
                            )
                           )
                     )
                   )
           )
    (* (helper 1 0) (power 10 1001))
    )
  )

; 2.4
(define my-pi 
  (letrec (
           ; rekursive Hilfsfunktion
           (helper (λ (x plus?)
                     (cond ([> x 22000] 0)
                           (else
                            (cond (plus?
                                   (+ (/ 1 x) (helper (+ x 2) #f))
                                   )
                                  (else 
                                   (+ (* -1 (/ 1 x)) (helper (+ x 2) #t))
                                   )
                                  )
                            )
                           )
                     )
                   ))
    (* (* (helper 1 #t) 4) (power 10 1000))
    )
  )

; 3
(define (type-of input)
  (cond ([boolean? input] 'boolean)
        ([pair? input] 'pair)
        ([list? input] 'list)
        ([symbol? input] 'symbol)
        ([number? input] 'number)
        ([char? input] 'char)
        ([string? input] 'string)
        ([vector? input] 'vector)
        ([procedure? input] 'procedure)
        )
  )

; Ausgaben
(display "(type-of (+ 3 7)): ")
(type-of (+ 3 7))
(display "(type-of type-of): ")
(type-of type-of)
(display "(type-of (type-of type-of)): ")
(type-of (type-of type-of))
(display "(type-of (string-ref \"Schneewitchen_und_die_7_Zwerge\" 2)): ")
(type-of (string-ref "Schneewitchen_und_die_7_Zwerge" 2))
(display "(type-of (lambda (x) x)): ")
(type-of (lambda (x) x))
(define (id z) z)
(display "(type-of (id cos)): ")
(type-of (id cos))
(display "(type-of '(1 2 3)): ")
(type-of '(1 2 3))
(display "(type-of '()): ")
(type-of '())
