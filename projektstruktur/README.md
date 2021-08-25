---
description: >-
  Fragen zur Terraform-Projektstruktur sind in der Community bei weitem am
  häufigsten. Über die beste Strukturierung hat sich wahrscheinlich auch schon
  jeder Gedanken gemacht.
---

# Projektstruktur
Es gibt viele verschiedene Gründe sich für eine bestimmte Struktur in Terraform zu entscheiden. Dies kann bei der Referenzierung der Module anfangen, es spielen aber auch die Verwendung von bestimmten Tools eine Rolle, wenn diese eine gewisse Strukturierung des Projektes voraussetzen.

## Module
[Terraform Module einbinden](projektstruktur/terraform-module.md)

Best Practices für wiederverwendbare Terraform-Module GitHub-Repository. Der übliche Weg sein Projekt in Terraform zu starten, ist es lokale Module zu entwickeln. Das geht ales hervorragend und ist für die Lernkurve beim Einstieg sicher absolut sinnvoll. Allerding widerspricht dies dem Konzept von [DRY](http://c2.com/cgi/wiki?DontRepeatYourself) Don't repeat yourself. Es kann dann nämlich schnell vorkommen, dass man grundlegende Konfiguration wie z.B. die des VPC bei AWS einfach von einem Projekt ins nächste kopiert und dort minimal verändert. Hier bietet es sich an wiederverwendbare Terraform-Module zu [finden](https://github.com/terraform-aws-modules), oder diese selber zu schreiben. So kann man in Zukunft diese Module in neuen Projekten einfach referenzieren und eine Handvoll Variablen übergeben.

## Wrapper und Tools
[Terragrunt](codestruktur/beispiele/terragrunt.md)
