**for_each** ist ein sehr mächtiges Metaargument in Terraform, das dazu dient, mehrere Instanzen einer Ressource oder eines Moduls auf der Grundlage eines Satzes oder einer Karte von Werten zu erstellen. Jede dieser Instanzen wird als separate Entität betrachtet, was bedeutet, dass Änderungen an einem Element des Satzes oder der Karte nicht notwendigerweise Auswirkungen auf die anderen haben.

Hier sind einige wichtige Punkte und Beispiele zu **for_each**:

**Verwendung als Set of Strings**:

```hcl

resource "aws_instance" "example" {
  for_each = toset(["us-west-1a", "us-west-1b", "us-west-1c"])
  availability_zone = each.value
}
```

In diesem Beispiel wird für jede Zeichenfolge im Set eine AWS-Instanz erstellt. Die aktuelle Zeichenfolge kann mit each.value abgerufen werden.

**Verwendung als Map**:

```hcl
resource "aws_instance" "example" {
  for_each = {
    prod  = "us-west-1a"
    dev   = "us-west-1b"
    stage = "us-west-1c"
  }

  availability_zone = each.value

  # Um den Schlüssel abzurufen (z.B. "prod", "dev", "stage"):
  tags = {
    Name = each.key
  }

  # ... weitere Konfiguration ...
}
```
In diesem Beispiel wird für jeden Eintrag in der Map eine AWS-Instanz erstellt. Der aktuelle Schlüssel kann mit `each.key` und der aktuelle Wert mit `each.value` abgerufen werden.

> **Einzigartigkeit**: Das Schlüssel-Element-Paar in der for_each Karte oder die Werte im Satz müssen eindeutig sein. Andernfalls wird ein Fehler generiert.

> **Zustandsmanagement**: Das Verwenden von `for_each` (oder `count`) beeinflusst, wie Terraform den Zustand der Ressource verwaltet. Anstatt nur den Zustand der Ressource _"aws_instance.example"_ zu speichern, speichert Terraform den Zustand jeder einzelnen Instanz separat, z.B. _"aws_instance.example["prod"]"_.