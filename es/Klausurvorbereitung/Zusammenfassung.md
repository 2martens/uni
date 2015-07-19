# Einführung

## Anwendungsgebiete

* ES werden in unterschiedlichen Bereichen verwendet:
  * Autos
  * Flugzeuge
  * Züge
  * Mobiltelefone
  * Gesundheitssektor
  * Sicherheit
  * TVs
  * Fabriken
  * Intelligente Gebäude
  * Logistik (RFID) - Tracking von Objekten
  * Robotik

## Wichtige Eigenschaften
* dependable
  * Reliability - Probability that system will not fail
  * Maintainability - Probability that failing system can be repaired within certain timeframe
  * Availability - Probability that system is available
  * Safety - System will not cause any harm
  * Security - confidential data remains confidential and authentic communication is guaranteed
* efficient
  * Energie
  * Laufzeiteffizienz
  * Codegröße
  * Gewicht/Masse der Hardware
  * Kosten

ES müssen oftmals Echtzeitbedingungen umsetzen.
Zwei Arten:
* harte Bedingungen - Nicht-Einhalten führt zu Katastrophe
* weiche Bedingungen - alle anderen Zeitbedingungen

weitere Eigenschaften
* reaktiv
* hybrid - analoge und digitale Bestandteile
* DUI - dedicated user interface

## Herausforderungen im Design von ES
* Software muss auf Hardware abgestimmt werden
* ¬funktionale Bedingungen müssen eingehalten werden
  * Echtzeitbedingungen
  * Energieeffizienz
  * Dependability - Verlässlichkeit
* Zeitmanagement ist eine der größten Herausforderungen
* Concurrency (Nebenläufigkeit) ist essentiell
* Kombinieren von Komponenten ist wichtig für Design
* traditionelle sequentielle Prog.Sprachen sind nicht ideal

## Designflow

* rounded boxes - stored info
* rectangles - transformations on data
* application knowledge
-> specification
-> HW components
-> system software
=> design repository -> design -> [test]
|				  |
[application mapping]
* [optimization]
* [evaluation & validation]
* [test]

* Figure 1.6 page 13

# Spezifikationen und Modellierung

## Bedingungen

* Model: Simplification of another entity, which can be a 
physical thing or another model. The model contains exactly those 
characteristics and properties of the modeled entity that are 
relevant for a given task. A model is minimal with respect to a 
task if it does not contain any other characteristics than those 
relevant for the task.

Modelle werden in Sprachen beschrieben. Sprachen sollten
folgende Eigenschaften aufweisen (Wunschliste):

* Hierarchie
  * Verhaltshierarchien - enthalten für Beschreibung des Systemverhaltens notwendige Objekte, z.B. Zustände, Events
  * Strukturhierarchien - beschreiben physische Komponenten des Systems
* Komponenten-basiertes Design - Verhalten des Systems muss von Verhalten der Komponenten ableitbar sein
* Nebenläufigkeit
* Synchronisation und Kommunikation
* Zeitverhalten (timing behavior)
  * elapsed time (vergangene Zeit) seit X
  * Verzögern von Prozessen für spezifizierte Zeit
  * being able to specify timeouts
  * Fähigkeit Deadlines und Schedules zu spezifizieren
* Zustandorientiertes Verhalten
* Eventhandling
* Ausnahmeorientiertes Verhalten
* Vorhandensein von Programmierelementen
* Ausführbarkeit
* Support für Design großer Systeme
* Support für Anwendungsdomain
* Lesbarkeit
* Portabilität und Flexibilität
* Termination - feasible to identify processes which will terminate from the specification
* Support für ¬Standard I/O-Devices
* ¬funktionale Eigenschaften
* Support für Design von verlässlichen (dependable) Systemen
* keine Hindernisse für Generierung effizienter Implementierungen
* angemessenes MoC (Model of Computation)

## Models of computation (Berechnungsmodelle)

* MoCs definieren:
  * Komponenten
  * Kommunikationsprotokolle

Beziehungen zwischen diesen Punkten können in Graphen 
festgehalten werden.

Models of Communication:
* shared memory
* message passing
  * async message passing - non-blocking communication
  * sync message passing - blocking communication, rendez-vous based communication
  * extended rendez-vous, remote invocation

Organisation von Berechnungen innerhalb der Komponenten
* Von-Neumann Modell
* discrete event model
* endliche Automaten
* Differentialgleichungen

Kombinierte Modelle: Tatsächliche Sprachen kombinieren normalerweise ein Kommunikationsmodell mit einer Organisation von Berechnungen innerhalb der Komponenten.

Beispiele:
* StateChart - kombiniert endliche Automaten mit shared memory
* SDL - kombiniert asynchrones message passing mit endlichen Automaten
* ADA, CSP - kombinieren von-Neumann mit synchronem message passing

Figure 2.7 page 34

## Diskrete Event-basierte Sprachen

### VHDL
* kann in die 1980er Jahre zurückverfolgt werden
* im VHSIC Programm entwickelt (vom DoD)
* VHSIC hardware description language
* IEEE standard

Elemente:
* Entitäten
* Architekturen

definieren von Verhalten und Struktur

### SystemC

* erlaubt Spezifikation von Hardwarestrukturen in Software

# Hardware

## Input

Sensoren:
* Beschleunigungssensoren
* Regensensoren
* Bildsensoren (charge-coupled devices und CMOS)
* biometrische Sensoren
* künstliche Augen
* RFID
* andere Sensoren

Sensoren erzeugen Signale.

Diskretisierung von Zeit: Sample-and-hold circuits
* messen eines Wertes aus dem kontinuierlichen Zeitspektrum
* gemessener Wert wird für bestimmte Zeitdauer weitergeleitet
* danach zurück zur Messung des Wertes
* Output gleicht damit diskreten Werten (gleicher Wert für bestimmte Zeitdauer)

Diskretisierung von Werten: A/D Konverter
* Flash A/D converter
  * large number of comparators
  * each comparator has two inputs (+ and -)
  * if voltage at + larger than at - -> logical 1, otherwise logical 0
  * first comparator returns 1, if h(t) exceeds 3/4 Vref
  * second returns 1, for h(t) > 2/4 Vref
  * third returns 1, for h(t) > 1/4 Vref
  * encoder tries to identify most significant '1'
* successive appriximation

## Processing Units

* Energie"verbrauch" ist wichtigste Beschränkung in ES

### ASICs (Application-specific circuits)
* hohe Kosten
* sehr gute Performance für sehr kleinen Anwendungsbereich
* keine Flexibilität

### Prozessoren
* Flexibilität
* Energieeffizienz ist wichtig - Compiler müssen so effizient sein wie möglich
* müssen nicht kompatibel mit PC-Prozessoren sein
* Dynamic power management
  * power saving states (idle and sleep)
  * changes between states
* Dynamic voltage scaling
  * decreasing supply voltage reduces power quadratically
  * only linear increase of runtime of algorithms
* Code-size efficiency
  * CISC machines (Complex Instruction Set Processors)
  * Kompressionstechniken
* Laufzeiteffizienz

### Reconfigurable Logic
application areas:
* fast prototyping
* low volume applications
* realtime systems

### Memories
* großer Geschwindigkeitsunterschied zw. Prozessoren und Memories
* kleinere Memories wichtig, da sie schnellere Zugriffszeiten bieten
* mehrere kleine Speicher für häufig genutzte Instruktionen und Daten plus ein größerer Speicher für restliche Daten und Instruktionen bieten i.A. höhere Energieeffizienz
* Scratch Pad memories (SPMs) als Alternative zu Caches

## Communication
* Informationen können durch Kanäle transportiert werden
* physische Entitäten, die Kommunikation ermöglichen heißen Kommunikationsmedien
* wichtige solche Medien:
  * drahtlose Medien (Infrarot, RFID)
  * optische Medien (Glasfaser)
  * Kabel

### Requirements
* Echtzeitverhalten
* Effizienz
* angemessende Bandbreite und Kommunikationsverzögerung
* Support für eventbasierte Kommunikation
* Robustheit
* Fehlertoleranz
* Wartbarkeit, Diagnosefähigkeit
* Datenschutz

### Elektrische Robustheit

* single-ended signaling
  * single ground wire
  * affected by external noise
  * difficult to establish high-quality ground signals
* differential signaling
  * two wires for data transport
  * noise can be effectively removed
  * logic value only depends on polarity of voltage between two wires, magnitude can be affected without effect
  * quality of ground wire unimportant
  * no common ground wire required
  * larger throughput than single-ended signaling
  * used in standard Ethernet-based networks

### Echtzeitverhalten garantieren

* Nutzung von time division multiple access (TDMA)
* jeder Kommunikationspartner bekommt festen Zeitslot
* innerhalb dieses Slots darf gesendet werden
* Zeit wird in Frames unterteilt
* jedes Frame startet mit Synchronisierung und einem Gap, um dem Sender das ausschalten zu ermöglichen 

carrier-sense multiple access/collision detect (CSMA/CD)
* wenn mehrere Partner zur gleichen Zeit kommunizieren, wird für jeden eine zufällige Wartezeit bestimmt
* sehr unwahrscheinlich, dass sich Szenario nach Wartezeit wiederholt
* kann nicht für ES benutzt werden, da Laufzeit nicht bestimmt werden kann

carrier-sense multiple access/collision avoidance (CSMA/CA)
* jeder Partner bekommt Priorität zugewiesen
* dies geschieht in Verhandlungsphasen
* wenn Partner einen Partner mit höherer Priorität erkennt, muss Ersterer seine NUtzungsabsicht sofort zurückziehen
* daher vorhersehbare Laufzeit für Partner mit höchster Priorität
* für andere auch, wenn Partner mit höchster Prio nicht dauerhaft Zugang verlangt
* Ethernet mit über 1GBit vermeidet ebenfalls Kollisionen

### Beispiele

* Sensor/actuator buses
* field buses
  * Controler Area Network
  * Time-Triggered-Protocol (TTP)
  * FlexRay
  * LIN
  * MAP
  * EIB
* Kabelgebundene Multimedia-Kommunikation
* drahtlose Kommunikation

## Output

* Displays
* Elektromechanische Geräte

* analog input zu analog output:
AA -> Sample & hold -> A/D conv. -> Verarbeitung -> D/A conv. -> filter

### D/A Konverter

* wandeln digital in analog um
* benutzen Kirchhoffs Regeln

### Sampling theorem

* mithilfe der Shannon-Wittaker interpolation kann das ursprüngliche analoge Signal approximiert werden
* ebenso wird die Fourier Transformation benutzt
* ansonsten sehr viel Mathe

# System Software

## Embedded Operating Systems

### Allgemeine Bedingungen

* muss flexibel für Anwendungsbereich angepasst werden können
* Konfigurabilität (configurability)
  * OO
  * Aspect-oriented Programming
  * konditioniertes Kompilieren
  * fortgeschrittene Kompilierzeit Evaluation
  * Linker-basiertes Entfernen von nicht genutzten Funktionen
* Treiber sind vom OS getrennt
* keine Schutzmechanismen (wie privilegierter Zugang) notwendig, da ungetestete Software nicht geladen wird
* interrupts können mit jedem Prozess verbunden werden
* viele ES sind Echtzeitsysteme und daher muss deren OS ein RTOS sein

### Echtzeit OS

* Zeitverhalten des OS muss vorhersagbar sein
* OS muss das Scheduling der Tasks managen
* einige Systeme erfordern Zeitmanagement durch das OS
* OS muss schnell sein

vorhandene RTOS können in drei Kategorien eingeteilt werden:
* schnelle proprietäre Kernel
* Echtzeiterweiterungen zu Standard-OS
* Forschungssysteme

Kernunterschied zu Standard OS:
* es wird für den Worst Case optimiert

### Resources access protocols

#### Priority Inversion

* Prozess mit geringerer Priorität blockt Prozess mit höherer Priorität

#### Priority Inheritance
* T1 hat Prio 1
* T2 hat Prio 2
* T3 hat Prio 3

* T2 verlangt Zugang zu S
* T1 verlangt Zugang zu S - wird blockiert
* T2 erbt Prio von T1

## Hardware abstraction layers

* accessing hardware through hardware-independent API

## Middleware

* add communication functionality on top of OS

### OSEK

* für Autobranche benutzt

### Corba (Common Object Request Broker Architecture)

* standardisierter Zugriff auf Remote-Objekte
* standardmäßig nicht für RTOS geeignet
* separater Standard RT-CORBA für RTOS definiert

### MPI (Message passing interface)

* Alternative zu CORBA
* Kommunikation zwischen Prozessoren

### POSIX Threads (Pthreads)

* API für Threads auf der OS-Ebene

### OpenMP

* explizite Parallelität
* implizite Kommunikation, Synchronisation, etc.

### UPnP, DPWS, JXTA

* Universal Plug-and-Play
  * Erweiterung von PnP für Netzwerke
* Devices Profile for Web Services (DPWS) allgemeiner als UPnP
* JXTA ist eine OpenSource Peer-to-Peer Protokollspezifikation

# Evaluation und Validierung

* Validierung überprüft, ob ein Design alle Restriktionen erfüllt, wie erwartet funktionieren wird und für den Zweck angemessen ist
* Validierung mit mathematischer Genauigkeit wird formale Validierung genannt
* sehr wichtig während Designprozess
* Evaluation ist Prozess des Berechnens von quantitativen Informationen von einigen Kern-Charakteristika eines bestimmten Designs

Kopetz' Designprinzipien:
* Safety muss möglicherweise als der zentrale Aspekt gesehen werden, von dem alles abhängt
* präzise Spezifikationen von Designhypothesen müssen gleich zu Beginn gemacht werden (inklusive erwarteten Fehlern und deren Wahrscheinlichkeit)
* "Fault containment regions" müssen erwogen werden
  * Fehler in einer solchen Region beeinflussen keine andere solche Region
* konsistente Vorstellung von Zeit und Zustand muss etabliert werden
* wohldefinierte Schnittstellen müssen die Interna von Komponenten verstecken
* Komponenten müssen unabhängig voneinander versagen (kein Einfluss auf andere Komponenten)
* Komponenten müssen sich selbst als korrekt annehmen bis mindestens zwei andere Komponenten das Gegenteil annehmen
* Fehlertoleranz darf es nicht schwerer machen das Verhalten des Systems zu erklären; Fehlertoleranz Mechanismen sollten von der regulären Funktionalität entkoppelt sein
* das System muss für Diagnose designed werden
* man-machine interface muss intuitiv und vergebend sein; safety sollte trotz Fehler des Menschens weiter gewährleistet sein
* jede Anomalie sollte aufgezeichnet werden; Aufzeichnung sollte auch interne Effekte beinhalten
* provide never-give up strategy

# Application mapping

## Classification of scheduling algorithms

* soft and hard deadlines
* periodic vs. aperiodic tasks
* preemptive vs. non-preemptive scheduling
* static vs. dynamic scheduling
* independent vs. dependent tasks
* mono- vs. multi-processor scheduling
* centralized vs. distributed scheduling

## Scheduling algorithms

### Aperiodic scheduling without precedence constraints
* Earliest Due Date (identical arrival times)
* Earliest Deadline First (different arrival times with preemption)
* Least Laxity (deadline interval - execution time)

### Aperiodic Scheduling with precedence constraints
* LatestDeadlineFirst
* ASAP
* ALAP (as late as possible)
* list scheduling
* force-directed scheduling
  * goal: balanced utilization of resources
  * based on spring model
  * originally proposed for high-level synthesis

### Periodic scheduling without precedence constraints

* rate monotonic scheduling
* Earliest deadline first


