---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

# Umgebungsvariablen
In Terraform können Umgebungsvariablen genutzt werden, um Werte für Eingabevariablen festzulegen. Dies ist besonders nützlich, wenn Sie Werte geheim halten oder sie einfach außerhalb Ihrer Terraform-Konfiguration speichern möchten.

Zum Beispiel, wenn Sie eine Eingabevariable in Ihrer Terraform-Konfiguration namens access_key haben, können Sie deren Wert mit einer Umgebungsvariable wie folgt festlegen:


```bash
export TF_VAR_ami=ami-0d26eb3972b7f8c96
```


Durch Festlegen der Umgebungsvariable wird Terraform diesen Wert automatisch für die Eingabevariable access_key verwenden, wenn Sie terraform apply oder einen ähnlichen Befehl ausführen.

Es ist wichtig zu beachten, dass die Umgebungsvariable mit "TF_VAR_" beginnen muss, gefolgt vom exakten Namen der Terraform-Eingabevariable (case-sensitive).

Diese Methode zur Festlegung von Variablenwerten über die Umgebung ist besonders praktisch in CI/CD-Pipelines oder in anderen automatisierten Umgebungen, wo man vielleicht nicht direkt eine Terraform-Variable in einer Datei festlegen möchte oder wenn man sensitive Daten (wie Passwörter oder Schlüssel) außerhalb der Hauptkonfigurationsdateien speichern möchte.