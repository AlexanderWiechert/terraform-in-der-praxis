---
description: >-
  Eine Fähigkeit von Terragrunt muss man besonders hervorheoben: das spontane Generieren von Remote-States.
---

# – Dynamisches Remote State Management

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

Die zweite Herausforderung besteht darin, diese Konfiguration in Git zu verwalten. Angenommen, du möchtest denselben Stack für die Produktion und Entwicklung bereit stellen. Du müsstest zwei Repositorys erstellen, eines für jede Umgebung (oder möglicherweise verschiedene Branches verwenden). Idealerweise möchten sollte Code und Konfiguration trennen.

Um die Duplizierung zu reduzieren, würde man wahrscheinlich die Konfiguration im Backend- Objekt mithilfe von Variablen übergeben. Allerdings müssen Provider- und Backend- Konfigurationen zur „Kompilierungszeit“ im Voraus bekannt sein und können nicht dynamisch mittels Variablen übergeben werden.

## Der Ansatz von Terragrunt
Terragrunt führt in seiner HCL-Sprache eine spezielle Ressource namens remote_state ein . Diese Ressource dient dazu, diese Konfiguration im Handumdrehen zu generieren ... genau das, was wir brauchen. Sehen wir uns eine Beispielkonfiguration zum Generieren des Remote-Zustands an.


```
# Configure terraform remote state bucket
remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config   = {
    bucket                 = "${local.project}-${local.common.stage}-state"
    dynamodb_table         = "${local.project}-${local.common.stage}-state-lock"
    profile                = local.user.aws_profile_account_map[local.common.stage]
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = local.common.aws_region
    encrypt                = true
    skip_bucket_versioning = false
  }
}
```

Da sich die Konfigurationsdetails wiederholen, habe ich die Werte in eine YAML-Konfigurationsdatei ausgelagert, die ich zur Laufzeit lese, um die entsprechenden Einstellungen abzurufen. Dies ist im Abschnitt `locals` zu sehen . Beachten Sie auch die Verwendung der Funktion `find_in_parent_folders`.

In der Ressource `remote_state` habe ich eine `generate` - Anweisung, die die Datei `backend.tf` überschreibt, wenn sie vorhanden ist, und die Verwendung der vom System generierten erzwingt . Im Abschnitt config werden hier die Einstellungen des Basis-Backend-Objekts bereitgestellt. Die meisten Einstellungen stammen aus der YAML-Konfiguration.



Zu beachten ist die Verwendung des `Key` Attributs . Dieser Wert wird basierend auf der Ordnerhierarchie generiert, in der diese HCL-Datei gespeichert ist. Es verwendet eine Terragrunt-Funktion (diese Funktion ist nicht Teil von Terraform). 


WARNUNG – Nachdem der Wert für den Schlüssel festgelegt wurde und Sie die Infrastruktur bereitgestellt haben; ÄNDERN SIE es NICHT. Wenn Sie den Pfad in der Konfiguration ändern, sehen zukünftige Pläne keine Statusdatei und stellen die Infrastruktur von Grund auf neu bereit.
