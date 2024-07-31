---
layout: home
title: Schlüßelkonzepte
subtitle: Was sind Module und wofür brauche ich diese?
---

Das Ressourcenmodul ist eine Sammlung verbundener Ressourcen, die zusammen eine gemeinsame Aktion ausführen \(z. B. [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) erstellt VPC,
Subnetze, NAT-Gateway usw.\). Dies hängt von der Provider-Konfiguration ab, die darin definiert werden kann, oder in übergeordneten Strukturen \(z.B. im Infrastrukturmodul\).


Module in Terraform sind im Grunde Container für mehrere Ressourcen, die als Einheit verwendet werden. Durch die Verwendung von Modulen können Sie Code wiederverwenden, Ihre Terraform-Konfigurationen organisieren und Best Practices fördern.

## Warum sind Module in Terraform nützlich?

    Wiederverwendbarkeit: Anstatt denselben Code immer wieder zu schreiben, können Sie einen Satz von Terraform-Ressourcen in einem Modul definieren und dann dieses Modul in verschiedenen Umgebungen oder Projekten verwenden.

    Organisation: Module helfen Ihnen, Ihren Code in logische Einheiten zu zerlegen. Dies erleichtert das Verständnis, die Verwaltung und die Änderung Ihres Terraform-Codes.

    Einfachheit: Ein gut gestaltetes Modul verbirgt die Komplexität. Anstelle von Dutzenden von Ressourcen und Hunderten von Zeilen Code müssen Sie nur das Modul und die für Ihr spezielles Szenario relevanten Argumente definieren.

    Konsistenz: Wenn Sie Module über verschiedene Projekte hinweg verwenden, können Sie sicherstellen, dass alle Ihre Infrastrukturen auf die gleiche Weise eingerichtet sind, wodurch Fehler vermieden und die Wartung erleichtert wird.

### Beispiel:

Betrachten Sie das Erstellen einer VPC in AWS. Dies erfordert nicht nur die VPC selbst, sondern auch Subnetze, Route Tables, Sicherheitsgruppen, NAT-Gateways und vieles mehr. Anstatt jede dieser Ressourcen manuell in Ihrer Hauptkonfiguration zu definieren, können Sie ein VPC-Modul erstellen oder verwenden, das all diese Ressourcen für Sie erstellt. Wenn Sie eine VPC erstellen möchten, rufen Sie einfach dieses Modul mit den gewünschten Argumenten auf.

Wie funktionieren Module?

Module sind wie normale Terraform-Konfigurationen. Sie bestehen aus einer Sammlung von .tf-Dateien in einem Verzeichnis. Um ein Modul zu verwenden, müssen Sie es in Ihrer Haupt-Terraform-Konfiguration mit dem module-Keyword aufrufen und die Quelle des Moduls (d.h. den Pfad zu den .tf-Dateien) sowie alle erforderlichen Eingabevariablen angeben.

## Fazit:

Module sind ein zentrales Konzept in Terraform und ermöglichen es Ihnen, effizientere, konsistentere und wartbarere Infrastrukturen zu erstellen. Wenn Sie Terraform in einem größeren Umfang oder über mehrere Projekte hinweg verwenden, sind Module fast unverzichtbar, um den Überblick zu behalten und Redundanzen zu vermeiden.

