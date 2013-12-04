#lang racket

#|
SE 3 Funktional Blatt 5
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)
; Folgende Teilprobleme sind zu lösen:
; - bestimmen der rezessiven Merkmale des Vaters
; - bestimmen der rezessiven Merkmale der Mutter
; - bestimmen der vererbten Merkmale des Vaters
; - bestimmen der vererbten Merkmale der Mutter
; - bestimmen der sichtbaren Merkmale von Kindern
; - anzeigen eines Schmetterlings
; - bestimmen von beliebig vielen Kindern

; Das Programm hat die Hauptfunktion mendel, die als Parameter die dominanten
; Merkmale des Vaters und der Mutter, sowie die Anzahl der Kinder bekommt.

; Davon ausgehend werden dann zufällig die rezessiven Merkmale des Vaters bzw. der Mutter
; gewählt. Dafür wird eine Funktion randomRezessiv benötigt, die ebendies bewerkstelligt.

; randomRezessiv greift auf die Dominanzliste zurück. Dafür wird eine Zugriffsfunktion
; key->wert benutzt. Zusätzlich wird eine Hilfsfunktion (randomList) benutzt, um
; von der Liste der dominierten Merkmale ein zufälliges Merkmal auszuwählen.

; randomSelection wählt aus gegebenen dominanten und rezessiven Merkmalen zufällig eine Liste
; an Merkmalen aus, die dann die vererbten Merkmale darstellen.

; sichtbar ermittelt bei gegebenen Merkmalen des Vaters und der Mutter 
; die sichtbaren Elemente.

; zeigeSchmetterling zeigt einen Schmetterling bei gegebenen Merkmalen in einer Liste an.

; Die Datenstruktur zum Speichern des Genoms ist sehr einfach:
; Es ist eine Liste von Listen, deren erstes Element jeweils ein Merkmal darstellt
; und deren zweites Element jeweils eine Liste von Merkmalen darstellt, 
; die von dem Merkmal an erster Stelle dominiert werden.

; Durch diesen Entwurf lassen sich die Teilprobleme leicht lösen und es
; wird eine optimale Anzahl an Funktionen erreicht, die nicht mehr aber auch
; nicht weniger machen, als benötigt wird.

; Datenstruktur der Dominanzabhängigkeiten, wobei der Wert immer eine Liste
; all jener Merkmale ist, die von dem key dominiert werden
(define dominanzliste
  '((punkte . (streifen sterne))
    (streifen . (sterne))
    (sterne . (sterne))
    (rot . (gruen blau gelb))
    (gruen . (blau gelb))
    (blau . (gelb))
    (gelb . (gelb))
    (gerade . (gekruemmt geschweift))
    (gekruemmt . (geschweift))
    (geschweift . (geschweift))
    (rhombisch . (hexagonal elliptisch))
    (hexagonal . (elliptisch))
    (elliptisch . (elliptisch))
    ))

; Datenstruktur für Übersetzung, um show-butterfly korrekt aufzurufen
(define translationlist
  '((punkte . dots)
    (streifen . stripes)
    (sterne . stars)
    (rot . red)
    (gruen . green)
    (blau . blue)
    (gelb . yellow)
    (gerade . straight)
    (gekruemmt . curved)
    (geschweift . curly)
    (rhombisch . rhomb)
    (hexagonal . hexagon)
    (elliptisch . ellipse)
    ))

; gibt den Wert von key in tafel zurück
(define (key->wert key tafel)
  (cdr (assoc key tafel)))

; wählt ein zufälliges Element einer Liste aus
(define (randomListe xs)
  (car (shuffle xs)))

; wählt zu einer gegebenen Liste an dominanten Merkmalen die rezessiven Merkmale aus
(define (randomRezessiv dominant)
  (letrec ((help (λ (xs result)
                   (if (empty? xs)
                       result
                       (help 
                        (cdr xs) 
                        (cons 
                         (randomListe (key->wert (car xs) dominanzliste))
                         result
                         ))
                       ))))
    (reverse (help dominant '()))))

; wählt von den gegebenen Elementen zufällig eines aus
(define (randomElement x y)
  (let ((r (random 2)))
    (if (= r 0)
        x
        y)))

; wählt aus der Liste der dominanten und rezessiven Merkmale zufällig
; Merkmale aus
(define (randomSelection dominant rezessiv)
  (letrec ((select (λ (xs ys result)
                     (if (empty? xs)
                         result
                         (select (cdr xs) (cdr ys) (cons (randomElement (car xs) (car ys)) 
                                                         result))
                         ))))
    (reverse (select dominant rezessiv '()))))

; bestimmt aus den zufälligen Merkmalen des Vaters und der Mutter die sichtbaren Elemente
; beim Kind
(define (sichtbar vaterMerkmale mutterMerkmale)
  (letrec ((rec (λ (xs ys result)
                  (if (empty? xs)
                      result
                      (if (empty? (filter (λ (x) (equal? x (car ys))) (key->wert (car xs) dominanzliste)))
                          (rec (cdr xs) (cdr ys) (cons (car ys) result))
                          (rec (cdr xs) (cdr ys) (cons (car xs) result))
                          )))))
    (reverse (rec vaterMerkmale mutterMerkmale '()))))

(require se3-bib/butterfly-module)

(define (zeigeSchmetterling merkmale)
  (show-butterfly (key->wert (cadr merkmale) translationlist)
                  (key->wert (car merkmale) translationlist)
                  (key->wert (caddr merkmale) translationlist)
                  (key->wert (cadddr merkmale) translationlist)
                  ))
; zeigt (in dieser Reihenfolge) den Vater, die Mutter und die Kinder
(define (mendel vaterDominant mutterDominant anzahlKinder)
  (let ((vaterRezessiv (randomRezessiv vaterDominant))
        (mutterRezessiv (randomRezessiv mutterDominant))
        )
    (letrec ((rec (λ (counter result)
                    (if (= 0 counter)
                        result
                        (rec (- counter 1) 
                          (cons (sichtbar 
                                 (randomSelection vaterDominant vaterRezessiv) 
                                 (randomSelection mutterDominant mutterRezessiv)) 
                                result))))))
      (map zeigeSchmetterling (cons vaterDominant (cons mutterDominant (rec anzahlKinder '()))))
      )
    )
  )

; Austesten des Falles von einem Vater, der als dominante Merkmale die absolut
; dominantesten Merkmale hat und einer Mutter, die als dominante Merkmale die absolut
; schwächsten Merkmale hat

; diese Daten testen einen möglichen Extremfall
; bei diesem Fall sind die vererbten Merkmale der Mutter immer dieselben
; ein Merkmal der Mutter wird sich daher nur durchsetzen, wenn der Vater dies als
; rezessives Merkmal hat und das rezessive Merkmal vom Vater vererbt wird
(mendel '(punkte rot gerade rhombisch) '(sterne gelb geschweift elliptisch) 2)

; Austesten des Falles, dass sowohl Vater als auch Mutter die schwächsten Merkmale
; als dominante Merkmale haben
; bei diesem Extremfall sehen die Kinder genau gleich aus (alle von 1 bis n)
(mendel '(sterne gelb geschweift elliptisch) '(sterne gelb geschweift elliptisch) 2)

; Austesten des Falles, dass beide Elternteile die dominantesten Merkmale
; als dominante Merkmale haben. Die Kinder können hier die größten Unterschiede aufweisen.
; In den meisten Fällen werden sie aber so aussehen, wie die Eltern.
(mendel '(punkte rot gerade rhombisch) '(punkte rot gerade rhombisch) 2)

; 2)
; überprüft, ob ein Element in einer Liste ist
(define (in-list? element list)
  (if (pair? (member element list))
      #t
      #f))

(define erbbarliste
  '((punkte . (punkte streifen sterne))
    (streifen . (streifen sterne))
    (sterne . (sterne))
    (rot . (rot gruen blau gelb))
    (gruen . (gruen blau gelb))
    (blau . (blau gelb))
    (gelb . (gelb))
    (gerade . (gerade gekruemmt geschweift))
    (gekruemmt . (gekruemmt geschweift))
    (geschweift . (geschweift))
    (rhombisch . (rhombisch hexagonal elliptisch))
    (hexagonal . (hexagonal elliptisch))
    (elliptisch . (elliptisch))
    ))

; überprüft, ob das Kind von den Eltern abstammen kann
(define (testeElternschaft sichtbarVater sichtbarMutter sichtbarKind)
  (letrec ((rec (λ (xs ys zs valid)
               (if (or (not valid) (empty? xs))
                   valid
                   (rec (cdr xs)
                     (cdr ys) 
                     (cdr zs) 
                     (or (in-list? (car zs) (key->wert (car xs) erbbarliste))
                         (in-list? (car zs) (key->wert (car ys) erbbarliste))
                     ))
                  ))))
    (rec sichtbarVater sichtbarMutter sichtbarKind #t)))

(display "\nKönnen Anton und Antonia die Eltern von Toni sein:")
(testeElternschaft '(sterne gruen geschweift rhombisch) '(streifen blau gekruemmt hexagonal) '(sterne rot gekruemmt rhombisch))
(display "\nKönnen Anton und Antonia die Eltern von Tini sein:")
(testeElternschaft '(sterne gruen geschweift rhombisch) '(streifen blau gekruemmt hexagonal) '(punkte gruen gerade rhombisch))
(display "\nKönnen Anton und Antonia die Eltern von Tina sein:")
(testeElternschaft '(sterne gruen geschweift rhombisch) '(streifen blau gekruemmt hexagonal) '(streifen gelb geschweift elliptisch))