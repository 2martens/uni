#lang swindle

(require swindle/setf
         swindle/misc)

; CLOS

(defclass* messgeraet ())
(defgeneric* einheit ((messgeraet))
  :combination generic-append-combination)
(defgeneric* messwert ((messgeraet))
  :combination generic-append-combination)
(defgeneric* genauigkeit ((messgeraet))
  :combination generic-min-combination)

(defclass* thermometer (messgeraet))
(defclass* barometer (messgeraet))
(defclass* regenmesser (messgeraet))

(defclass* wetterstation (thermometer barometer regenmesser))

; Logik

(?- (kamera ?kamID ? ? 24 ?))
(?- (kamera ?kamID ? ? 18 ?)
    (angebot ?kamID ? ?preis))
(?- (anbieter ?anbID ?anbName ?lieferzeit ? ?)
    (test (<= ?lieferzeit 1))
    (angebot ?kamID ?anbID ?)
    (kamera ?kamID ?kameraname ?hersteller ? ?))
    
