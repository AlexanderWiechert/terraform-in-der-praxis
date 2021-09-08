---
description: >-
  Mit Terrgrunt kann man die Abhängikeiten zwischen Modulen an einer zentralen Stelle übersichtlich verwalten und darstellen.
---

# Mit Terragrunt Abhängigkeiten verwalten

Mitunter ist es ein ganz schöner Aufwand die Abhängigkeiten zwischen Modulen besonders, wenn diese noch zusätzlich Submodule beinhalten, zu prüfen. Typischerweise werden Input Variablen über die `variables.tf` im Modul und Output Variablen über die `outputs.tf` angelegt. Zusätzlich müssen diese in der Modulkonfiguration in der `main.tf` konfiguriert werden. Also mindestens an drei Stellen. Mit jedem Submodule kommen weiter hinzu.  

Diese muss man nun trotz allen weiter konfigurieren, aber man bekomment mit Terrgrunt diese an einer zentralen Stelle prominent dargestellt.
