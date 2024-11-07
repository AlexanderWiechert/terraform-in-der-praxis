---
layout: home
title: Terragrunt
subtitle: Eine Fähigkeit von Terragrunt muss man besonders hervorheben das spontane Generieren von Remote-States.
---

## Dynamisches Remote State Management

### Der Ansatz von Terraform
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

### Setup mit mehreren Stages pro Stack
Um mehr als eine Umgebung des gleichen Stacks zu provisionieren muss man mehrere backend Konfigurationsdateien vorhalten. Das geht zwar recht einfach, aber entspricht nicht dem DRY Prinzip. Um die Duplizierung zu reduzieren, würde man wahrscheinlich die Konfiguration im Backend- Objekt mithilfe von Variablen übergeben wollen.  Leider unterstützt die `backend` Konfiguration keine RegEX, Variablen oder Funktionen.

![Terragrunt Multi Stage](/img/terragrunt_multi_stage.webp "Terragrunt Multi Stage Setup")



### Der Ansatz von Terragrunt
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

In der Ressource `remote_state` gibt es eine `generate` - Anweisung, die die Datei `backend.tf` überschreibt, wenn sie vorhanden ist, und die Verwendung der vom System generierten erzwingt . Im Abschnitt config werden hier die Einstellungen des Basis-Backend-Objekts bereitgestellt. Die meisten Einstellungen stammen aus den YAML Dateien. Zu beachten ist die Verwendung des `Key` Attributs . Dieser Wert wird basierend auf der Ordnerhierarchie generiert, in der diese HCL-Datei gespeichert ist. Es verwendet eine Terragrunt-Funktion `path_relative_to_include()` (diese Funktion ist nicht Teil von Terraform).


WARNUNG – Nachdem der Wert für den Schlüssel festgelegt wurde und die Infrastruktur bereitgestellt wurde; sollte der Wert nicht mehr geändert werden. Wenn sich der Pfad in der Konfiguration ändern, sehen zukünftige Ausführungen die Statusdatei nicht mehr und stellen die Infrastruktur von Grund auf neu bereit.


In jeder der Child Dateien terragrunt.hcl, wie z.B. `prod/terragrunt.hcl` können  wir nun Terragrunt anweisen, automatisch alle Einstellungen von der Parent Datei zu übernehmen.


```
include {
  path = find_in_parent_folders()
}
```

Der `include` Block weist Terragrunt an, genau dieselbe Konfiguration aus der über den `path` Parameter angegebenen Datei zu verwenden. Es verhält sich genau so, als ob Sie die Terraform-Konfiguration aus der enthaltenen Anweisung `remote_state` kopiert hätten, aber dieser Ansatz ist viel einfacher zu pflegen!

Die beiden `terragrunt.hcl` Dateien verwenden zwei integrierte Terragrunt-Funktionen:

`find_in_parent_folders()`: Diese Funktion gibt den absoluten Pfad zur ersten `terragrunt.hcl` Datei zurück, die sie in den Root Modul des Projektes findet. Auf diese Weise müssen Sie den pathParameter nicht in jedem Modul hart codieren.

`path_relative_to_include()`: Diese Funktion gibt den relativen Pfad zwischen der aktuellen `terragrunt.hcl` Datei und dem in ihrem includeBlock angegebenen Pfad zurück . Normalerweise verwenden wir dies in der `terragrunt.hcl` im Root Ordner Datei, damit jedes untergeordnete Terraform-Modul für die verschiedenen Stages seinen Terraform-Status mit mit anderen Schlüssel im Remote-Storage ablegt. Zum Beispiel sieht die Struktur dann im S3 Bucket folgendermassen aus: prod/terraform.tfstate sowie qa/terraform.tfstate und dev/terraform.tfstate.


### Regeln für das Mergen der verschiedenen Terragrunt Konfigurationen

Die Terraform Konfiguration der `.hcl`Datei des Modules wird dabei in die des Root Modules gemerged. Dafür gilt folgendes:

* Wenn ein `extra_arguments` Block im untergeordneten Modul denselben Namen hat wie ein `extra_arguments` Block im Root Modul, dann überschreibt dieser die Werte im Root Modul.

* Die Angabe eines leeren `extra_arguments` Blocks in einem untergeordneten Modul mit demselben Namen entfernt den Block des übergeordneten Moduls.

* Wenn der Block `extra_arguments` unterschiedliche Namen hat, dann werden diese zusammengeführt.

* Die Werte des untergeordneten Moduls werden dann nach dem des Root Moduls konfiguriert und ausgeführt.

* Wenn gleichlautende Werte im `extra_arguments` Block über ein Include Statement für `.tfvars`Dateien hinzugefügt werden, gelten die des Submodules.

>
Oben genanntes gilt für alle Anweisungen, die ich hier verwenden kann (before_hook, after_hook, source).


### Mittels generate den Terraform remote_state konfigurieren
Der Standard, wie Terragrunt den remote_state managed ist, dass es Terraform mit `-backend-config`aufruft. Wir können aber Terragrunt mittels `generate` anweisen, die Backend Konfiguration autoatisch zu generieren.

Die `generate` Funktion akzeptiert zwei Parameter:

* `path`: Der Pfad, wo die generierte Datei abgelegt werden soll.
*  `if_exist`: Eien Anweisung, was Terragrunt machen soll, wenn bereits eine Datei vorhanden ist. Hier gibt es die Möglichkeit mit  `overwrite` die existierende Datei zu überschreiben oder diese per `skip`zu übernehmen oder per `error` abzubrechen.

### automatisiertes Erstellen der Resourcen für den Remote State und Locking
Wenn terragrunt mit der `remote_state` Konfiguration ausgeführt wird, erstellt es automatisch die folgenden Resourcen, wenn diese nocht bereits existieren:

**S3 bucket**: Wenn ein S3 Bucket in der `remote_state`Konfiguration angegebenen wurde und dieser noch nicht existiert, wird dieser automatisch mit Versionierung, Verschlüsselung und Zugriffsprotokollierung angelegt. Der Bucket lässt sich auch mittels `remote_state.config.s3_bucket_tags` individuell taggen.

**DynamoDB table**: Die DynamoDB Tabelle, welche für Locking des `remote_state`verwenden wird, kann ebenfalls automatisiert von Terragrunt erstellt werden. Diese wird mit Verschlüsselung erstellt und der Primary Key als `LockID` angelegt. Die Tabelle kann ebenfalls mittels `remote_state.config.dynamodb_table_tags` individuell getaggt werden.

>
Hinweis : Wenn Sie einen profile Wert in der remote_state.config angeben, verwendet Terragrunt dieses AWS-Profil automatisch beim Erstellen des S3-Buckets oder der DynamoDB-Tabelle.

Hinweis : Die automatische `remote_state` Initialisierung kann deaktiviert werden, indem remote_state.disable_init gesetzt wird, dies überspringt die automatische Erstellung von `remote_state` Ressourcen und führt die `terraform init` Übergabe der `backend=false` Option aus. Dies kann praktisch sein, wenn Sie Befehle ausführen, z. B. `validate-all` als Teil eines CI-Prozesses, bei dem Sie den Remote-Status nicht initialisieren möchten.

