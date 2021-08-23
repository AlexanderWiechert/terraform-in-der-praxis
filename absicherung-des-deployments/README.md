---
description: >-
  Terraform benötigt ein Konzept, wie das Deployment in Ihre Cloudumgebung
  abgesichert werden soll. Dies beinhaltet neben Authentifizierung auch Tests
  und Validierung des Infrastruktur Codes.
---

# Absicherung des Deployments

## State

[Remote State](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/d5baba17fff595f1fb0cd089943e26ad0706ee89/absicherung-des-deployments/schluessel-konzepte/state.md)

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. \|

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. Warum es besser ist, einen gemeinsamen Remote-State zu nutzen.

## Überprüfung und Validierung

[Überprüfung und Validierung](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/d5baba17fff595f1fb0cd089943e26ad0706ee89/absicherung-des-deployments/schluessel-konzepte/validierung.md)

Befolgen Sie eine strikte Richtlinie zur Überprüfung der Terraform-Validierung und der Planergebnisse, bevor Sie erlauben, dass Terraform Änderungen auf eine Umgebung angewendet werden.

## Rückverfolgbarkeit von Änderungen

[Rückverfolgbarkeit von Änderungen](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/d5baba17fff595f1fb0cd089943e26ad0706ee89/absicherung-des-deployments/schluessel-konzepte/rückverfolgbarkeit-von-aenderungen.md)

Erforderlich sind ein einheitliches Authentifizierungsschema und ein Audit-Mechanismus, der eindeutig nachverfolgt, welcher Auftraggeber eine Terraform-Operation ausgelöst hat, insbesondere in Produktionsumgebungen.

