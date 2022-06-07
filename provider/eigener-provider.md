---
description: >-
Ein kurzes Howto, wie sie einen eignene Terraform Provider schreiben können.
---

# Was sind Terraform-Provider?

Das Erstellen und Verwalten von Ressourcen mit Terraform basiert auf Plug-ins, die als Provider bezeichnet werden. Jedes Provider-Plug-In ist für die Interaktion mit Cloud-Providern, SaaS-Providern und anderen APIs verantwortlich. 
Die meisten Provider konfigurieren eine bestimmte Infrastrukturplattform (entweder in der Cloud oder selbst gehostet). Provider können auch lokale Dienstprogramme für Aufgaben wie das Generieren von Zufallszahlen für eindeutige Ressourcennamen anbieten.

Jeder Provider fügt eine Reihe von Ressourcentypen und/oder Datenquellen hinzu, die Terraform verwalten kann. Jeder Ressourcentyp wird von einem Provider implementiert; 
Ohne Provider kann Terraform keinerlei Infrastruktur verwalten. Terraform Provider ermöglicht Erweiterbarkeit nicht nur für die Cloud-Infrastruktur, sondern ermöglicht auch die Verwaltung von Objekten, die durch offengelegte API-Aufrufe erstellt werden können.

## Benutzerdefinierter Terraform-Provider

Im Folgenden sind einige der möglichen Szenarien zum Erstellen eines benutzerdefinierten Terraform-Providers aufgeführt, z. B.:

    Eine interne Private Cloud, deren Funktionalität entweder proprietär ist oder der Open-Source-Community keinen Nutzen bringen würde.
    Ein in Arbeit befindlicher Provider, der lokal getestet wird, bevor er zur Registrierung beiträgt.
    Erweiterungen eines bestehenden Providers.

## Wie funktioniert das Terraform- und Provider-Plug-in?

Gemäß der Terraform-Dokumentation :

## Terraform-Core

    Terraform Core ist eine statisch kompilierte Binärdatei, die in der Programmiersprache Go geschrieben wurde. Die kompilierte Binärdatei ist das Befehlszeilentool (CLI) terraform, und dies ist der Einstiegspunkt für jeden, der Terraform verwendet.

    Die Hauptaufgaben von Terraform Core sind:

        Infrastruktur als Code: Lesen und Interpolieren von Konfigurationsdateien und Modulen
        Verwaltung des Ressourcenzustands
        Konstruktion des Ressourcengraphen
        Ausführung planen
        Kommunikation mit Plugins über RPC

## Terraform-Plugins

    Terraform-Plugins werden in Go geschrieben und sind ausführbare Binärdateien, die von Terraform Core über RPC aufgerufen werden.

Terraform-Provider-Plug-in-Design Quelle: Terraform-Dokumentation

    Jedes Plug-in stellt eine Implementierung für einen bestimmten Dienst bereit, z. B. AWS, oder einen Provider wie bash. Alle Provider und Provisioner, die in Terraform-Konfigurationen verwendet werden, werden als Plugins bezeichnet. Terraform Core bietet ein High-Level-Framework, das die Details der Plugin-Erkennung und RPC-Kommunikation abstrahiert, sodass Entwickler sie nicht verwalten müssen.

    Die Hauptaufgaben von Provider-Plugins sind:

        Initialisierung aller enthaltenen Bibliotheken, die zum Ausführen von API-Aufrufen verwendet werden.
        Authentifizierung beim InfrastrukturProvider.
        Definieren Sie Ressourcen, die bestimmten Diensten zugeordnet sind

    Die Hauptaufgaben von Provisioner-Plug-ins sind:

        Ausführen von Befehlen oder Skripten auf der angegebenen Ressource nach der Erstellung oder bei der Zerstörung.

Bitte beachten Sie, dass sich unser Beitrag auf die Entwicklung von Provider-Plugins konzentriert

## Installation der Terraform-CLI-Datei und des Provider-Plugins

Terraform 0.13+ verwendet die .terraformrcCLI-Konfigurationsdatei, um das Installationsverhalten des Providers zu handhaben. Also müssen wir die Konfigurationsdatei unter dem Pfad erstellen $HOME/.terraformrcund den folgenden Inhalt hinzufügen:

```text
plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
disable_checkpoint = true
```

Für die Provider-Installation stehen zwei Methoden zur Verfügung (ab Terraform 0.13+).

### Explizite Installationsmethode
Ein provider_installationBlock in der CLI-Konfiguration ermöglicht das Überschreiben des standardmäßigen Installationsverhaltens von Terraform, sodass Sie Terraform zwingen können, einen lokalen Spiegel für einige oder alle Provider zu verwenden, 
die Sie verwenden möchten. Bei der expliziten Installationsmethode benötigen wir einen provider_installationBlock.

### Implizite lokale Mirror-Methode
Wenn die CLI-Konfigurationsdatei keinen provider_installation Block enthält, erstellt Terraform eine implizite Konfiguration.

Wir werden die implizite lokale Spiegelungsmethode verwenden, um unseren benutzerdefinierten Provider zu installieren.

Das Standardverhalten von terraform initist normalerweise der Versuch, den Provider aus der Terraform-Registrierung aus dem Internet herunterzuladen. Da wir das benutzerdefinierte Providerszenario nachahmen, 
können wir dieses Verhalten durch eine implizite Methode überschreiben. Mit der impliziten Methode versucht Terraform implizit, die Provider lokal im Plugin-Verzeichnis `~/.terraform.d/plugins` für Linux-Systeme 
und `%APPDATA%\terraform.d\plugins` in Windows-Systemen zu finden.
Was ist erforderlich, um einen benutzerdefinierten Provider zu entwickeln?

    Nur ein grundlegendes Go-Entwicklungswissen reicht aus, um loszulegen.
    Offengelegte API-Details vom DienstProvider zum Verwalten von Ressourcen.

### So installieren und konfigurieren Sie Terraform

Informationen zur Installation von Terraform finden Sie hier

Fenster:

    Laden Sie die ausführbare Terraform-Datei herunter und extrahieren Sie sie
    Fügen Sie den ausführbaren Terraform-Pfad zur Variablen ENV PATH hinzu

Extrahieren und kopieren Sie in Linux-Varianten die ausführbare Terraform-Datei in den Pfad /usr/bin, um sie von einem beliebigen Verzeichnis aus auszuführen.
Installieren Sie Go und richten Sie die Entwicklungsumgebung ein

Befolgen Sie die Installationsschritte für Go, die auf der offiziellen Go-Website erwähnt werden , und beginnen Sie mit Go.

## Details zum Quellcode des benutzerdefinierten Providers

Gehen Sie zu `$HOME/go/src` Pfad und erstellen Sie Code.

```text
cd $HOME/go/src
mkdir tf_custom_provider
```

Erforderliche Quelldateien für benutzerdefinierte Provider sind:

    main.go
    provider.go
    resource_server.go

Das Code-Layout sieht so aus:

```text
.
├── main.go
├── provider.go
├── resource_server.go
```

## Funktionalität des Providers

Wir werden einen Provider mit der folgenden Funktionalität erstellen. Da dies ein Beispiel sein wird, werden wir die Funktionen zum Erstellen und Löschen von Terraform-Ressourcen verspotten. 
Wir werden auch die Zufalls-UUID-Generator-API verwenden und sie wird als Teil der Erstellungsfunktion hinzugefügt, um die Möglichkeit zum Aufrufen des API-Aufrufs zu zeigen. 
Die API kann später mit der tatsächlichen Ressourcenerstellungs-API für Cloud-Provider, On-Prem-DienstProvider oder eine beliebige As a ServiceProvider-API geändert werden.

### main.go

Go-Einstiegspunktfunktion ist `main.go`.

```text
// main.go
package main

import (
    "github.com/hashicorp/terraform-plugin-sdk/plugin"
    "github.com/hashicorp/terraform-plugin-sdk/terraform"
)

func main() {
    plugin.Serve(&plugin.ServeOpts{
        ProviderFunc: func() terraform.ResourceProvider {
            return Provider()
        },
    })
}
```

### Provider.go

`provider.go` wird die Ressourcen-Server-Funktionsaufrufe haben.

```text

// provider.go
package main

import (
    "github.com/hashicorp/terraform-plugin-sdk/helper/schema"
)

func Provider() *schema.Provider {
    return &schema.Provider{
        ResourcesMap: map[string]*schema.Resource{
            "example_server": resourceServer(),
        },
    }
}
```

### resource_server.go

Die gesamte Ressourcenerstellung muss in codiert werden `resource_server.go`. Diese Datei enthält die Ressourcenfunktionsdeklaration und -definition wie Erstellen, Löschen usw. Sie erhält auch die Eingabeparameter, 
die zum Erstellen von Ressourcen erforderlich sind.

Als Teil dieses BeispielProviders verfügt der Ressourcenserver über die folgenden Funktionen:

    apply 
    delete

```text
// resource_server.go
package main

import (
    "net/http"
    "log"
    "github.com/hashicorp/terraform-plugin-sdk/helper/schema"
)

func resourceServer() *schema.Resource {
    return &schema.Resource{
        Create: resourceServerCreate,
        Read:   resourceServerRead,
        Update: resourceServerUpdate,
        Delete: resourceServerDelete,
        
            Schema: map[string]*schema.Schema{
                "uuid_count": &schema.Schema{
                    Type:     schema.TypeString,
                    Required: true,
                },
            },
    }
}

func resourceServerCreate(d *schema.ResourceData, m interface{}) error {
uuid_count := d.Get("uuid_count").(string)

    d.SetId(uuid_count)

    // https://www.uuidtools.com/api/generate/v1/count/uuid_count
    resp, err := http.Get("https://www.uuidtools.com/api/generate/v1/count/" + uuid_count)
    if err != nil {
        log.Fatal(err)
    }
    defer resp.Body.Close()

    return resourceServerRead(d, m)
}

func resourceServerRead(d *schema.ResourceData, m interface{}) error {
    return nil
}

func resourceServerUpdate(d *schema.ResourceData, m interface{}) error {
    return resourceServerRead(d, m)
}

func resourceServerDelete(d *schema.ResourceData, m interface{}) error {
    d.SetId("")
    return nil
}
```

Unser Beispielcode implementiert die Mock-Ressourcenerstellung für den Provider namens „exampleprovider“. In einer tatsächlichen Implementierung muss es für den Providernamen des jeweiligen Cloud- oder On-Premises-Servers geändert werden. 
Die meisten Provider haben API-Aufrufe, die für Ressourcenoperationen wie Erstellen/Aktualisieren/Löschen usw. verwendet werden. Daher müssen wir die Logik von Ressourcenoperationen wie Erstellen und Löschen mithilfe der benutzerdefinierten 
Provider-API-Aufrufe definieren, um die Terraform-Vorlage anzuwenden.

Nachdem Sie die Logik für Ressourcenvorgänge in hinzugefügt haben `resource_server.go`, kann unser benutzerdefinierter Provider getestet werden.

### Erstellen Sie den benutzerdefinierten Providercode

```text
go mod init
go fmt go mod tidy
go build -o terraform-provider-example
```

## Schritte zum Kopieren der ausführbaren Providerdatei in das Plug-in-Verzeichnis

Um den von uns erstellten benutzerdefinierten Provider zu kopieren und zu verwenden, müssen wir die folgende Verzeichnisstruktur im Plug-in-Verzeichnis erstellen:

    Linux-basiertes System -~/.terraform.d/plugins/${host_name}/${namespace}/${type}/${version}/${target}
    Windows-basiertes System%APPDATA%\terraform.d\plugins\${host_name}/${namespace}/${type}/${version}/${target}

Wo:

    host_name-> irgendeinhostname.com
    namespace-> Namensraum des benutzerdefinierten Providers
    Typ-> Benutzerdefinierter Providertyp
    Version-> semantische Versionierung des Providers (Bsp.: 1.0.0)
    Ziel -> Zielbetriebssystem

Unser benutzerdefinierter Provider sollte wie folgt in das Verzeichnis aufgenommen werden:

`~/.terraform.d/plugins/terraform-example.com/exampleprovider/example/1.0.0/linux_amd64/terraform-provider-example`

Als ersten Schritt müssen wir also das Verzeichnis als Teil unserer Provider-Installation erstellen:

`mkdir -p ~/.terraform.d/plugins/terraform-example.com/exampleprovider/example/1.0.0/linux_amd64`

Kopieren Sie dann die terraform-provider-exampleBinärdatei an diesen Ort:

`cp terraform-provider-example ~/.terraform.d/plugins/terraform-example.com/exampleprovider/example/1.0.0/linux_amd64`

## Erstellen Sie Terraform- .tf Dateien

Lassen Sie uns den Provider testen , indem wir main.tf, indem wir die Ressourceneingaben bereitstellen, erstellen. Wir haben die Anzahl der Serverzähler ( uuid_count) als Eingabeparameter für Demozwecke hinzugefügt.

### main.tf

Erstellen Sie main.tfeine Datei mit Code, um eine benutzerdefinierte Providerressource zu erstellen:

```text
resource "example_server" "my-server-name" {
    uuid_count = "1"
}
```

### version.tf

Erstellen Sie eine Datei mit dem Namen versions.tfund fügen Sie den Pfad zum Namen und zur Version des benutzerdefinierten Providers hinzu:

```text
terraform {
    required_providers {
        example = {
            version = "~> 1.0.0"
            source  = "terraform-example.com/exampleprovider/example"
        }
    }
}
```

## Testen Sie den Provider und geben Sie Werte aus

Führen Sie die folgenden Terraform-Befehle aus, um die von uns hinzugefügten benutzerdefinierten Providerfunktionen zu überprüfen.
Terraform-Initialisierung

Wenn wir terraform initden Befehl ausführen, ruft der Terraform-Kern das Provider-Plugin aus dem lokalen Pfad ab, da wir den Provider in der versions.tfDatei konfiguriert haben.
Während der Terraform-Initialisierung wurde der benutzerdefinierte Provider im `~/.terraform.d/plugin-cache` Verzeichnis zwischengespeichert, um den Provider bei der nächsten Ausführung wiederzuverwenden.

```text
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding terraform-example.com/exampleprovider/example versions matching "~> 1.0.0"...
- Using terraform-example.com/exampleprovider/example v1.0.0 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```text
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
+ create

Terraform will perform the following actions:

# example_server.my-server-name will be created
+ resource "example_server" "my-server-name" {
    + id         = (known after apply)
    + uuid_count = "1"
      }

Plan: 1 to add, 0 to change, 0 to destroy.
```

```text
$ terraform apply
Terraform will perform the following actions:

# example_server.my-server-name will be created
+ resource "example_server" "my-server-name" {
    + id         = (known after apply)
    + uuid_count = "1"
      }

Plan: 1 to add, 0 to change, 0 to destroy.
example_server.my-server-name: Creating...
example_server.my-server-name: Creation complete after 0s [id=1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Aufräumen

```text
$ terraform destroy 
Terraform will perform the following actions:

# example_server.my-server-name will be destroyed
- resource "example_server" "my-server-name" {
    - id         = "1" -> null
    - uuid_count = "1" -> null
      }

Plan: 0 to add, 0 to change, 1 to destroy.
example_server.my-server-name: Destroying... [id=1]
example_server.my-server-name: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

## Fazit

In diesem technischen Blogbeitrag haben wir die folgenden Themen behandelt:

    Funktionsweise des Terraform-Providers.
    Was ist ein benutzerdefinierter Terraform-Provider?
    Schritte zum Erstellen und Erstellen eines Beispiel-Terraform-Providers.
    Schritte zur Verwendung des benutzerdefinierten Providers.
    Was beim Aufrufen der Terraform-CLI-Befehle passiert.
