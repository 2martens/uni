#lang swindle

#|
SE 3 Funktional Blatt 11
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

(require (lib "prologDB.ss" "se3-bib" "prolog")
         (lib "unify.ss"  "se3-bib" "prolog")
         (lib "prolog.ss" "se3-bib" "prolog")
         (lib "prologInScheme.ss"  "se3-bib" "prolog"))

; 1)

; 1.1

; Ausdruck1                      |  Variablenbindungen:
; Ausdruck2

; (gebaeude ?Haus weiss)         | '((?Farbe . weiss) (?Haus . Informatikum))
; (gebaeude Informatikum ?Farbe)

; (Karten ((k Pik As) (k Herz Dame)))  | #f
; (Karten ((k Pik As) (k Herz Koenig)))

; (Karten ((k Pik As) (k Herz Dame)))  | '((?Farbe . Dame))
; (Karten ((k Pik As) (k Herz ?Farbe))) 

; (Karten ((k Pik As) (k Herz Dame)))  | '((?Farbe . Dame))
; (Karten ((k Pik As) (k Herz ?Farbe))) 

; (Karten ((k Pik As) . ?andere))      | '((?andere (k Herz Koenig) (k Kreuz Dame)))
; (Karten ((k Pik As) (k Herz Koenig) (k Kreuz Dame))) 

; (Paar (k ?farbe As) (k Pik ?wert))   | '((?wert . As) (?farbe . Pik))
; (Paar (k Pik ?wert) (k ?farbe As))

; (Paar (k ?farbe As) (k Pik ?wert2))  | '((?wert2 . As) (?wert . As) (?farbe . Pik))
; (Paar (k Pik ?wert) (k ?farbe ?wert))

; 1.2
(<- (ausleihe "K 110" 100))
(<- (ausleihe "P 30" 102))
(<- (ausleihe "P 32" 104))
(<- (ausleihe "P 50" 104))
; (vorbestellung Signatur Lesernummer)
(<- (vorbestellung "K 110" 104))
(<- (vorbestellung "K 110" 102))
(<- (vorbestellung "P 30" 100))
(<- (vorbestellung "P 30" 104))
; (leser Name Vorname Lesernummer Geburtsjahr)
(<- (leser Neugierig Nena 100 1989))
(<- (leser Linux Leo 102 1990))
(<- (leser Luator Eva 104 1988))

; 1.

;(?- (ausleihe "K 110" ?lesernummer))

; 2.
;(?- (leser Linux Leo ?lesernummer ?))

; 3.
;(?- (vorbestellung "P 30" ?lesernummer)
;    (leser ?nachname ?vorname ?lesernummer ?))

; 4.

; 2)

; 3)
