---
layout: home
title: Projektstruktur
subtitle: Erfahren Sie mehr über die Vor- und Nachteile der Verwendung von Mono-Repositories und Multi-Repositories sowie den jeweils logischsten Anwendungsfall.
---

# Wie schreibt man ein produktionsreifes Terraform Modul?

Wie bereits in [Terraform Module local vs. remote](projektstruktur/module-local-remote.md "Terraform Module local vs. remote") bereits beschrieben ist es sinnvoll, nach dem Prinzip DRY einmal geschriebenen Code nach Möglichkeit nicht zu kopieren, wenn man diesen in einem anderen Projekt braucht. ein gutes Beispiel ist hier das VPC bei AWS. Das VPC muss ich immer in allen Accounts konfigurieren. Hier bietet es sich an, dieses per GIT einzubinden.

```text
module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"
  name = "prod-vpc"
  cidr = "10.0.0.0/16"
}

```

Die empfohlene Ordnerstruktur für ein Terraform-Modul-Repository sieht wie folgt aus. Wir legen unsere Root-Modul-Konfigurationsdateien im Stammverzeichnis unseres Repositorys ab.

* main.tf
* variables.tf
* outputs.tf

Die README.md liegt ebenfalls im Stammordner. Dies ist eine Markdown-Datei, die die Informationen zu unserem Modul enthält. Es wird empfohlen, README.md Dateien für jede Terraform-Konfiguration zu verwenden, um zu beschreiben, wie das Modul verwendet wird.

Als nächstes legen wir den `modules` Ordner an, der alle Untermodule enthält, die benötigt werden, um zusätzliche Aufgaben auszuführen, beispielsweise die Konfiguration von Private Link oder das Einrichten einer statischen Website. Wir legen das `examples` Verzeichnis, das Beispiele für jedes mögliche Szenario unseres Moduls enthalten sollte. Zum Schluss legen wir das `test` Verzeichnis an, das die Testkonfiguration enthält, um unser Modul mit den Beispielen aus dem Beispielordner zu testen.

![produktionsreifes Terraform Modul](/img/production_ready_module_1.webp "produktionsreifes Terraform Modul")

Mit dieser Modulstruktur können wir Terraform-Module in Produktionsqualität erstellen, die für jedes Projekt verwendet werden können. Wie man sieht ist das erstellen des Beispiel Ordners mit testbarem Terraform unerlässlich für ein sauberes Testen. Man könnte argumentieren, dass der Code dan doppelt vorläge, was aber nicht ganz stimmt, da in dem Beispielcode u.a. fixe Werte für bestimmte Dinge angenommen werden können.

## Terraform Registry
Das Erstellen eines Moduls kann lange dauern. Es gibt jedoch Tausende von Modulen, die von der Community geteilt werden und die Sie nutzen können, indem Sie sie als Basis verwenden oder für die eigenen Bedürfnisse anpassen. Die Terraform Registry ist ein zentralisierter Ort für von der Community erstellte Terraform-Module. Es ist eine gute Idee, die Terraform-Registrierung zu überprüfen, bevor Sie Ihr eigenes Modul erstellen. Wenn man ein selbstgeschriebenes produktionsreifes Terraform Module, wie oben gezeigt schreibt kann man es im optimalen Fall selbst über die Terraform Registry anderen zur Verfügung stellen.
