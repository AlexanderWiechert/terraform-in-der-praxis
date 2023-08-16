---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

# Eingabevariablen
* Die Eingabevariablen von Terraform erleichtern die Bereitstellung externer Werte in Konfigurationen oder Modulen und ermöglichen so eine dynamische Zuweisung zu Ressourcenattributen.
* Im Gegensatz zu lokalen Variablen ermöglichen Eingabevariablen die Übergabe von Werten vor der Ausführung.

**Darüber hinaus können bei der Einführung von Eingabevariablen bestimmte Attribute bei der Deklaration konfiguriert werden, wie unten gezeigt:**

**type:** Gibt den Datentyp der Variablen an.

**default:** Legt einen Standardwert fest, wenn kein expliziter Wert angegeben wird.

**description:** Bietet eine Variablenbeschreibung, die gleichzeitig als Dokumentation für die Modulreferenz dient.

**validation:** Ermöglicht die Festlegung von Validierungskriterien.

**sensitive:** Ein boolescher Parameter. Bei der Einstellung „true“ verbirgt Terraform den Wert der Variablen in allen Anzeigen.

> Eingabevariablen zeichnen sich durch ihre Vielseitigkeit bei der Aufnahme verschiedener Datentypen aus, die in einfache und komplexe Typen kategorisiert werden. Zu den ersteren gehören string, number und bool, während letztere Liste, Karte, Tupel, Objekt und Menge umfassen.

**Die folgenden Snippets enthalten Beispiele für jeden der von uns aufgeführten Typen.**

## String-Typ
Die Eingabevariablen vom Typ String werden verwendet, um Werte in Form von UNICODE-Zeichen zu akzeptieren.
```
variable "string_type" {
  description = "This variable is of type string"
  type        = string
  default     = "Default string type"
}
```
Es gibt einen anderen Typ unter string, nämlich das Format im Heredoc-Stil.
```
variable "string_type" {
  description = "This variable is of type string"
  type        = string
  default     = <<EOF
"Weitergehen, weitergehen!... Bitte gehen Sie weiter! 
Es gibt nicht das geringste zu sehen, Leute!
EOF
}
```

## Number-Typ
Die Eingabevariable vom Typ „Number“ ermöglicht es uns, numerische Werte als Eingaben für ihre Infrastrukturbereitstellungen zu definieren und zu akzeptieren.

> Diese numerischen Werte helfen beispielsweise dabei, die bevorzugte Anzahl von Instanzen festzulegen, die innerhalb einer Autoskalierungsgruppe generiert werden sollen.
```
variable "number_type" {
  description = "Ich glaube, das Problem ist, um ganz ehrlich zu sein, dass Sie nie wirklich wissen, was die Frage ist."
  type        = number
  default     = 42
}
```

## Boolescher-Typ
Die Eingabevariable vom booleschen Typ wird verwendet, um Wahr/Falsch-Werte als Eingaben für Infrastrukturbereitstellungen zu definieren und zu akzeptieren, um Logik und bedingte Anweisungen in die Terraform-Konfigurationen zu integrieren.

> Beispielsweise dienen boolesche Eingabevariablen als wertvolles Werkzeug zum Umschalten bestimmter Funktionen oder Verhaltensweisen innerhalb von Infrastrukturbereitstellungen.
```
variable "boolean_type" {
  description = "This variable is of type boolean"
  type        = bool
  default     = true
}
```

## Listen-Typ
Mit Terraform-Listenvariablen können Sie eine Sammlung von Werten als Eingaben für Infrastrukturbereitstellungen definieren und akzeptieren.

> Eingabevariablen des Listentyps erweisen sich als besonders vorteilhaft, wenn es um Situationen geht, die mehrere Instanzen desselben Datentyps erfordern. Dabei kann es sich um ein Array von IP-Adressen, eine Gruppierung von Ports oder eine Zusammenstellung von Ressourcennamen handeln.

```
variable "list_type" {
  description = "This variable is of type list"
  type        = list(string)
  default     = ["ip1", "ip2", "ip3"]
}
```

## Map-Typ
Die Eingabevariable vom Typ Map ermöglicht es uns, eine Sammlung von Schlüssel-Wert-Paaren als Eingaben für unsere Infrastrukturbereitstellungen zu definieren und zu akzeptieren.

> Beispielsweise kann eine Map bei der Definition von Ressourcen-Tags, umgebungsspezifischen Konfigurationen oder modulspezifischen Parametern nützlich sein.
```
variable "map_type" {
  description = "This variable is of type map"
  type        = map(string)
  default     = {
    key1 = "value1"
    key2 = "value2"
  }
}
```

## Objekt-Typ
Ein Objekt stellt eine komplexe Datenstruktur dar, die aus mehreren Schlüssel-Wert-Paaren besteht, wobei jeder Schlüssel einem bestimmten Datentyp für seinen entsprechenden Wert zugeordnet ist.

> Beispielsweise wird ein Objekt verwendet, um eine Sammlung von Parametern für die Konfiguration eines Servers zu skizzieren.
```
variable "object_type" {
  description = "This variable is of type object"
  type        = object({
    name    = string
    age     = number
    enabled = bool
  })
  default = {
    name    = "Yoda"
    age     = 900
    enabled = true
  }
}
```

## Tupel-Typ
Ein Tupel stellt eine Sammlung vorgegebener Länge dar, die verschiedene Datentypen aufnehmen kann. Der Hauptunterschied zwischen Tupeln und Listen liegt in:

> * Tupel besitzen eine feste Länge, Listen dagegen nicht.
> * Tupel ermöglichen die Einbeziehung unterschiedlicher primitiver Typen, wohingegen Listen einen einheitlichen Typ für alle Elemente erfordern.
>* Werte innerhalb von Tupeln behalten eine bestimmte Reihenfolge bei, während Listen aufgrund ihrer dynamischen Natur eine Größenänderung und Neuanordnung von Werten ermöglichen.
```
variable "tuple_type" {
  description = "This variable is of type tuple"
  type        = tuple([string, number, bool])
  default     = ["Yoda", 900, true]
}
```

## Set-Typ
Ein Set stellt eine unorganisierte Ansammlung eindeutiger Werte dar und stellt sicher, dass jedes Element darin nur einmal vorkommt. Im Gegensatz zu Listen achten Sets strikt auf die Eindeutigkeit und lassen jedes Element nur einmal vorkommen. Sets ermöglichen mehrere integrierte Operationen wie Vereinigung, Schnittmenge und Differenz und ermöglichen so die Zusammenführung oder den Vergleich von Sets.
```
variable "set_example" {
  description = "This variable is of type set"
  type        = set(string)
  default     = ["item1", "item2", "item3"]
}
```

## Map of object-Typ
Einer der am häufigsten verwendeten komplexen Eingabevariablentypen ist Map(Object). Es handelt sich um einen Datentyp, der eine Map darstellt, bei der jeder Schlüssel einem Objektwert zugeordnet ist.

Eine Demonstration dieses Konzepts wird unten dargestellt, wobei eine Map von Objekten Attributwerte beschreibt, die bei der Generierung zahlreicher Subnetze verwendet werden.
```
variable "map_of_objects" {
  description = "This is a variable of type Map of objects"
  type = map(object({
    name = string,
    cidr = string
  }))
  default = {
    "subnet_a" = {
      name = "Subnet A",
      cidr = "10.10.10.0/24"
    },
    "subnet_b" = {
      name = "Subnet B",
      cidr = "10.10.20.0/24"
    },
    "subnet_c" = {
      name = "Subnet C",
      cidr = "10.10.30.0/24"
    }
  }
}
```

## Beispiel für Terraform-Eingabevariablen
Nachdem wir die EC2-Instanz mithilfe lokaler Variablen erfolgreich eingerichtet haben, werden wir sie nun mithilfe von Eingabevariablen generieren. Der entsprechende Code wird in der Datei **vars.tf** dokumentiert .
```
variable "ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0f37eb4982b3g5h34"

  validation {
    condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
    error_message = "Please provide a valid value for variable AMI."
  }
}

variable "type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
  sensitive   = true
}

variable "tags" {
  type = object({
    name = string
    env  = string
  })
  description = "Tags for the EC2 instance"
  default = {
    name = "Development machine"
    env  = "Dev"
  }
}

variable "subnet" {
  type        = string
  description = "Subnet ID for development network interface"
  default     = "subnet-76a8163a"
}
```  

So schaut nun **main.tf** aus.

```
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.type
  tags          = var.tags

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }
}

resource "aws_network_interface" "this" {
  description = "Dev instance NIC"
  subnet_id   = var.subnet

  tags = {
    Name = "development"
  }
}
```