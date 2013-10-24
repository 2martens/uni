% VSIS-Aufgabenblatt
%
% LaTeX-Klasse zur Erstellung von Aufgabenblaettern inkl. optionaler Musterloesung im VSIS-Stil.
%
% Entworfen von Kristof Hamann auf Grundlage eines existierenden Designs aus aelteren Semestern.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vsis-aufgabenblatt}[2009/11/08 v1.0 VSIS-Aufgabenblaetter]

\LoadClass[a4paper,parskip=half-,numbers=noenddot]{scrartcl}

% Kodierung der Schriftarten wegen Umlauten
\RequirePackage[T1]{fontenc}

% Silbentrennung
\RequirePackage[ngerman]{babel}

% Einbinden von Grafiken (z.B. VSIS-Logo)
\RequirePackage{graphicx}
% Definieren von Farben
\RequirePackage{xcolor}	
\definecolor{shadecolor}{gray}{0.9}
% Rahmen (z.B. fuer Musterloesungen)
\RequirePackage{framed}
% Erweiterte Tabellen (z.B. fuer Kopfzile)
\RequirePackage{tabularx}
% Tabellenzellen ueber mehrere Zeilen (z.B. fuer Kopfzeile)
\RequirePackage{multirow}

\renewcommand{\familydefault}{\sfdefault} 
\RequirePackage{sfmath}

\RequirePackage{uri}

% Seitenlayout
\RequirePackage{scrpage2}
\setlength{\headsep}{3.5cm}
\setlength{\oddsidemargin}{-1cm}
\setlength{\textwidth}{18cm}
\setkomafont{pageheadfoot}{\small}


% Section = Aufgabe
% \othersectionlevelsformat{Gliederungsname}{}{Zaehlerausgabe}
%\renewcommand*{\othersectionlevelsformat}[3]{\AufgabeTitel~#3:\enskip}
% Aufzaehlungen fuer Teilaufgaben
%\renewcommand{\labelenumi}{\alph{enumi})}
%\renewcommand{\labelenumii}{\roman{enumii})}



% Optionales Einblenden von Musterloesungen, Layout von Musterloesungen
\newif\ifmusterloesung
\musterloesungfalse
\newcommand{\aufgabe}[2]{\section{#1\hfill\normalfont(#2)}}
\newenvironment{musterloesung}{\begin{shaded}\textbf{\MusterloesungTitel:}\\[0.5em]}{\end{shaded}}


% Kopfzeile mit VSIS-Logo und Vorlesungsdaten
\pagestyle{scrheadings}
\chead{
\begin{tabularx}{\textwidth}{|p{2.2cm}|X|X|X|X|}
\cline{1-5}
& & \multicolumn{3}{l|}{}\\[-0.95em]
\multirow{4}{*}{\includegraphics[width=2.2cm]{vsis.pdf}} & \VorlesungTitel & \multicolumn{3}{l|}{\textbf{\Vorlesung}\hfill\Semester} \\
& & \multicolumn{3}{l|}{}\\[-0.95em]
\cline{2-5}
& & \multicolumn{3}{l|}{}\\[-0.95em]
& \AufgabenblattTitel & \multicolumn{3}{l|}{\bfseries\Aufgabenblatt{} \ifmusterloesung(\MusterloesungTitelblatt)\fi} \\
& & \multicolumn{3}{l|}{}\\[-0.95em]
\cline{2-5}
& & \multicolumn{3}{l|}{}\\[-0.95em]
& \PunktezahlTitel & \multicolumn{3}{l|}{\bfseries\Punktezahl} \\
& & \multicolumn{3}{l|}{}\\[-0.95em]
\cline{2-5}
& & & &\\[-0.95em]
& \AusgabedatumTitel & \bfseries\Ausgabedatum  & \AbgabedatumTitel & \bfseries\Abgabedatum \\[0.25em]
\cline{1-5}
\end{tabularx}
}



% GDB-Makros laden
\RequirePackage{vsis-gdb}

% Variablen fuer Seitenkopf: Setzen mit \renewcommand{\Variable}{Wert}
\newcommand{\Vorlesung}{}
\newcommand{\Semester}{}
\newcommand{\Ausgabedatum}{}
\newcommand{\Abgabedatum}{}
\newcommand{\Aufgabenblatt}{}
\newcommand{\Punktezahl}{}
\newcommand{\MusterloesungTitel}{L\"osungsvorschlag}
\newcommand{\MusterloesungTitelblatt}{L\"osungsvorschl\"age}
\newcommand{\VorlesungTitel}{Lehrveranstaltung}
\newcommand{\AufgabenblattTitel}{Aufgabenzettel}
\newcommand{\PunktezahlTitel}{Gesamtpunktzahl}
\newcommand{\AusgabedatumTitel}{Ausgabe}
\newcommand{\AbgabedatumTitel}{Abgabe}
\newcommand{\AufgabeTitel}{Aufgabe}
