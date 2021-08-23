---
description: >-
  Terraform benötigt ein Konzept, wie das Deployment in Ihre Cloudumgebung
  abgesichert werden soll. Dies beinhaltet neben Authentifizierung auch Tests
  und Validierung des Infrastruktur Codes.
---

# Absicherung des Deployments

## State

[Remote State](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/1fc5bd368b7468739b203f29b6d7941f8285ffd0/absicherung-des-deployments/absicherung-des-deployments/state.md)

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. \|

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. Warum es besser ist, einen gemeinsamen Remote-State zu nutzen.

## Überprüfung und Validierung

[Überprüfung und Validierung](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/1fc5bd368b7468739b203f29b6d7941f8285ffd0/absicherung-des-deployments/absicherung-des-deployments/validierung.md)

Befolgen Sie eine strikte Richtlinie zur Überprüfung der Terraform-Validierung und der Planergebnisse, bevor Sie erlauben, dass Terraform Änderungen auf eine Umgebung angewendet werden.

## Rückverfolgbarkeit von Änderungen

[Rückverfolgbarkeit von Änderungen](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/1fc5bd368b7468739b203f29b6d7941f8285ffd0/absicherung-des-deployments/absicherung-des-deployments/rückverfolgbarkeit-von-aenderungen.md)

Erforderlich sind ein einheitliches Authentifizierungsschema und ein Audit-Mechanismus, der eindeutig nachverfolgt, welcher Auftraggeber eine Terraform-Operation ausgelöst hat, insbesondere in Produktionsumgebungen.

## Rückverfolgbarkeit von Änderungen

[CI/CD Pipelines zur Absicherung der Cloudumgebung](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/1fc5bd368b7468739b203f29b6d7941f8285ffd0/absicherung-des-deployments/absicherung-des-deployments/cd-ci-integration.md)

Verwenden Sie ein Continuous Delivery / Continuous Integration oder ein gemeinsames Orchestrierungswerkzeug, um Ihre Terraform-Operationen von einem einzigen gemeinsamen Standort aus auszuführen.

