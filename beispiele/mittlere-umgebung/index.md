---
layout: home
title: Mittelgroße Infrastruktur mit Terraform
---

Dieses Verzeichnis enthält Code als Beispiel für die Strukturierung von Terraform-Konfigurationen für eine mittelgroße Infrastruktur mit mehreren AWS-Konten, Standard-Infrastrukturmodulen.

## Merkmale

1. "prod" und "stage" sind separate Umgebungen, die nichts gemeinsam haben und in separaten AWS-Konten leben
1. Jede Umgebung verwendet eine andere Version des Standard-Infrastrukturmoduls (`alb`)
1. Jede Umgebung verwendet dieselbe Version des internen Moduls `modules/network`, da es aus einem lokalen Verzeichnis stammt.
