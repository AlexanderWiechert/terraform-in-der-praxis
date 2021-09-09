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

* [Backend-Konfiguration](terragrunt/dynamisches-remote-state-management.md)
* [Terraform-CLI-Argumente](#terraform-cli-argumente)
* [immutable Terraform Module](projektstruktur/module-local-remote.md)

CLI-Flags sind ein Part in deinem Terraform Projekt, wo die eigentlich nicht nahc dem Prinzip DRY arbeiten kannst. Ein typisches Muster bei Terraform besteht beispielsweise darin, die Variablen für deinen Account in einer eigenen Datei zu definieren :


```
# account.tfvars
account_id     = "123456789012"
account_bucket = "my-terraform-bucket"
```

gleiches dann z.B. für die Region

```
# region.tfvars
aws_region = "us-east-2"
foo        = "bar"

## Terraform-CLI-Argumente
```

Du kannst Terraform anweisen, diese Variablen mit dem `-var-file` Argument einzulesen.

```
terraform apply \
    -var-file=../../common.tfvars \
    -var-file=../region.tfvars
```

Je nachdem wie viele diese Argumente jedesmal angehangen werden müssen, ist das recht fehleranfällig. Terragrunt ermöglich es hier
dem DRY Prinzip folgend indem die Argumente dynamisch als Code konfiguriert werden können.

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


```
terragrunt apply
Running command: terraform with arguments [apply -var-file=../../common.tfvars -var-file=../region.tfvars]
```
