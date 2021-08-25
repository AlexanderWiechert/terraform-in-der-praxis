---
description: >-
  Kurze Erklärung zu den verschieden Möglichkeiten Terraform Module einzubinden in Ihr Projekt. Es gibt neben lokalen Modulen
  die Möglichkeit diese remote z.B. per Git einzubinden.
---

# Terraform Module

## Lokale Module
Am einfachsten ist es, wenn ich die zusammengehörigen Ressourcen in eine lokales Modul schreibe. Zum Beispiel für ein Modul mit Namen frontend.

```text
module "frontend" {
  source = "./modules/frontend"
  project                           = var.projectname
  ...
}
```

## Terraform Registry Module
Die Terraform Registry hostet Tausende von eigenständigen Paketen, die als Module bezeichnet werden. Diese Module nutzen beliebte Anbieter von Amazon Web Services (AWS), Microsoft Azure , Google Cloud Platform (GCP) und einigen anderen. Jedes Modul reduziert den Zeitaufwand für die Bereitstellung von Cloud-Ressourcen, indem es ihnen ermöglicht, eine Handvoll Eingaben mit minimalem Codierungsaufwand bereitzustellen. Das networkModul von Google wird beispielsweise wie folgt bezogen:

```text
module "network" {
  source  = "terraform-google-modules/network/google"
  ...
}
```

## Git Module

### GitHub
Terraform erkennt github.com URLs ohne Präfix und interpretiert sie automatisch als Git-Repository-Quellen.

```text
module "terraform-ecs-jenkins" {
  source = "github.com/elastic2ls/terraform-ecs-jenkins.git"
}
Das obige Adressschema wird über HTTPS geklont. Um über SSH zu klonen, verwenden Sie das folgende Formular:

module "terraform-ecs-jenkins" {
  source = "git@github.com:elastic2ls/terraform-ecs-jenkins.git"
}
```

Diese GitHub-Schemas werden als praktische Aliase für das allgemeine Git-Repository- Adressschema behandelt und erhalten daher auf dieselbe Weise Anmeldeinformationen und unterstützen das refArgument für die Auswahl einer bestimmten Revision. Sie müssen die Anmeldeinformationen insbesondere für den Zugriff auf private Repositorys konfigurieren.

### Generisches Git-Repository
Beliebige Git-Repositorys können verwendet werden, indem der Adresse das spezielle git::Präfix vorangestellt wird. Nach diesem Präfix kann eine beliebige gültige Git-URL angegeben werden, um eines der von Git unterstützten Protokolle auszuwählen.

Um beispielsweise HTTPS oder SSH zu verwenden:

```text
module "terraform-ecs-jenkins" {
  source = "git::https://gitlab.com/elastic2ls/terraform-ecs-jenkins.git"
}

module "terraform-ecs-jenkins" {
  source = "git::ssh://gitlab.com/elastic2ls/terraform-ecs-jenkins.git"
}
```

Terraform installiert Module aus Git-Repositorys, indem es ausgeführt wird git clone, und respektiert daher alle lokalen Git-Konfigurationseinstellungen auf Ihrem System, einschließlich der Anmeldeinformationen. Um auf ein nicht öffentliches Git-Repository zuzugreifen, konfigurieren Sie Git mit geeigneten Anmeldeinformationen für dieses Repository.

Wenn Sie das SSH-Protokoll verwenden, werden automatisch alle konfigurierten SSH-Schlüssel verwendet. Dies ist die gebräuchlichste Methode, um von automatisierten Systemen auf nicht öffentliche Git-Repositorys zuzugreifen, da sie den Zugriff auf private Repositorys ohne interaktive Eingabeaufforderungen ermöglicht.

Wenn Sie das HTTP/HTTPS-Protokoll oder ein anderes Protokoll verwenden, das Benutzername/Passwort-Anmeldeinformationen verwendet, konfigurieren Sie Git Credentials Storage , um eine geeignete Quelle für Anmeldeinformationen für Ihre Umgebung auszuwählen.

### Auswahl einer Revision

Standardmäßig klont Terraform und verwendet den Standardzweig (verwiesen durch HEAD) im ausgewählten Repository. Sie können dies mit dem refArgument überschreiben :
```text
module "vpc" {
  source = "git::https://gitlab.com/elastic2ls/terraform-ecs-jenkins.git?ref=v1.2.0"
}
```
Der Wert des refArguments kann eine beliebige Referenz sein, die vom git checkoutBefehl akzeptiert würde , einschließlich Verzweigungs- und Tag-Namen.

### Private Git-Repositorys

Git unterstützt eine Handvoll Methoden zum Anfordern und Konsumieren von Anmeldeinformationen. Jede Methode hat Vor- und Nachteile. Ich verwende HTTPS mit dem OAuth 2.0-Autorisierungsframework für meine GitLab-Umgebung. Es ist einfach zu implementieren, verwendet einen geschützten und maskierten Tokenwert und lässt sich über Continuous Integration (CI) leicht automatisieren. Zusätzlich wird der Zugriff über Zwei-Faktor-Authentifizierung (2FA) realisiert.

Git muss wissen, wann und wo das Token verwendet werden soll, wenn es Code aus einem privaten Repository auscheckt. Ich möchte die Token-Informationen aus Sicherheitsgründen nicht in der Terraform-Konfiguration bereitstellen. Stattdessen möchte ich, dass git automatisch erkennt, wenn Terraform-Module aus einem privaten Repository geladen werden, und das Token für die Dauer der Sitzung einfügt.

Die Lösung besteht darin, die ```insteadOf``` Option von git zu verwenden , wie unten gezeigt:

```text
git config --global url."https://oauth2:TOKEN@gitlab.com".insteadOf https://gitlab.com
```

Git fügt sich dynamisch ```oauth2:TOKEN@``` in die ```https://gitlab.comURL``` ein. Das Token authentifiziert die Client-Sitzung, ermöglicht das Auschecken des Codes und gibt die Konfiguration an Terraform zurück.

```text
> terraform init

Initializing modules...
Downloading git::https://gitlab.com/elastic2ls/terraform-ecs-jenkins.git for site-deploy...
```

Wenn das Token ungültig ist, wird der Initialisierungsvorgang durch einen Zugriffsverweigerungsfehler beendet.

```text
Cloning into '.terraform/modules/site-deploy'...
remote: HTTP Basic: Access denied
fatal: Authentication failed for
'https://gitlab.com/elastic2ls/terraform-ecs-jenkins.git'
```

### Referenzieren von Modulen in Unterverzeichnissen

Das vorherige Git-Repository hostet ein einzelnes Modul. Git checkt das gesamte Repository aus und gibt den Inhalt als Modul an Terraform zurück. Es ist jedoch auch möglich, mehrere Module in einem einzigen Git-Repository zu speichern. Dies wird als „Monorepo“ bezeichnet.

In diesem neuen Szenario habe ich ein einzelnes Git-Repository mit dem Namen, module-library das mehrere Module in verschiedenen Ordnern hostet. Ich möchte speziell das Modul namens vpc, das in einem Ordner namens account-provision liegt nun auschecken. Durch die Verwendung des doppelten Slash ```//``` am Ende des Namens des Repositorys kann ich Terraform anweisen, einen bestimmten Ordner auszuchecken.

```text
module "transit-gateway" {
  source = "git::https://gitlab.com/elastic2ls/module-library.git//account-provision/vpc"
}
```
Ich persönlich bevorzuge dieses Modell in den meisten Situationen. Dies führt zu weniger Repositorys, erfordert jedoch eine stärkere Zusammenarbeit und Sicherheitskontrollen für den Quellcode. Es kann jedoch noch mehr getan werden, um dieses Design zu verbessern.


### Dependency Pinning über Tags oder Branches

Ich mache es mir zur Gewohnheit, Abhängigkeiten zu fixieren, um Breaking Changes zu vermeiden. Dieses Designmuster gilt auch für Module in privaten Git-Repositorys. Für von Git gehostete Repositorys bedeutet dies, dass beim Laden eines Moduls ein geschützter, nicht standardmäßiger Branch oder eine Tag-Version verwendet wird. Der ```ref``` Abfrageparameter wird an übergeben, ```git checkout``` um eine bestimmte Branch- oder Tag-Version auszuwählen.

```text
# das Modul verwendet den Branch "production"
module "transit-gateway" {
  source = "git::https://gitlab.com/elastic2ls/module-library.git//account-provision/vpc?ref=production"
}

# das Modul verwendet den Tag "1.0.0"
module "transit-gateway" {
  source = "git::https://gitlab.com/elastic2ls/module-library.git//account-provision/vpc?ref=tags/v1.0.0"
}
```
Das Anheften des Moduls verringert die Wahrscheinlichkeit, dass ein Breaking Change unwissentlich aufgenommen wird.
