---
layout: home
title: Codestruktur
subtitle: Welche Strukturelle Konventionen bei der Verwendung von Terraform sind sinnvoll. Wie findet  man die verwendeten Resourcen am schnellsten wieder.
---

## Strukturelle Konventionen

Erstellen einer main.tf oder nicht?
> Unbedingt, da das die zentrale Anlaufstelle ist um sich einen Überblick über das Projekt zu verschaffen.

In jedem Submodule Ordner?
> Siehe Antwort oben.

was gehört in die main.tf?
> 1. terraform backends, required providers
> 2. locals wie z.B. project, account_id, environment, tags
> 3. provider Konfigurationen
> 4. Module Konfigurationen, Variablen die in die Module übergeben werden müssen

### Beispiel
```
locals {
  project    = "CustomerAcess"
  env        = lower(terraform.workspace)
  tags = {
    ITServiceName    = "Billing_Account_nr"
    Landscape        = local.project
    managed_by       = "Terraform"
    terraform_source = "https://github.com/Elastic2ls/tree/development/infrastructure"
    product          = "Elastic2ls-CustomerAcess"
    environment      = local.env
  }
}
```

## Generelle Projektstruktur
Module sollten möglichst unabhängig voneinander deployed werden können. Das reflektiert den Gedanken des Services, bzw. Microservices. Man kann diese zwar in einzelne Repos auslagern, aber das haben wir [bereits](../schluessel-konzepte/kompositionen.md) diskutiert. Wir werden diese in diesem Beispiel in einem Repository speichern, wobei das Repository genau einem Produkt oder Service entspricht. Zum Beispiel ein Customer Interface.

Dieses besteht aus frontend, backend und einem DNS Modul.

### Beispiel
```
tree -L 1 modules
modules
├── backend
├── dns
└── frontend
```

Hier kann jedes Modul wiederum Submodule enthalten, welche den Service in weitere logisch verbundene Ressourcen für einen Microservice einteilen kann.

### Beispiel

```
tree -L 2 modules
-> % tree -L 2 modules
modules
├── backend
│   ├── cloudWatch.tf
│   ├── cognito.tf
│   ├── customer-feedback
│   ├── dynamodb.tf
│   ├── export
│   ├── iam.tf
│   ├── lambda.tf
│   ├── main.tf
│   ├── customer-order
│   ├── outputs.tf
│   ├── customer-product
│   ├── providers.tf
│   ├── api.tf
│   ├── s3.tf
│   ├── customer-shipping
│   ├── sns.tf
│   ├── sqs.tf
│   ├── tags.tf
│   ├── customer-management
│   └── variables.tf
├── dns
│   ├── certificates.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── route53.tf
│   └── variables.tf
└── frontend
    ├── cloudfront.tf
    ├── outputs.tf
    ├── providers.tf
    ├── route53.tf
    ├── s3.tf
    └── variables.tf
```

Das hat den grossen Vorteil, dass diese auch einzeln angepasst werden können.

`terraform plan -target=module.frontend`

oder

`terraform plan -target=module.backend.customer-management`


## Module Konfiguration

Module bzw. Submodule werden immer nach folgendem Schema erstellt.

- module "Name des Modules"
- source "Pfad zum Ordner mit den Moduledateien"
- aliases "Name der Variable = Wert der Variable"

### Beispiel
```
module "backend" {
  source = "./modules/frontend"
  // Global settings
  project                           = local.project
  account_id                        = local.account_id
  env                               = local.env
  baseTags                          = merge(local.tags, { module = "frontend" })

  // Environment specific setings
  use_cloudfront         = var.frontend_use_cloudfront
  aliases                = var.frontend_aliases
  use_custom_certificate = var.frontend_use_custom_certificate
  acm_certificate_arn    = var.frontend_acm_certificate_arn
  dns_zone_fqdn          = module.dns.dns_zone_fqdn
  certificate_region     = var.certificate_region
  zone_id                = module.dns.zone_id
}
```

## Variablen und Outputs
Variablen sollen lediglich an einer Stelle deklariert werden und Werte zugewiesen bekommen. Das kann eine `variables.tf` Datei im Root Module sein oder eine Yaml Datei.

Für mich hat dieses Setup mit Modulen und Submodulen einen nicht unerheblichen Nachteil. Ich muss nun alle Variablen, die ich in meinen Submodulen nutzen will einmal vom Root Module nach unten durchreichen sowie alle Variablen, welche aus Submodulen kommen, die ich aber in anderen Modulen benötige wieder nach oben reichen.

## Beispiel
```
variable = "api_custom_domain" {
  type = string
  description = "dns alias for the custome domainname of the api"
  default = "api.customerdomain.de"
}
```

`Root Modul => backend => customer-product => var. api_custom_domain`

`module.backend.customer-product.api_custom_domain => backend => Root Module => frontend`

```
output "api_custom_domain" {
  value = aws_cloudfront_distribution.api_custom_domain.dns_name
}
```

Zugegeben das Beispiel macht nicht richtig sein aber es soll folgendes verdeutlichen. Ich muss nun in jedem der Module `Root Modul`, `backend`und `customer-product` jeweils die Variablen und Outputs definieren. Sowie diese dann, wie oben gesehen, in der Modulekonfiguration anlegen.

Das sind in Summe
- 3 x Variablen anpassen
- 2 x Outputs anpassen
- 2 x module Definition anpassen

Das ist auf jeden Fall fehleranfällig. Mit terragrunt habe ich das gleiche Problem, die Variablen werden dort statt in der `variables.tf` in eine Yaml Datei ausgelagert. Allerdings muss ich diese dann ebenfalls in die Module hinein und herausreichen. Einziger Vorteil ist, das dies in einer Datei pro Modul/Submodul konfigriert wird und nicht an drei Stellen.
