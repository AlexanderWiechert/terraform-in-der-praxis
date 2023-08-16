---
layout: home
title: Absicherung des Deployments
subtitle: Terraform benötigt ein Konzept, wie das Deployment in Ihre Cloudumgebung abgesichert werden soll. Dies beinhaltet neben Authentifizierung auch Tests und Validierung des Infrastruktur Codes.
---

## State

[Remote State](state.html)

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. \|

Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen. Warum es besser ist, einen gemeinsamen Remote-State zu nutzen.

## Überprüfung und Validierung

[Überprüfung und Validierung](validierung.html)

Befolgen Sie eine strikte Richtlinie zur Überprüfung der Terraform-Validierung und der Planergebnisse, bevor Sie erlauben, dass Terraform Änderungen auf eine Umgebung angewendet werden.

## Rückverfolgbarkeit von Änderungen

[Rückverfolgbarkeit von Änderungen](rueckverfolgbarkeit-von-aenderungen.html)

Erforderlich sind ein einheitliches Authentifizierungsschema und ein Audit-Mechanismus, der eindeutig nachverfolgt, welcher Auftraggeber eine Terraform-Operation ausgelöst hat, insbesondere in Produktionsumgebungen.

## Rückverfolgbarkeit von Änderungen

[CI/CD Pipelines zur Absicherung der Cloudumgebung](ci-cd-integration.html)

Verwenden Sie ein Continuous Delivery / Continuous Integration oder ein gemeinsames Orchestrierungswerkzeug, um Ihre Terraform-Operationen von einem einzigen gemeinsamen Standort aus auszuführen.

