---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

## Lokale Variablen
Lokale Variablen werden im Locals-Block eingerichtet und bilden eine Sammlung von Schlüssel-Wert-Zuordnungen, die innerhalb der Konfiguration anwendbar sind. Diese Werte können entweder explizit definiert oder mit anderen Variablen oder Ressourcen verknüpft werden.
Lokale Variablen sind ausschließlich innerhalb des Moduls oder der Konfiguration ihrer Deklaration zugänglich und erleichtern die Organisation und Wiederverwendbarkeit. Betrachten wir zur Veranschaulichung die Erstellung einer EC2-Instanzkonfiguration unter Verwendung lokaler Variablen. Dieser Konfigurationsausschnitt kann einer Datei namens main.tf hinzugefügt werden.

## Eingabevariablen
Die Eingabevariablen von Terraform erleichtern die Bereitstellung externer Werte in Konfigurationen oder Modulen und ermöglichen so eine dynamische Zuweisung zu Ressourcenattributen.
Im Gegensatz zu lokalen Variablen ermöglichen Eingabevariablen die Übergabe von Werten vor der Ausführung.

## Umgebungsvariablen
Darüber hinaus können Eingabevariablenwerte auch mithilfe von Terraform spezifischen Umgebungsvariablen festgelegt werden. Legen Sie dazu einfach die Umgebungsvariable z.B. im Format **TF_VAR_ami=ami-0d26eb3972b7f8c96** fest.

## Ausgabevariablen
In Szenarien, in denen eine umfangreiche Webanwendungsinfrastruktur über Terraform bereitgestellt wird, besteht häufig der Bedarf an bestimmten Endpunkten, IP-Adressen, Datenbankbenutzeranmeldeinformationen und ähnlichen Daten. 
Diese Informationen sind neben anderen potenziellen Anwendungsfällen von großem Wert für die Übermittlung dieser Werte an Module.

## Einschränkungen !
> Es ist wichtig zu beachten, dass Terraform die Verwendung von Variablen in der Provider Konfiguration nicht zulässt.
