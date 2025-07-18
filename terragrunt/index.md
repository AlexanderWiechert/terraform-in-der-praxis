---
layout: home
title: Terragrunt
subtitle: So halten Sie Ihren Terraform-Code DRY und wartbar.
---

# Warum Terragrunt?


Im Jahr 2016 wurdeTerragrunt als Notlösung für zwei Probleme in Terraform veröffentlicht:

* das Fehlen von Sperren für den Terraform-Status und
* das Fehlen einer Möglichkeit, Ihren Terraform-Status als Code zu konfigurieren.

Beides kann Terraform nun mittlerweile selbst über die `tfbackends` und der State wird in einer passenden DB abgelegt. Aber seitdem sind neue Probleme aufgetaucht, nämlich wie hälst du den Terraform-Code DRY und wartbar?

Dazu gibt es folgende Ansätze:

* [Backend-Konfiguration](#backend-konfiguration)
* [Terraform-CLI-Argumente](#terraform-cli-argumente)
* [immutable Terraform Module](projektstruktur/module-local-remote.md)

CLI-Flags sind ein Part in deinem Terraform Projekt, wo die eigentlich nicht nahc dem Prinzip DRY arbeiten kannst. Ein typisches Muster bei Terraform besteht beispielsweise darin, die Variablen für deinen Account in einer eigenen Datei zu definieren:


### Backend-Konfiguration
Terraform-Back-Ends ermöglichen es Ihnen, den Terraform-Status remote zu speichern, damit man diesen gemeinsam verwenden kann.
Um ein Terraform-Back-End zu verwenden, fügen Sie backend Ihrem Terraform-Code eine Konfiguration hinzu:

```
# stage/frontend/main.tf
terraform {
  backend "s3" {
    Bucket = "terraform-state"
    key = "stage/frontend/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    dynamodb_table = "lock-table"
  }
}
```
Der obige Code weist Terraform an, den state in einem S3-Bucket zu speichern und eine DynamoDB-Tabelle zu verwenden, um einen state-lock durchzuführen. Dies ist eine großartige Funktion, aber es hat einen großen Nachteil - die backend Konfiguration unterstützt keine Variablen. Das heißt, Folgendes wird NICHT funktionieren:

```
# stage/frontend/main.tf
terraform {
  backend "s3" {
    Bucket = var.terraform_state_bucket
    key = var.terraform_state_key
    region = var.terraform_state_region
    encrypt = var.terraform_state_encrypt
    dynamodb_table = var.terraform_state_dynamodb_table
  }
}
```

Das bedeutet, dass dieselbe backend Konfiguration in jedes Module kopiert werden muss. Hier muss man aber sehr achtsam vorgehen und die Werte unbedingt ändern, damit nicht zwei Module in den selben state schreiben und sich so jedesmal gegenseitig überschreiben würden.


[weiter](/terragrunt/dynamisches-remote-state-management.html)

### Terraform-CLI-Argumente

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
Wenn du  nun die Befehle `plan` oder `apply` ausführst, fügt Terragrunt diese Argumente automatisch hinzu:

```
terragrunt apply
Running command: terraform with arguments [apply -var-file=../../common.tfvars -var-file=../region.tfvars]
```
