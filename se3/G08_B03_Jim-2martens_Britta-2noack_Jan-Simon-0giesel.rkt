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
(define (daten char)
  (case (char->integer char)
    ([65] (list char 'Alfa))
    ([66] (list char 'Bravo))
    ([67] (list char 'Charlie))
    ([68] (list char 'Delta))
    ([69] (list char 'Echo))
    ([70] (list char 'Foxtrott))
    ([71] (list char 'Golf))
    ([72] (list char 'Hotel))
    ([73] (list char 'India))
    ([74] (list char 'Juliett))
    ([75] (list char 'Kilo))
    ([76] (list char 'Lima))
    ([77] (list char 'Mike))
    ([78] (list char 'November))
    ([79] (list char 'Oscar))
    ([80] (list char 'Papa))
    ([81] (list char 'Quebec))
    ([82] (list char 'Romeo))
    ([83] (list char 'Sierra))
    ([84] (list char 'Tango))
    ([85] (list char 'Uniform))
    ([86] (list char 'Viktor))
    ([87] (list char 'Whiskey))
    ([88] (list char 'X-ray))
    ([89] (list char 'Yankee))
    ([90] (list char 'Zulu))
    ([48] (list char 'Nadazero))
    ([49] (list char 'Unaone))
    ([50] (list char 'Bissotwo))
    ([51] (list char 'Terrathree))
    ([52] (list char 'Kartefour))
    ([53] (list char 'Pantafive))
    ([54] (list char 'Sosisix))
    ([55] (list char 'Setteseven))
    ([56] (list char 'Oktoeight))
    ([57] (list char 'Novenine))
    ([44] (list char 'Decimal))
    ([46] (list char 'Stop))
    )
  )

; 1.2
(define (char->schlüssel char)
  (car (cdr (daten char))))

; 1.3
(define char_to_upperCase (λ (myChar)
                            ; x als ASCII Wert für myChar definieren
                            (define x (char->integer myChar))
                            ; y als x-32 definieren
                            (define y (- x 32))
                            ; wenn x < 91 (bereits upperCase) myChar direkt zurückgeben
                            (if (< x 91)
                                ; wenn myChar bereits upperCase ist, direkt zurückgeben
                                myChar
                                ; andernfalls wird y zurückgegeben
                                (when (> x 96)
                                  ; y stellt den gleichen Buchstaben wie x dar, bloß in upperCase
                                  ; daher wird y zurückgegeben
                                  (integer->char y)))))

; 1.4
(define (buchstabiere text)
  (let ([xs (string->list text)])
    (if [empty? xs] 
        '()
        (cons (char->schlüssel (char_to_upperCase(car xs))) (buchstabiere (list->string (cdr xs))))
        )
    ))

(require se3-bib/flaggen-module)
; 2.1
; Analoger Entwurf wie bei 1.1, diesmal mit den Flaggen.
(define (flaggenData char)
  (case (char->integer char)
    ([65] (list char A))
    ([66] (list char B))
    ([67] (list char C))
    ([68] (list char D))
    ([69] (list char E))
    ([70] (list char F))
    ([71] (list char G))
    ([72] (list char H))
    ([73] (list char I))
    ([74] (list char J))
    ([75] (list char K))
    ([76] (list char L))
    ([77] (list char M))
    ([78] (list char N))
    ([79] (list char O))
    ([80] (list char P))
    ([81] (list char Q))
    ([82] (list char R))
    ([83] (list char S))
    ([84] (list char T))
    ([85] (list char U))
    ([86] (list char V))
    ([87] (list char W))
    ([88] (list char X))
    ([89] (list char Y))
    ([90] (list char Z))
    ([48] (list char Z0))
    ([49] (list char Z1))
    ([50] (list char Z2))
    ([51] (list char Z3))
    ([52] (list char Z4))
    ([53] (list char Z5))
    ([54] (list char Z6))
    ([55] (list char Z7))
    ([56] (list char Z8))
    ([57] (list char Z9))
    )
  )

; 2.2
(define (char->flagge char)
  (car (cdr (flaggenData char))))

; 2.3
(define (buchstabiereFlagge text)
  (let ([xs (string->list text)])
    (if [empty? xs] 
        '()
        (cons (char->flagge (char_to_upperCase(car xs))) (buchstabiereFlagge (list->string (cdr xs))))
        )
    ))