---
layout: home
title: If/ Else-Anweisungen in Terraform
subtitle: Was tun, wenn man resourcen dynamisch erstellen muss?
---

If/ Else-Anweisungen sind bedingte Anweisungen, die Entscheidungen basierend auf einem bekannten Zustand oder einer bekannten Variable treffen.

Mit Terraform können Sie diese if/else-Anweisungen mithilfe von a ausführen, ternary operationdie in vielen Programmiersprachen als if/else-Anweisungen in Kurzform beliebt geworden sind.

Wo eine Sprache etwas Ähnliches schreiben würde wie:
```
let truthy = false
if (something == "value") {
  truthy = true
} else {
  truthy = false
}
```

Die ternäre Alternative wäre:
```
let truthy = something == "value" ? true : false
```

Oder noch vereinfachter:
```
let truthy = something == "value"
```

## If/Else in Terraform – Verwendung eines Ternärs

Da Terraform nur die Möglichkeit bietet, ein Ternär zu verwenden, könnte Folgendes verwendet werden:
```
vpc_config {
  subnet_ids = (var.env == "dev") ? [data.aws_subnets.devsubnets.ids[0]] : [data.aws_subnets.prodsubnets.ids[0]]
}
```
Sie können es besser lesbar machen, indem Sie es in mehrere Zeilen aufteilen.

Beachten Sie, dass Sie zum Hinzufügen eines mehrzeiligen Ternärs die Anweisung in Klammern setzen müssen(...)
```
vpc_config {
  subnet_ids = (
    (var.env == "dev") ?
    [data.aws_subnets.devsubnets.ids[0]] :
    [data.aws_subnets.prodsubnets.ids[0]]
  )
}
```
## Hinzufügen mehrerer If/Else-Anweisungen in einem einzigen Block
Das oben Gesagte funktioniert gut, wenn Sie eine einzelne Bedingung haben. Wenn Sie jedoch mehrere Bedingungen benötigen, müssen Sie Folgendes tun:

```
vpc_config {
  subnet_ids = (
    (var.env == "dev") ?
      [data.aws_subnets.devsubnets.ids[0]] :
    (var.env == "uat" ?
      [data.aws_subnets.uatsubnets.ids[0]] :
      [data.aws_subnets.prodsubnets.ids[0]]
    )
  )
}
```