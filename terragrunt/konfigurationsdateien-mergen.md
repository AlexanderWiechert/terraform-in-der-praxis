---
layout: home
title: Terragrunt
subtitle: Das Mergen verschiedenster Konfigurationsdateien ermöglicht es recht einfach den Code Dry zu halten.
---

# Mit Terragrunt Konfigurationsdateien mergen

## Konfigurationsdateien und Speicherorte

Dem Prinzip von DRY folgend ist es möglich in seiner Ordnerstruktur auf verschiedenen Ebenen yaml Dateien anzulegen mit Werten die verschiedenste Verwendungen haben können z.B.


accounts/global.yaml

```
---
## Definiert global Variablen Account übergreifend

# AWS Region
aws_region: eu-central-1
```


accounts/user.yaml

```
---
## Definiert benutzerspezifische Variablen z.B. der Speicherort der AWS Credentials Datei

# AWS Credentials Datei
aws_credentials_file: "~/.aws/credentials"

# lokales AWS Profil  ~/.aws/config => benannt wie in der Ordnerstruktur ./accounts/$ACCOUNT/settings.yaml
aws_profile_account_map:
    staging: "backoffice_stage"
```    


accounts/prod/settings.yaml

```
---
## Definiert die Account ID Nummer und den Umgebungsnamen
# AWS Account ID
aws_account_id: XY

# Umgebung
stage: prod
```


accounts/prod/vpc/settings.yaml

```
## Definiert die Availibility Zonen die VPC CIDR und Subnetzte
azs:
  - "eu-central-1a"
  - "eu-central-1b"
  - "eu-central-1c"

cidr: "10.16.0.0/16"

public_subnets:
  - "10.16.10.0/24"
  - "10.16.11.0/24"
  - "10.16.12.0/24"
```  

![Konfigurationsdateien mergen](/img/konfigurationsdateien.webp "Konfigurationsdateien mergen")


## Das eigentlich Mergen der Dateien
Das Mergen wird in der `terragrunt.hcl` definiert.


```
locals {
  # Importieren der benutzerspezifischen Einstellungen.
  user = try(
    yamldecode(file(find_in_parent_folders("user.yaml"))),
    run_cmd("echo", "users.yaml file was not found or is invalid.")
  )

  # Mergen der global.yaml with settings.yml.
  common = merge(
    yamldecode(file(find_in_parent_folders("global.yaml"))),
    yamldecode(file("settings.yaml"))
  )

}
```

>
Falls gleichlautenden Variablen verwendet werden in beiden Dateien werden diese immer mit dem Wert aus der letzten hier angegebenen Datei überschrieben.


## Zugriff auf die Variablen aus den Konfigurationsdateien

Auch diese geschieht typischerweise in der `terraform.hcl` Datei. Hier geben wir über die locals an welche Datei die von uns benötigten Variablen enthält und weisen sie in dem Fall `vpc` zu. Diese werden dann über die Anweisung inputs an das Modul übergeben und können dort in der variables.tf als Input Variable genutzt werden.


```
# Importieren der für das Modul VPC spezifischen Variablen
locals {
  vpc = yamldecode(file("settings.yaml"))
}

...

# Pass required inputs to module
inputs = local.vpc
```
