---
layout: home
title: Codestruktur
subtitle: Fragen zur Terraform-Codestruktur sind in der Community bei weitem am häufigsten. Über die beste Codestruktur hat sich wahrscheinlich auch schon jeder Gedanken gemacht.
---

# Codestruktur

Dies ist eine der Fragen, für die es viele Lösungen gibt und es sehr schwierig ist, allgemeine Ratschläge zu erteilen. Beginnen wir also damit, zu verstehen, womit wir es zu tun haben. Fragen zur Terraform-Codestruktur sind in der Community bei weitem am häufigsten. Über die beste Codestruktur hat sich wahrscheinlich auch schon jeder Gedanken gemacht.

### Wie soll ich meine Terraform-Konfigurationen strukturieren?

Dies ist eine der Fragen, für die es viele Lösungen gibt und es sehr schwierig ist, allgemeine Ratschläge zu erhalten. Beginnen wir also damit, zu verstehen, womit wir es zu tun haben.

* Wie komplex ist Ihr Projekt?
  * Anzahl zugehöriger Ressourcen
  * Anzahl der Terraform-Provider
* Wie oft ändert sich Ihre Infrastruktur?
  * **Ab** einmal im Monat/Woche/Tag
  * **An** kontinuierlich \(jedes Mal, wenn es einen neuen Commit gibt\)
* Initiatoren der Codeänderung? Lassen Sie den CI-Server das Repository aktualisieren, wenn ein neues Artefakt erstellt wird?
  * Nur Entwickler können ins Infrastruktur-Repository pushen
  * Jeder kann Änderungen vorschlagen, indem er einen PR öffnet  \(einschließlich automatisierter Aufgaben, die auf dem CI-Server ausgeführt werden\)
* Welche Bereitstellungsplattform oder Bereitstellungsdienst verwenden Sie?
  * AWS CodeDeploy, Kubernetes oder OpenShift erfordern einen etwas anderen Ansatz
* Wie werden Umgebungen gruppiert?
  * Nach Umgebung, Region, Projekt

> Logische Provider arbeiten vollständig innerhalb der Logik von Terraform und interagieren nicht mit anderen Diensten. Zu den gängigsten logischen Anbietern gehören [random](https://www.terraform.io/docs/providers/random/index.html), [template](https://www.terraform.io/docs/providers/template/%20index.html), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://www.terraform.io/docs/providers/null/%20index.html).


### Erste Schritte mit der Strukturierung von Terraform-Konfigurationen

Den gesamten Code in `main.tf` abzulegen ist eine gute Idee, wenn Sie anfangen oder einen Beispiel schreiben. In allen anderen Fällen ist es besser, mehrere Dateien logisch wie folgt aufzuteilen:

* `main.tf` - ruft verschiedene Module, Locals und Datenquellen auf, um alle Ressourcen zu erstellen
* `variables.tf` - enthält Deklarationen von Variablen, die in `main.tf` . verwendet werden
* `outputs.tf` - enthält Ausgaben der in `main.tf` erstellten Ressourcen

`terraform.tfvars` sollte nirgendwo außer in [composition](../schluessel-konzepte/#komposition) verwendet werden.

### Wie ist die Struktur von Terraform-Konfigurationen zu denken?

>Bitte stellen Sie sicher, dass Sie die wichtigsten Konzepte verstehen - [Ressourcenmodul](../schluessel-konzepte/#komposition) und [composition](../schluessel-konzepte/#komposition), wie sie in den folgenden Beispielen verwendet werden.


#### Gemeinsame Empfehlungen für die Strukturierung von Code

* Es ist einfacher und schneller, mit einer geringeren Anzahl von Ressourcen zu arbeiten.
  * "terraform plan" und "terraform apply" führen beide Cloud-API-Aufrufe durch, um den Status von Ressourcen zu überprüfen.
  * Wenn Sie Ihre gesamte Infrastruktur in einer einzigen Komposition haben, kann dies viele Minuten dauern.
* Der Umfang der Ressourcen, die durch Fehler beschädigt werden können ist mit weniger Ressourcen kleiner.
  * Das Isolieren nicht zusammenhängender Ressourcen durch die Platzierung in separaten Zusammensetzungen verringert das Risiko, wenn doch mal etwas schief geht.
* Starten Sie Ihr Projekt mit dem Remote-state
  * Ihr Laptop ist nicht der Platz, auf dem der State Ihrer Cloudumgebung liegen sollte.
  * Die Verwaltung einer tfstate-Datei in Git ist ebenso ein falscher Ansatz.
* Versuchen Sie, eine konsistente Struktur und [Nameskonvention](namenskonventionen.md) zu erstellen und zu pflegen.
  * Wie prozeduraler Code sollte Terraform-Code so geschrieben werden, dass er zuerst gelesen wird. Konsistenz wird helfen, wenn Änderungen in sechs Monaten nachvolzogen werden müssen.
* Halten Sie Ressourcenmodule so einfach wie möglich
* Werte nicht hartcodieren, die als Variablen übergeben oder mithilfe von Datenquellen eingefügt werden können.

Wir gruppieren Beispielprojekte nach der _Komplexität_ - von kleinen bis zu sehr großen Infrastrukturen. Diese Trennung ist nicht streng, also überprüfen Sie auch andere Strukturen.

#### Orchestrierung von Infrastrukturmodulen und Kompositionen

Eine kleine Infrastruktur bedeutet, dass es eine geringe Anzahl von Abhängigkeiten und wenige Ressourcen gibt. Wenn das Projekt wächst, wird die Notwendigkeit sichtbar, die Ausführung von Terraform-Konfigurationen zu verketten, verschiedene Infrastrukturmodule zu verbinden und Werte innerhalb einer Komposition zu übergeben.

Es gibt mindestens 4 verschiedene Gruppen von Orchestrierungslösungen, die Entwickler verwenden:

1. Nur Terraform. Ganz einfach, Entwickler müssen nur Terraform kennen, um ihre Arbeit zu erledigen.
2. Terragrunt. Reines Orchestrierungstool, mit dem die gesamte Infrastruktur orchestriert und Abhängigkeiten behandelt werden können. Terragrunt arbeitet nativ mit Infrastrukturmodulen und -kompositionen, sodass die Code-Duplizierung reduziert wird.
3. Interne Skripte. Dies geschieht oft als Ausgangspunkt für die Orchestrierung und bevor Terragrunt entdeckt wird.
4. Ansible oder ein ähnliches Allzweck-Automatisierungstool, verfolgt einen etwas anderen Ansatz als Terraform, ist ein gute Ergänzung und arbeiten wirklich gut zusammen.

Vor diesem Hintergrund werden wir die ersten beiden dieser Projektstrukturen überprüfen, Terraform only und Terragrunt.

Siehe Beispiele für Codestrukturen für [Terraform](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/a50d25a124a0490f975085e0f9260c87b7ca3fd5/beispiele/terraform.md) oder [Terragrunt](beispiele/terragrunt.md) im nächsten Kapitel.
