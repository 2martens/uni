# Einführung

## Anwendungsgebiete

* ES werden in unterschiedlichen Bereichen verwendet:
** Autos
** Flugzeuge
** Züge
** Mobiltelefone
** Gesundheitssektor
** Sicherheit
** TVs
** Fabriken
** Intelligente Gebäude
** Logistik (RFID) - Tracking von Objekten
** Robotik

## Wichtige Eigenschaften
* dependable
** Reliability - Probability that system will not fail
** Maintainability - Probability that failing system can be repaired within certain timeframe
** Availability - Probability that system is available
** Safety - System will not cause any harm
** Security - confidential data remains confidential and authentic communication is guaranteed
* efficient
** Energie
** Laufzeiteffizienz
** Codegröße
** Gewicht/Masse der Hardware
** Kosten

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
** Echtzeitbedingungen
** Energieeffizienz
** Dependability - Verlässlichkeit
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
** Verhaltshierarchien - enthalten für Beschreibung des Systemverhaltens notwendige Objekte, z.B. Zustände, Events
** Strukturhierarchien - beschreiben physische Komponenten des Systems
* Komponenten-basiertes Design - Verhalten des Systems muss von Verhalten der Komponenten ableitbar sein
* Nebenläufigkeit
* Synchronisation und Kommunikation
* Zeitverhalten (timing behavior)
** elapsed time (vergangene Zeit) seit X
** Verzögern von Prozessen für spezifizierte Zeit
** being able to specify timeouts
** Fähigkeit Deadlines und Schedules zu spezifizieren
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
** Komponenten
** Kommunikationsprotokolle

Beziehungen zwischen diesen Punkten können in Graphen 
festgehalten werden.

Models of Communication:
* shared memory
* message passing
** async message passing - non-blocking communication
** sync message passing - blocking communication, rendez-vous based communication
** extended rendez-vous, remote invocation

Organisation von Berechnungen innerhalb der Komponenten
* Von-Neumann Modell
* discrete event model
* endliche Automaten
* Differentialgleichungen

Kombinierte Modelle: Tatsächliche Sprachen kombinieren normalerweise ein Kommunikationsmodell mit einer Organisation von Berechnungen innerhalb der Komponenten.

Beispiele:
* StateChart - kombiniert endliche Automaten mit shared memory
* SDL - kombiniert asynchrones message passing with endlichen Automaten
* ADA, CSP - kombinieren von-Neumann mit synchronem message passing

Figure 2.7 page 34

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
** large number of comparators
** each comparator has two inputs (+ and -)
** if voltage at + larger than at - -> logical 1, otherwise logical 0

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
** power saving states (idle and sleep)
** changes between states
* Dynamic voltage scaling
** reduced voltage means significantly less power consumption
** only linear increase of runtime of algorithms
* Code-size efficiency
** CISC machines (Complex Instruction Set Processors)
** Kompressionstechniken
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
** drahtlose Medien (Infrarot, RFID)
** optische Medien (Glasfaser)
** Kabel

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

