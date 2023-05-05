---
layout: home
title: Terragrunt
subtitle: Before Hooks oder After Hooks ermöglichen es Dinge, wie z.B. eine Authentifizierung in den Prozess zu integrieren.
---

## Before Hooks oder After Hooks


Before Hooks oder After Hooks sind eine Funktion von terragrunt, die es ermöglicht, benutzerdefinierte Aktionen zu definieren, die entweder vor oder nach der Ausführung des `terraform`  Befehls aufgerufen werden .

Hier ist ein Beispiel:

```
terraform {
  before_hook "before_hook" {
    commands     = ["apply", "plan"]
    execute      = ["awsume", "myaccount"]
  }

  after_hook "after_hook" {
    commands     = ["apply", "plan"]
    execute      = ["rm", "terraform.tf"]
    run_on_error = true
  }
}
```

In dieser Beispielkonfiguration passieren immer, wenn Terragrunt `terraform apply` oder ausgeführt wird `terraform plan`, folgende Dinge:

Bevor Terragrunt `terraform` ausgeführt wird , wird mittels in diesem Beispiel [awsume](https://awsu.me/) der login in eine mittels MFA geschütztes Profile durchgeführt.
Nachdem Terragrunt `terraform` ausgeführt hat, wird die automatisch erstellte terraform.tf Datei gelöscht, unabhängig davon, ob der Befehl fehlgeschlagen ist oder nicht.
Es können mehrere Vorher- und Nachher-Hooks verwendet werden. Jeder Hook wird in der Reihenfolge ausgeführt, in der er definiert wurde. Zum Beispiel:

```
terraform {
  before_hook "before_hook_1" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Have some more fun with terragrunt"]
  }

  before_hook "before_hook_2" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Running Terraform"]
  }
}
```
