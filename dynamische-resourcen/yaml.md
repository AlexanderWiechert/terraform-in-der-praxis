---
layout: home
title: Dynamische aus Yaml Dateien erstellen
subtitle: Was tun, wenn man Ressourcen dynamisch erstellen muss?
---

# Beispiele

Nehmen wir an wir wollen Route53 Zonen und dazugehörige Records anlegen. Wir könnten nun alle Einträge nacheinander in eine `route53.tf`eintragen. Da wir aber versuchen nach dem `DRY`Prinzip zu arbeiten müssen wir uns nach anderen Lösungen umschauen.

## Die Yaml Struktur.
Grundsätzlich bietet sich die Möglichkeit an Variablen aus Yaml Dateien auszulesen. Json funktioniert selbstverständlich auch. Wir haben uns eine Map mit Objekten angelegt, die wir in Keys `apex_name` und Values `records` unterteilt haben. Damit ordnen wir die Subdomains immer eine Apex Domain zu.

```
source_domains:
  - apex_name: elastic2ls.com
    records:
      - elastic2ls.com
      - www.elastic2ls.com
  - apex_name: elastic2ls.ch
    records:
    - elastic2ls.ch
    - www.elastic2ls.ch
    - image.elastic2ls.ch
    - m.elastic2ls.ch
    - static.elastic2ls.ch
```

### Route53
Wir wollen nun zwei Route53 Zonen sowie die Subdomains als A Records mit jeweils einer IPv4 Adresse anlegen.

```
locals {
  zone_records = flatten([
    for d in var.source_domains : [
      for r in d.records : {
        zone_name = d.apex_name
        zone_id   = aws_route53_zone.this[d.apex_name].id
        record    = r
      }
    ]
  ])
}

resource "aws_route53_zone" "this" {
  for_each = {
    for d in var.source_domains : d.apex_name => d
  }

  name = each.value.apex_name
}

resource "aws_route53_record" "this" {
  for_each = {
    for zr in local.zone_records : zr.record => zr
  }

  zone_id = each.value.zone_id
  name    = each.value.record
  type    = "A"
  ttl     = "300"
  records = ["192.168.0.1"]
}
```
