---
description: >-
  Was ist eigentlich der Unterschied zwischen einer Variable des Typs Map und Object?
---

# Terraform Map oder Objekt

Bei den Terraform-Variablen Typen gibt es sowohl eine Map als auch einen Typ Objekt, die sich fast gleich verhalten, aber dennoch recht unterschiedlich funktionieren. Was ist eigentlich der Unterschied zwischen beiden?

Sie können auf verschiedene Arten definiert und aufgerufen werden. Es gibt eine automatische Konvertierung zwischen ihnen hin und her.

> Maps können viele Werte desselben Typs enthalten, während Objekte einen fest definierten Satz von unterschiedlichsten Variabletypen enthalten kann.

Dies ist eine starke Vereinfachung und deckt nicht das gesamte Verhalten der Maps und Objekte in Terraform ab.

## Stil

### Schlüsselnamen

Können sowohl in Anführungszeichen gesetzt werden.
```
variable "quoted_map" {
  default = {
    "key_1" = "value_1"
    "key_2" = "value_2"
  }
}
```
Als auch ohne geschrieben werden.

```
variable "unquoted_map" {
  default = {
    key_1 = "value_1"
    key_2 = "value_2"
  }
}
```
Ich persönlich bevorzuge das Format ohne Anführungszeichen. Erstens, weil es weniger fehleranfällig ist und zweitens, weil die Keys hier nur funktionieren, wenn die Schlüsselnamen auch gültiger Bezeichner sind, der Variablen und zugehörigen Werte sind. Das hat u.a. den Vorteil, das unsere Map die gleiche Struktur wie die Terraform Variablen haben muss und wir mittels der gepunktete Notation direkt darauf zugreifen können.

### Kommas

Wir können Schlüssel/Wert-Paare durch Kommas trennen.
```
variable "comma_map" {
  default = {
    key_1 = "value_1",
    key_2 = "value_2",
  }
}
```
Aber das müssen wir nicht.

```
variable "no_comma_map" {
  default = {
    key_1 = "value_1"
    key_2 = "value_2"
  }
}
```

Ich bevorzuge keine Kommas, da es dann weniger fehleranfällig ist.


### Verweise
Sie können Werte nach Attributnamen mit Anführungszeichen und eckigen Klammern referenzieren.

```
output "brackets" {
  value = var.unquoted_map["key_2"]
}
```

Wir können aber auch die gepunktete Notation verwenden.

```
output "dots" {
  value = var.unquoted_map.key_2
}
```

Ich bevorzuge die gepunktete Notation, da die Syntax leichter verständlich ist. Dies erfordert auch, dass die [Schlüsselnamen](#schluesselnamen) Bezeichner sind, aber das stellen wir sicher, in dem wir die Notation ohne Anführungszeichen verwenden.
