---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

# Umgebungsvariablen
Darüber hinaus können Eingabevariablenwerte auch mithilfe von Terraform-Umgebungsvariablen festgelegt werden . Legen Sie dazu einfach die Umgebungsvariable im Format fest **TF_VAR_<variable name>**.
```bash
export TF_VAR_ami=ami-0d26eb3972b7f8c96
```
