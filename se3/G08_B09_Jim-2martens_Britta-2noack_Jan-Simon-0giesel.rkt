#lang swindle

(require swindle/setf
         swindle/misc)

#|
SE 3 Funktional Blatt 9
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)

; 1.1

; allgemeine wissenschaftliche Publikation
(defclass* publikation ()
  (schlüssel
   :reader publikation-schlüssel
   :writer set-publikation-schlüssel!
   :initvalue 0
   :initarg :pubSchlüssel
   :documentation "Der Schlüssel der Publikation"
   )
  (autoren
   :reader publikation-autoren
   :writer set-publikation-autoren!
   :initvalue '()
   :initarg :pubAutoren
   :type <list>
   :documentation "Die Autoren der Publikation"
   )
  (jahr
   :reader publikation-jahr
   :writer set-publikation-jahr!
   :initvalue "0"
   :initarg :pubJahr
   :type <string>
   :documentation "Das Erscheinungsjahr"
   )
  (titel
   :reader publikation-titel
   :writer set-publikation-titel!
   :initvalue ""
   :initarg :pubTitel
   :type <string>
   :documentation "Der Titel"
   )
  :autopred #t
  :printer #t
  :documentation "The top class of all publications"
  )

; Buch erbt von Publikation
(defclass* buch (publikation)
  (verlag
   :reader buch-verlag
   :writer set-buch-verlag!
   :initvalue ""
   :initarg :buchVerlag
   :type <string>
   :documentation "Der Verlag des Buches"
   )
  (verlagort
   :reader buch-verlagort
   :writer set-buch-verlagort!
   :initvalue ""
   :initarg :buchVerlagort
   :type <string>
   :documentation "Der Ort des Verlages"
   )
  (reihe
   :reader buch-reihe
   :writer set-buch-reihe!
   :initvalue ""
   :initarg :buchReihe
   :type <string>
   :documentation "Die Reihe des Buches"
   )
  (reihe-seriennummer
   :reader buch-reihe-seriennummer
   :writer set-buch-reihe-seriennummer!
   :initvalue "0"
   :initarg :buchSeriennummer
   :type <string>
   :documentation "Die Seriennummer in der Reihe"
   )
  (edition
   :reader buch-edition
   :writer set-buch-edition!
   :initvalue "1"
   :initarg :buchEdition
   :type <string>
   :documentation "Die Edition des Buches"
   )
  :autopred #t
  :printer #t
  :documentation "Ein Buch"
  )

; Sammelbände erbt von Buch
(defclass* sammelband (buch)
  (herausgeber
   :reader sammelband-herausgeber
   :writer set-sammelband-herausgeber!
   :initvalue ""
   :initarg :sammelbandHerausgeber
   :type <string>
   :documentation "Herausgeber des Sammelbands"
   )
  (seitenangabe
   :reader sammelband-seitenangabe
   :writer set-sammelband-seitenangabe!
   :initvalue ""
   :initarg :sammelbandSeitenangabe
   :type <string>
   :documentation "Die Seiten des Artikels"
   )
  (name
   :reader sammelband-name
   :writer set-sammelband-name!
   :initvalue ""
   :initarg :sammelbandName
   :type <string>
   :documentation "Name des Sammelbandes"
   )
  :autopred #t
  :printer #t
  :documentation "Ein Sammelband"
  )

; Zeitschriftenartikel
(defclass* zeitschrift (publikation)
  (name
   :reader zeitschrift-name
   :writer set-zeitschrift-name!
   :initvalue ""
   :initarg :zeitschriftName
   :type <string>
   :documentation "Der Name der Zeitschrift"
   )
  (band-nummer
   :reader zeitschrift-band-nummer
   :writer set-zeitschrift-band-nummer!
   :initvalue "0"
   :initarg :zeitschriftBandnummer
   :type <string>
   :documentation "Die Bandnummer der Zeitschrift"
   )
  (heft-nummer
   :reader zeitschrift-heft-nummer
   :writer set-zeitschrift-heft-nummer!
   :initvalue "0"
   :initarg :zeitschriftHeftnummer
   :type <string>
   :documentation "Die Nummer des Heftes"
   )
  (monat
   :reader zeitschrift-monat
   :writer set-zeitschrift-monat!
   :initvalue 'Januar
   :initarg :zeitschriftMonat
   :type <symbol>
   :documentation "Der Erscheinungsmonat der Zeitschrift"
   )
  :autopred #t
  :printer #t
  :documentation "Ein Zeitschriftenartikel"
  )

; Nessie
(define nessie 
  (make buch :pubTitel "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
        :pubJahr "1790"
        :pubSchlüssel 'Nessie1790
        :pubAutoren '("Nessie")
        :buchVerlag "Minority-Verlag"
        :buchVerlagort "Inverness"
        :buchReihe "Die besondere Biographie"
        :buchSeriennummer "Band 1 der Reihe"))

; Prefect, F.
(define prefect
  (make sammelband 
        :pubTitel "Mostly harmless - some observations concerning the third planet of the solar system"
        :pubJahr "1979"
        :pubSchlüssel 'Prefect1979
        :pubAutoren '("Prefect, F.")
        :buchVerlag "Galactic Press"
        :buchVerlagort "Vega-System, 3rd planet"
        :buchReihe "\"Travel in Style\""
        :buchSeriennummer "volume 5 of"
        :buchEdition "1500 edition"
        :sammelbandHerausgeber "Adams D., editor"
        :sammelbandSeitenangabe "p. 500"
        :sammelbandName "The Hitchhiker's Guide to the Galaxy"
        ))

; Wells
(define wells
  (make zeitschrift
        :pubSchlüssel 'Wells3200
        :pubTitel "Zeitmaschinen leicht gemacht"
        :pubAutoren '("Wells, H. G.")
        :pubJahr "3200"
        :zeitschriftName "Heimwerkerpraxis für Anfänger"
        :zeitschriftBandnummer "500"
        :zeitschriftHeftnummer "3"
        ))
; 1.2

(defgeneric cite ((pub publikation)))
; cite Methode für Bücher
(defmethod cite ((pub buch))
  "Display the correct citation for given book"
  (display (string-append 
            (car (publikation-autoren pub))
            " (" (publikation-jahr pub) "). "
            (publikation-titel pub) ", "
            (buch-reihe-seriennummer pub) ": " 
            (buch-reihe pub) ". "
            (buch-verlag pub) ", " (buch-verlagort pub)
            ".")))
; cite Methode für Sammelbände
(defmethod cite ((pub sammelband))
  "Display the correct citation for given collection"
  (display (string-append 
            (car (publikation-autoren pub))
            " (" (publikation-jahr pub) "). "
            (publikation-titel pub) ". In "
            (sammelband-herausgeber pub) ", "
            (sammelband-name pub) ", "
            (buch-reihe-seriennummer pub)" " 
            (buch-reihe pub) ". "
            (buch-verlag pub) ", " (buch-verlagort pub)
            ", " (buch-edition pub) ", " 
            (sammelband-seitenangabe pub) ".")))

; cite Methode für Zeitschriften
(defmethod cite ((pub zeitschrift))
  "Display the correct citation for given magazine article"
  (display (string-append
            (car (publikation-autoren pub))
            " (" (publikation-jahr pub) "). "
            (publikation-titel pub) ". "
            (zeitschrift-name pub) ", "
            (zeitschrift-band-nummer pub) "("
            (zeitschrift-heft-nummer pub) ").")))
  
; 1.3

; Eine Ergänzungsmethode kann vor und nach der Methode der Oberklasse
; ausgeführt werden. Außerdem kann sie einhüllend wirken und wird sowohl vor
; als auch nach der Elternmethode aufgerufen.

; Die Vorteile sind, dass jede Ergänzungsmethode ausgeführt wird
; und damit keine Initialisierungen vergessen oder unterdrückt 
; werden können, die in den Oberklassen definiert wurden.
; Desweiteren brauchen die geerbten Methoden nicht durch
; Modifikationen überladen zu werden, sondern werden nur
; ergänzt.

; Ergänzungsmethoden könnten dazu genutzt werden die Basis-cite
; Methode zu ergänzen, sodass nicht eine Methode für jede Publikationsform
; von Nöten ist. Dabei könnten die Informationen schrittweise
; aufgebaut werden. Allgemeine Information zu Beginn, dann buchspezifische,
; dann sammelbandspezifische. Für Zeitschriften würde eine alternative
; Reihenfolge von allgemeinen und zeitschriftenspezifischen
; Informationen genutzt werden.

; Allerdings käme es dort zu Problemen, wo Informationen zwischendrin
; eingefügt werden müssen. Die Sammelbandseitenangabe zum Beispiel erfolgt
; am Schluss, die restlichen Informationen jedoch in der Mitte vor den 
; Buchinformationen wie Reihe und Verlag.

; 2)

; 2.1

;(defclass fahrzeug ())

; allgemeine Landfahrzeuge
;(defclass landfahrzeug (fahrzeug))
; Schienenfahrzeuge
;(defclass schienenfahrzeug (fahrzeug))
; Straßenfahrzeuge
;(defclass straßenfahrzeug (fahrzeug))
;(defclass wasserfahrzeug (fahrzeug))
;(defclass luftfahrzeug (fahrzeug))

;(defclass amphibienfahrzeug (wasserfahrzeug landfahrzeug))
;(defclass amphibienflugzeug (luftfahrzeug wasserfahrzeug straßenfahrzeug))
;(defclass zweiwegefahrzeug (schienenfahrzeug straßenfahrzeug))
;(defclass zeitzug (schienenfahrzeug luftfahrzeug))

; 2.2

; da ein Fahrzeug mehrere Medien aufweisen kann, ist es sinnvoll
; diese in einer Liste zurückzugeben 
(defgeneric getMedium ((fz fahrzeug))
  :combination generic-list-combination)
; von allen Medien muss die geringste Höchstgeschwindigkeit genommen werden
; daher ist die min combination hier richtig
(defgeneric getMaxSpeed ((fz fahrzeug))
  :combination generic-min-combination)
; auch bei der Tragfähigkeit ist die geringst mögliche Tragfähigkeit
; von Interesse
(defgeneric getTragfähigkeit ((fz fahrzeug))
  :combination generic-min-combination)
; beim Verbrauch hingegen ist der maximale Verbrauch über alle
; Medien interessant
(defgeneric getVerbrauchPro100km ((fz fahrzeug))
  :combination generic-max-combination)
; die Passagierzahl wiederum ist durch die geringste Größe unter allen Medien
; limitiert, womit hier ebenso eine min combination anzuwenden ist
(defgeneric getPassagierzahl ((fz fahrzeug))
  :combination generic-min-combination)

; 2.3

; Implementation zur Abfrage des Mediums

(defclass fahrzeug ()
  :printer #t)
(defclass landfahrzeug (fahrzeug)
  (check
   :reader landfahrzeug-check
   :initvalue #t
   )
  :printer #t)
(defmethod getMedium ((fz landfahrzeug))
  'Land)

(defclass schienenfahrzeug (fahrzeug)
  :printer #t)
(defmethod getMedium ((fz schienenfahrzeug))
  'Schiene)

(defclass straßenfahrzeug (fahrzeug)
  :printer #t)
(defmethod getMedium ((fz straßenfahrzeug))
  'Straße)

(defclass wasserfahrzeug (fahrzeug))
(defmethod getMedium ((fz wasserfahrzeug))
  'Wasser)

(defclass luftfahrzeug (fahrzeug))
(defmethod getMedium ((fz luftfahrzeug))
  'Luft)

(defclass amphibienfahrzeug (wasserfahrzeug landfahrzeug))
(defclass amphibienflugzeug (luftfahrzeug wasserfahrzeug straßenfahrzeug))
(defclass zweiwegefahrzeug (schienenfahrzeug straßenfahrzeug))
(defclass zeitzug (schienenfahrzeug luftfahrzeug))

; Die Funktion getMedium wird bei ampFahrzeug zunächst für
; Wasserfahrzeuge aufgerufen, da nach der Klassenpräzedenz-
; liste Wasserfahrzeug vor Landfahrzeug kommt.
; Anschließend wird die Funktion für Landfahrzeuge aufgerufen.

; Da die generische Funktion getMedium mit der list combination
; verwendet wird, werden die Ausgaben der einzelnen Funktionsaufrufe
; in eine Liste kombiniert und zurückgegeben. Das wären in diesem
; Fall also 'Wasser und 'Land, die insgesamte Rückgabe sieht dann
; so aus: '(Wasser Land)
; Da Fahrzeug die generische Funktion nicht implementiert,
; bleibt es bei den beiden Funktionsaufrufen.

; Bei ampFlugzeug funktioniert es analog und es wird
; '(Luft Wasser Straße) zurückgegeben.

; Bei schienenbus verhält es sich analog und die Rückgabe
; ist '(Schiene Straße).

; Für zug wird '(Schiene Luft) zurückgegeben.

; Die Klassenpräzedenzliste ist hier unerlässlich, um die Reihenfolge
; der Funktionen zu bestimmen. Wenn die combination der jeweiligen
; generischen Funktion nur ein Ergebnis zurückgibt (bspw. begin combination),
; dann bestimmt die Liste auch das Ergebnis.
; Ohne eine combination wird auch nur die Funktion ausgeführt,
; deren zugehörige Klasse in der Präzendenzliste ganz vorne steht.

(define ampFahrzeug (make amphibienfahrzeug))
(define ampFlugzeug (make amphibienflugzeug))
(define schienenbus (make zweiwegefahrzeug))
(define zug (make zeitzug))