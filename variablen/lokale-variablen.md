---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

# Lokale Variablen
Lokale Variablen werden im Locals-Block eingerichtet und bilden eine Sammlung von Schlüssel-Wert-Zuordnungen, die innerhalb der Konfiguration anwendbar sind. Diese Werte können entweder explizit definiert oder mit anderen Variablen oder Ressourcen verknüpft werden.
Lokale Variablen sind ausschließlich innerhalb des Moduls oder der Konfiguration ihrer Deklaration zugänglich und erleichtern die Organisation und Wiederverwendbarkeit. Betrachten wir zur Veranschaulichung die Erstellung einer EC2-Instanzkonfiguration unter Verwendung lokaler Variablen. Dieser Konfigurationsausschnitt kann einer Datei namens main.tf hinzugefügt werden.
```
locals {
  ami  = "ami-0d26eb3972b7f8c96"
  type = "t2.micro"
  tags = {
    Name = "Development"
    Env  = "Dev"
  }
  subnet = "subnet-76a8163a"
}

resource "aws_instance" "this" {
  ami           = local.ami
  instance_type = local.type
  tags          = local.tags

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }
}

resource "aws_network_interface" "this" {
  description = "Development"
  subnet_id   = local.subnet

  tags = {
    Name = "Development"
  }
}
```
In dieser Abbildung finden alle lokalen Variablen ihre Deklaration im Locals-Block. Diese Variablen umfassen die AMI-ID (ami), den Instanztyp (type), die Subnetz-ID (subnet), die Netzwerkschnittstelle (nic) und die festgelegten Tags (Tags) für die angegebene EC2-Instanz.
### Notiz:

* Die Verwendung des lokalen Schlüsselworts (ohne das „s“), um auf diese lokalen Variablen zu verweisen.
* Versuchen Sie als Best Practice, die Anzahl lokaler Variablen auf ein Minimum zu beschränken. Die Verwendung vieler lokaler Variablen kann die Lesbarkeit des Codes erschweren.
