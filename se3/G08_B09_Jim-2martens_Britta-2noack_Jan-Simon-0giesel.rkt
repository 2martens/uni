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

; 2)

; 2.1

(defclass fahrzeug ())

(defclass landfahrzeug (fahrzeug))
(defclass schienenfahrzeug (landfahrzeug))
(defclass straßenfahrzeug (landfahrzeug))
(defclass wasserfahrzeug (fahrzeug))
(defclass luftfahrzeug (fahrzeug))

(defclass amphibienfahrzeug (wasserfahrzeug landfahrzeug))
(defclass amphibienflugzeug (wasserfahrzeug straßenfahrzeug luftfahrzeug))
(defclass zweiwegefahrzeug (schienenfahrzeug straßenfahrzeug))
(defclass zeitzug (schienenfahrzeug luftfahrzeug))

; 2.2

; 2.3