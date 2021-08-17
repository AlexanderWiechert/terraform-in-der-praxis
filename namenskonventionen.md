# Namenskonventionen

## Allgemeine Konventionen

{% hint style="info" %}
Es sollte keinen Grund geben, diesen nicht zu folgen.
{% endhint %}

1. Verwenden Sie `_` \(Unterstrich\) anstelle von `-` \(Bindestrich\) in allen: Ressourcennamen, Datenquellennamen, Variablennamen, Ausgaben.
   * Beachten Sie, dass tatsächliche Cloud-Ressourcen viele versteckte Einschränkungen in ihren Namenskonventionen aufweisen. Einige dürfen keine Bindestriche enthalten, andere müssen am Anfang gross geschrieben werden. Diese Konventionen beziehen sich auf den Namen von Terraform Ressourcen.
2. Verwenden Sie nur Kleinbuchstaben und Zahlen.

## Argumente für Ressourcen und Datenquellen

1. Ressourcentyp im Ressourcennamen nicht wiederholen:
   * Gut: `Ressource "aws_route_table" "public" {}`
   * Schlecht: `Ressource "aws_route_table" "public_route_table" {}`
   * Schlecht: `Ressource "aws_route_table" "public_aws_route_table" {}`
2. Der Ressourcenname sollte `this` heißen, wenn kein beschreibender und allgemeiner Name mehr verfügbar ist oder wenn das Ressourcenmodul eine einzelne Ressource dieses Typs erstellt \(z.B. gibt es eine einzelne Ressource des Typs `aws_nat_gateway` und mehrere Ressourcen des Typs`aws_route_table`, also sollte `aws_nat_gateway` `this` heißen und `aws_route_table` sollte aussagekräftigere Namen haben - wie `private`, `public`, `database`\).
3. Verwenden Sie für Namen immer Nomen im Singular.
4. Verwenden Sie `-` innerhalb von Argument und an Stellen, an denen der Wert für Andere lesbar sein soll \(z.B. innerhalb des DNS-Namens der RDS-Instanz\).
5. Fügen Sie das Argument `count` in Ressourcenblöcke als erstes Argument oben ein und trennen Sie es durch einen Zeilenumbruch dahinter. Siehe [Beispiel](#verwendung-von-count verwendung-von-count "verwendung-von-count verwendung-von-count").
6. Fügen Sie die Kondition `tags` als letztes Argument ein, wenn es von der Ressource unterstützt wird, gefolgt von `depends_on` und `lifecycle`, falls erforderlich. All dies sollte durch eine einzelne Leerzeile getrennt werden. Siehe [Beispiel](#platzierung-von-tags "platzierung-von-tags").
7. Wenn Bedingung im `count`-Argument verwendet wird, verwenden Sie einen booleschen Wert, wenn dies sinnvoll ist, andernfalls verwenden Sie `length` oder eine andere Interpolation. Siehe [Beispiel ](#bedingungen-in-count "bedingungen-in-count").
8. Um invertierte Bedingungen zu erstellen, führen Sie keine andere Variable ein, es sei denn, es ist wirklich notwendig, sondern verwenden stattdessen `1 - boolescher Wert`. Zum Beispiel `count = "${1 - var.create_public_subnets}"`

## Codebeispiele für `Ressource`

### Verwendung von `count`

{% hint style="info" %}

```text
Ressource "aws_route_table" "public" {
  count = "2"

  vpc_id = "vpc-12345678"
  # ... verbleibende Argumente weggelassen
}
```

{% hint style="danger" %}

```text
Ressource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count = "2"

  # ... verbleibende Argumente weggelassen
}
```

### Platzierung von `Tags`

{% hint style="info" %}

```text
Ressource "aws_nat_gateway" "this" {
  count = "1"

  allocation_ids = "..."
  subnet_id = "..."

  Tags = {
    Name = "..."
  }

  depends_on = ["aws_internet_gateway.this"]

  lifecycle {
    create_before_destroy = true
  }
}
```

{% hint style="danger" %}

```text
Ressource "aws_nat_gateway" "this" {
  count = "1"

  Tags = "..."

  depends_on = ["aws_internet_gateway.this"]

  lifecycle {
    create_before_destroy = true
  }

  allokation_id = "..."
  subnet_id = "..."
}
```

### Bedingungen in `count`

{% hint style="info" %}
 ```text
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"
  ```
 ```text
  count = "${var.create_public_subnets}"
  ```
{% endhint %}

## Variablen

1. Erfinden Sie das Rad in Ressourcenmodulen nicht neu – verwenden Sie dieselben Variablennamen, Beschreibungen und Voreinstellungen wie im Abschnitt "Argumentreferenz" für die Ressource, an der Sie arbeiten.
2. Lassen Sie die `type = "list"`-Deklaration weg, wenn es auch `default = []` gibt.
3. Lassen Sie die Deklaration `type = "map"` weg, wenn es auch `default = {}` gibt.
4. Verwenden Sie die Pluralform im Namen von Variablen vom Typ `list` und `map`.
5. Beim Definieren von Variablen ordnen Sie die Schlüssel: `description` , `type`, `default` .
6. Fügen Sie für alle Variablen immer eine `Beschreibung` hinzu, auch wenn Sie denken, dass es offensichtlich ist.

## Outputs

Der Name für die Outputs ist wichtig, um sie außerhalb ihres Geltungsbereichs konsistent und verständlich zu machen \(wenn der Benutzer ein Modul verwendet, sollte offensichtlich sein, welcher Typ und welches Attribut des Werts zurückgegeben wird\).

1. Die allgemeine Empfehlung für die Namen von Outputs lautet, dass sie für den darin enthaltenen Wert beschreiben.
2. Eine gute Struktur für Ausgabenamen sieht wie folgt aus: `{name}_{type}_{attribute}` , wobei:
   1. `{name}` ist ein Ressourcen- oder Datenquellenname ohne Anbieterpräfix. `{name}` für `aws_subnet` ist `subnet`, für`aws_vpc` ist es `vpc`.
   2. `{type}` ist ein Typ einer Ressourcenquelle
   3. `{attribute}` ist ein Attribut, das von der Ausgabe zurückgegeben wird
   4. [Siehe Beispiele](#codebeispiele-fuer-ausgabe "codebeispiele-fuer-ausgabe").
3. Wenn die Ausgabe einen Wert mit Interpolationsfunktionen und mehreren Ressourcen zurückgibt, sollten die `{name}` und `{type}` dort so generisch wie möglich sein \(`this` ist oft die generischste und sollte bevorzugt werden\) . [Siehe Beispiel](#codebeispiele-fuer-ausgabe "codebeispiele-fuer-ausgabe").
4. Wenn der zurückgegebene Wert eine Liste ist, sollte der Name im Plurar stehen. [Siehe Beispiel](#verwenden-sie-pluralnamen-wenn-der-rueckgabewert-eine-liste-ist "verwenden-sie-pluralnamen-wenn-der-rueckgabewert-eine-liste-ist").
5. Geben Sie immer eine `Beschreibung` für alle Ausgaben an, auch wenn Sie denken, dass es offensichtlich ist.

### Codebeispiele für `Output`

Gibt die ID der Sicherheitsgruppe zurück:

{% hint style="info" %}

```text
c "this_security_group_id" {
  description = "Die ID der Sicherheitsgruppe"
  value = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.this_name_prefix.*.id), list("")), 0)}"
}
```

Wenn mehrere Ressourcen des gleichen Typs vorhanden sind, sollte `this` bevorzugt werden und es sollte Teil des Namens in der Ausgabe sein, auch `another_security_group_id` sollte `web_security_group_id` heißen:

{% hint style="danger" %}

```text
output "security_group_id" {
  description = "Die ID der Sicherheitsgruppe"
  value = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), list("")), 0)}"
}

output "another_security_group_id" {
  description = "Die ID der Websicherheitsgruppe"
  value = "${element(concat(aws_security_group.web.*.id, list("")), 0)}"
}
```

### Verwenden Sie Pluralnamen, wenn der Rückgabewert eine Liste ist

{% hint style="info" %}

```text
output "this_rds_cluster_instance_endpoints" {
  description = "Eine Liste aller Endpunkte von Clusterinstanzen"
  Wert = ["${aws_rds_cluster_instance.this.*.endpoint}"]
}
```

### Bedingungen in `Ausgabe`

Es gibt zwei Ressourcen vom Typ `aws_db_instance` mit den Namen `this` und `this_mssql`, bei denen maximal eine Ressource gleichzeitig erstellt werden kann.

{% hint style="info" %}
```text
output "this_db_instance_id" {
  description = "Die RDS-Instanz-ID"
  value = "${element(concat(coalescelist(aws_db_instance.this_mssql.*.id, aws_db_instance.this.*.id), list("")), 0)}"
}
```
{% endhint %}
