---
description: >-
  Before Hooks oder After Hooks ermöglichen es Dinge, wie z.B. eine Authentifizierung in den Prozess zu integrieren.
---

# Mit Terragrunt Konfigurationsdateien mergen

Dem Prinzip von DRY folgend ist es möglich in seiner Ordnerstruktur auf verschiedenen Ebenen yaml Dateien anzulegen mit Werten die verschiedenste Verwendungen haben können z.B.

global.yaml

```
---
## Definiert global Variablen Account übergreifend

# AWS Region
aws_region: eu-central-1
```


user.yaml

```
---
## Definiert Benutzerspezifische Variablen z.B. der Speicherort der AWS Credentials Datei

# AWS Credentials Datei
aws_credentials_file: "~/.aws/credentials"

# lokales AWS Profil  ~/.aws/config => benannt wie in der Ordnerstruktur ./accounts/$ACCOUNT/settings.yaml
aws_profile_account_map:
    staging: "backoffice_stage"
```    

![Konfigurationsdateien mergen](/img/konfigurationsdateien.png "Konfigurationsdateien mergen")
