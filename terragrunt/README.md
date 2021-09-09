---
description: >-
  So halten Sie Ihren Terraform-Code DRY und wartbar.
---

# Warum Terragrunt?

Im Jahr 2016 wurdeTerragrunt als Notlösung für zwei Probleme in Terraform veröffentlicht:

* das Fehlen von Sperren für den Terraform-Status und
* das Fehlen einer Möglichkeit, Ihren Terraform-Status als Code zu konfigurieren.

Beides kann Terraform nun mittlerweile selbst über die `tfbackends` und der State wird in einer passenden DB abgelegt. Aber seitdem sind neue Probleme aufgetaucht, nämlich wie hälst du den Terraform-Code DRY und wartbar?

Dazu gibt es folgende Ansätze:

[Backend-Konfiguration](terragrunt/dynamisches-remote-state-management.md)
[Terraform-CLI-Argumente](#Terraform-CLI-Argumente)
[immutable Terraform Module](projektstruktur/module-local-remote.md)

## Terraform-CLI-Argumente


```
# terragrunt.hcl
terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply"]

    arguments = [
      "-var-file=../../common.tfvars",
      "-var-file=../region.tfvars"
    ]
  }
}
```
