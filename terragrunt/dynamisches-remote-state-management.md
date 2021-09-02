---
description: >-
  Eine Fähigkeit von Terragrunt muss man besonders hervorheoben: das spontane Generieren von Remote-States.
---

# Dynamisches Remote State Management

## Der Ansatz von Terraform
Um deinen Terraform State remote speichern zu können, muss wie folgt eine Back-End-Konfiguration erstellt werden:

```
terraform {
 backend "s3" {
   bucket         = "<BUCKET_NAME>"
   key            = "state/terraform.tfstate"
   region         = "eu-central-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-bucket-key"
   dynamodb_table = "terraform-state"
 }
}
```

Wir benutzen hier den S3 Bucket um die State Dateien zu speichern. Dies wird über die Werte `bucket`und `key` erledigt. Um den Inhalt des Buckets entsprechend abzusichern legen wir noch einen KMS Key an. Die Dynamo Tabelle wird schliesslich verwendet um zu verhindern, dass zwei parallel laufenden Prozesse gleichzeitig in den Terraform State schreiben können. Für jede Umgebung, in der du Terraform verwendest muss im Grunde genommen den Code kopieren und die einzelne Werte anpassen.

## Setup mit mehreren Stages pro Stack
Um mehr als eine Umgebung des gleichen Stacks zu provisionieren muss man mehrerer backend Konfigurationsdateien vorhalten. Das geht zwar recht einfach, aber entspricht nicht dem DRY Prinzip. Um die Duplizierung zu reduzieren, würde man wahrscheinlich die Konfiguration im Backend- Objekt mithilfe von Variablen übergeben wollen.  Leider unterstützt die `backend` Konfiguration keine RegEX, Variablen oder Funktionen.

![Terragrunt Multi Stage](/img/terragrunt_multi_stage.png "Terragrunt Multi Stage Setup")



## Der Ansatz von Terragrunt
Terragrunt führt in seiner HCL-Sprache eine spezielle Ressource namens remote_state ein . Diese Ressource dient dazu, diese Konfiguration im Handumdrehen zu generieren ... genau das, was wir brauchen. Sehen wir uns eine Beispielkonfiguration zum Generieren des Remote-Zustands an.


```
locals {
  user = try(
    yamldecode(file(find_in_parent_folders("user.yaml"))),
    run_cmd("echo", "users.yaml file was not found or is invalid.")
  )
  common = merge(
    yamldecode(file(find_in_parent_folders("global.yaml"))),
    yamldecode(file("settings.yaml"))
  )
}

# Configure terraform remote state bucket
remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config   = {
    bucket                 = "product-${local.common.stage}-state"
    dynamodb_table         = "product-${local.common.stage}-state-lock"
    profile                = local.user.aws_profile_account_map[local.common.stage]
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = local.common.aws_region
    encrypt                = true
    skip_bucket_versioning = false
  }
}
```

Da sich die Konfigurationsdetails wiederholen, sind die Werte in eine YAML-Konfigurationsdatei ausgelagert, die zur Laufzeit eingelesen werden, um die entsprechenden Einstellungen abzurufen. Dies ist im Abschnitt `locals` zu sehen.

In der Ressource `remote_state` gibt es eine `generate` - Anweisung, die die Datei `backend.tf` überschreibt, wenn sie vorhanden ist, und die Verwendung der vom System generierten erzwingt . Im Abschnitt config werden hier die Einstellungen des Basis-Backend-Objekts bereitgestellt. Die meisten Einstellungen stammen aus den YAML Dateien.


Zu beachten ist die Verwendung des `Key` Attributs . Dieser Wert wird basierend auf der Ordnerhierarchie generiert, in der diese HCL-Datei gespeichert ist. Es verwendet eine Terragrunt-Funktion `path_relative_to_include()` (diese Funktion ist nicht Teil von Terraform).

{% hint style="danger" %}
WARNUNG – Nachdem der Wert für den Schlüssel festgelegt wurde und die Infrastruktur bereitgestellt wurde; sollte der Wert nicht mehr geändert werden. Wenn sich der Pfad in der Konfiguration ändern, sehen zukünftige Ausführungen die Statusdatei nicht mehr und stellen die Infrastruktur von Grund auf neu bereit.
{% endhint %}
