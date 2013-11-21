#lang racket

#|
SE 3 Funktional Blatt 4
Abgebende: Jim 2martens, Britta 2noack, Jan-Simon 0giesel
|#

; 1)
; 1. (max (min 2 (- 2 5)) 0) -> 0
; zunächst wird (- 2 5) ausgeführt, was -3 ergibt
; als nächstes wird (min 2 -3) ausgeführt, was -3 ergibt
; dann kommt (max -3 0) mit dem Ergebnis 0
; 2. (+ (- 2 13) 2) -> -9
; zunächst wird (- 2 13) mit dem Ergebnis -11 ausgeführt
; anschließend wird (+ -11 2) ausgeführt mit dem Ergebnis -9
; 3. (cadr '(Alle Jahre wieder)) -> 'Jahre
; zunächst wird (cdr '(Alle Jahre wieder)) ausgeführt mit dem Ergebnis '(Jahre wieder)
; anschließend wird (car '(Jahre wieder)) mit dem Ergebnis 'Jahre ausgeführt
; 4. (cddr '(kommt (das Weihnachtfest))) -> '()
; zunächst wird (cdr '(kommt (das Weihnachtfest))) ausgeführt mit dem Ergebnis '((das Weihnachtfest))
; anschließend wird (cdr '((das Weihnachtfest))) ausgeführt mit dem Ergebnis '()
; dies liegt an der doppelt geschachtelten Liste:
; (cons 'kommt (list (list 'das 'Weihnachtfest))) -> '(kommt (das Weihnachtfest))
; 5. (cons 'Listen '(ganz einfach und)) -> '(Listen ganz einfach und)
; da '(ganz einfach und) eine Liste ist, verkettet cons 'Listen schlichtweg mit der Liste
; 6. (cons 'Paare 'auch) -> '(Paare . auch)
; hier verkettet cons zwei einfache Elemente, wodurch ein Paar entsteht, welches keine Liste ist
; 7. (equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java)) -> #t
; list erzeugt eine Liste mit den angegebenen Elementen und '(Racket Prolog Java) ist ebenfalls eine Liste mit den gleichen Elementen
; 8. (eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java))) -> #t
; list erzeugt wieder eine Liste und cons verknüpft hier ein einfaches Element mit einer Liste, wodurch wieder eine Liste entsteht

; 2)
; 1.
; <notmeldung>    ::= <ueberschrift><notfallort><notfallart><hilfeleistung><peilzeichen><unterschrift><over>
; <ueberschrift>  ::= <hierist><line-end><schiffname3mal><rufzeichen><line-end><summary><line-end>
; <summary>       ::= "MAYDAY "<schiffname>" ICH BUCHSTABIERE "<snamechars>" "<rufzeichen>
; <snamechars>    ::= <string>
; <schiffname3mal>::= <schiffname>" "<schiffname>" "<schiffname>
; <schiffname>    ::= <word>
; <notfallort>    ::= <standort><zeitpunkt>
; <notfallart>    ::= <string><line-end>
; <hilfeleistung> ::= <string><line-end><lines>
; <peilzeichen>   ::= "ICH SENDE DEN TRÄGER --"<line-end>
; <unterschrift>  ::= <word>" "<rufzeichen><line-end>
; <rufzeichen>    ::= <word>" "<word>" "<word>" "<word>
; <lines>         ::= <string><line-end> | <string><line-end><lines>
; <standort>      ::= "NOTALLPOSITION "<string><line-end>
; <zeitpunkt>     ::= "NOTFALLZEIT "<time>" UTC"<line-end>
; <time>          ::= <hour><minute>
; <hour>          ::= "0"<digit> | "1"<digit> | "2"<hdigit>
; <minute>        ::= "0"<digit> | "1"<digit> | "2"<digit> | "3"<digit> | "4"<digit> | "5"<digit>
; <digit>         ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
; <hdigit>        ::= "0" | "1" | "2" | "3"
; <string>        ::= <word> | <word>" "<string>
; <word>          ::= <letter> | <letter><word>
; <line-end>      ::= <EOL> 
; <over>          ::= "OVER"

; 2.2
(define buchstabiertafel
  '((#\A . ALFA)
    (#\B . BRAVO)
    (#\C . CHARLIE)
    (#\D . DELTA)
    (#\E . ECHO)
    (#\F . FOXTROTT)
    (#\G . GOLF)
    (#\H . HOTEL)
    (#\I . INDIA)
    (#\J . JULIETT)
    (#\K . KILO)
    (#\L . LIMA)
    (#\M . MIKE)
    (#\N . NOVEMBER)
    (#\O . OSCAR)
    (#\P . PAPA)
    (#\Q . QUEBEC)
    (#\R . ROMEO)
    (#\S . SIERRA)
    (#\T . TANGO)
    (#\U . UNIFORM)
    (#\V . VIKTOR)
    (#\W . WHISKEY)
    (#\X . X-RAY)
    (#\Y . YANKEE)
    (#\Z . ZULU)
    (#\0 . NADAZERO)
    (#\1 . UNAONE)
    (#\2 . BISSOTWO)
    (#\3 . TERRATHREE)
    (#\4 . KARTEFOUR)
    (#\5 . PANTAFIVE)
    (#\6 . SOSISIX)
    (#\7 . SETTESEVEN)
    (#\8 . OKTOEIGHT)
    (#\9 . NOVENINE)
    (#\, . DECIMAL)
    (#\. . STOP)
    ))

(define (char->schlüssel char tafel)
  (cdr (assoc (char->upper char) tafel)))

(define (char->upper char)
  (let ([charInt (char->integer char)])
    (cond ([<= 96 charInt 122] (integer->char (- charInt 32)))
          ([<= 65 charInt 90] (integer->char charInt))
          (else char))))

(define (liste->string liste)
  (letrec ((rec (λ (string xs)
                  (if (null? xs)
                      string
                      (if (empty? string)
                          (rec (symbol->string (car xs)) (cdr xs))
                          (rec (string-append string " " (symbol->string (car xs))) (cdr xs)))))))
                          
    (rec "" liste)))

(define (buchstabiere text tafel)
  (letrec ((rec (λ (xs)
                  (if (null? xs)
                      null
                      (cons (char->schlüssel (car xs) tafel)
                            (rec (cdr xs)))))))
    (liste->string (rec (string->list text)))))



(define mayday "MAYDAY")
(define notposition "NOTFALLPOSITION")
(define notzeit "NOTFALLZEIT")
(define space " ")
(define linebreak "\n")
(define hierist "HIER IST")
(define buchstabieren "ICH BUCHSTABIERE")
(define ruf "RUFZEICHEN")
(define senden "ICH SENDE DEN TRÄGER --")

(define (generiereNotmeldung schiffname rufzeichen position weitereAngaben)
  (display (string-append mayday space mayday space mayday linebreak 
                          hierist linebreak 
                          schiffname space schiffname space schiffname (buchstabiere rufzeichen buchstabiertafel) linebreak 
                          mayday space schiffname space buchstabieren (buchstabiere schiffname buchstabiertafel) (buchstabiere rufzeichen buchstabiertafel) linebreak 
                          ruf (buchstabiere rufzeichen buchstabiertafel) linebreak
                          notposition space position linebreak
                          weitereAngaben
                          senden linebreak
                          schiffname (buchstabiere rufzeichen buchstabiertafel) linebreak
                          "OVER")))
; 2.3
(display "BABETTE:\n") 
(generiereNotmeldung "BABETTE" "DEJY" "UNGEFÄHR 10 SM NORDÖSTLICH LEUCHTTURM KIEL" "SCHWERER WASSEREINBRUCH WIR SINKEN\nKEINE VERLETZTEN\nVIER MANN GEHEN IN DIE RETTUNGSINSEL\nSCHNELLE HILFE ERFORDERLICH\n")
(display "\n\nAMIRA:\n")
(generiereNotmeldung "AMIRA" "AMRY" "57°46'N, 006°31'E\nNOTFALLZEIT 0640 UTC" "KENTERUNG WIR SINKEN\n9 MANN AN BORD\nSCHIFF 15 M LANG\nGRÜNER RUMPF\n")

; 3)
