# Regeln der Namensgebung

## Allgemeine Konventionen

{% hint style="info" %}
Es sollte keinen Grund geben, zumindest diesen nicht zu folgen :\)
{% endhint %}

1. Verwenden Sie `_` \(Unterstrich\) anstelle von `-` \(Bindestrich\) in allen: Ressourcennamen, Datenquellennamen, Variablennamen, Ausgaben.
  * Beachten Sie, dass tatsächliche Cloud-Ressourcen viele versteckte Einschränkungen in ihren Namenskonventionen aufweisen. Einige dürfen keine Bindestriche enthalten, andere müssen in einer Kamelhülle enthalten sein. Diese Konventionen beziehen sich auf Terraform-Namen selbst.
2. Verwenden Sie nur Kleinbuchstaben und Zahlen.

## Argumente für Ressourcen und Datenquellen

1. Ressourcentyp im Ressourcennamen nicht wiederholen \(nicht teilweise oder vollständig\):
   * Gut: `Ressource "aws_route_table" "public" {}`
   * Schlecht: `Ressource "aws_route_table" "public_route_table" {}`
   * Schlecht: `Ressource "aws_route_table" "public_aws_route_table" {}`
2. Der Ressourcenname sollte `this` heißen, wenn kein beschreibender und allgemeiner Name mehr verfügbar ist oder wenn das Ressourcenmodul eine einzelne Ressource dieses Typs erstellt \(zB gibt es eine einzelne Ressource des Typs `aws_nat_gateway` und mehrere Ressourcen des Typs` aws_route_table`, also sollte `aws_nat_gateway` `this` heißen und `aws_route_table` sollte aussagekräftigere Namen haben - wie `private`, `public`, `database`\).
3. Verwenden Sie für Namen immer Nomen im Singular.
4. Verwenden Sie `-` innerhalb von Argumentwerten und an Stellen, an denen der Wert einem menschlichen \(zB innerhalb des DNS-Namens der RDS-Instanz\) ausgesetzt wird.
5. Fügen Sie das Argument `count` in Ressourcenblöcke als erstes Argument oben ein und trennen Sie es durch einen Zeilenumbruch dahinter. Siehe [Beispiel](naming.md#usage-of-count).
6. Fügen Sie das Argument `tags` als letztes echtes Argument ein, wenn es von der Ressource unterstützt wird, gefolgt von `depends_on` und `lifecycle`, falls erforderlich. All dies sollte durch eine einzelne Leerzeile getrennt werden. Siehe [Beispiel](naming.md#Placement-of-Tags).
7. Wenn Bedingung im `count`-Argument verwendet wird, verwenden Sie einen booleschen Wert, wenn dies sinnvoll ist, andernfalls verwenden Sie `length` oder eine andere Interpolation. Siehe [Beispiel](naming.md#conditions-in-count).
8. Um invertierte Bedingungen zu erstellen, führen Sie keine andere Variable ein, es sei denn, es ist wirklich notwendig, sondern verwenden stattdessen `1 - boolescher Wert`. Zum Beispiel `count = "${1 - var.create_public_subnets}"`

## Codebeispiele für `Ressource`

### Verwendung von `count`

{% hint style="Erfolg" %}
{% Code-Tabs %}
{% code-tabs-item title="main.tf" %}
```Text
Ressource "aws_route_table" "öffentlich" {
  zählen = "2"

  vpc_id = "vpc-12345678"
  # ... verbleibende Argumente weggelassen
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

{% hint style="danger" %}
{% Code-Tabs %}
{% code-tabs-item title="main.tf" %}
```Text
Ressource "aws_route_table" "öffentlich" {
  vpc_id = "vpc-12345678"
  zählen = "2"

  # ... verbleibende Argumente weggelassen
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Platzierung von `Tags`

{% hint style="Erfolg" %}
{% Code-Tabs %}
{% code-tabs-item title="main.tf" %}
```Text
Ressource "aws_nat_gateway" "this" {
  zählen = "1"

  allokation_id = "..."
  subnet_id = "..."

  Tags = {
    Name = "..."
  }

  hängt_on = ["aws_internet_gateway.this"]

  Lebenszyklus {
    create_before_destroy = wahr
  }
}   
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

{% hint style="danger" %}
{% Code-Tabs %}
{% code-tabs-item title="main.tf" %}
```Text
Ressource "aws_nat_gateway" "this" {
  zählen = "1"

  Tags = "..."

  hängt_on = ["aws_internet_gateway.this"]

  Lebenszyklus {
    create_before_destroy = wahr
  }

  allokation_id = "..."
  subnet_id = "..."
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Bedingungen in `count`

{% hint style="Erfolg" %}
* {% Code-Tabs %}
  {% code-tabs-item title="main.tf" %}
  ```Text
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"
  ```
  {% endcode-tabs-item %}
  {% endcode-tabs %}
* {% Code-Tabs %}
  {% code-tabs-item title="main.tf" %}
  ```
  count = "${var.create_public_subnets}"
  ```
  {% endcode-tabs-item %}
  {% endcode-tabs %}
{% endhint %}

##Variablen

1. Erfinden Sie das Rad in Ressourcenmodulen nicht neu – verwenden Sie dieselben Variablennamen, Beschreibungen und Voreinstellungen wie im Abschnitt "Argumentreferenz" für die Ressource, an der Sie arbeiten.
2. Lassen Sie die `type = "list"`-Deklaration weg, wenn es auch `default = []` gibt.
3. Lassen Sie die Deklaration `type = "map"` weg, wenn es auch `default = {}` gibt.
4. Verwenden Sie die Pluralform im Namen von Variablen vom Typ `list` und `map`.
5. Beim Definieren von Variablen ordnen Sie die Schlüssel: `description` , `type`, `default` .
6. Fügen Sie für alle Variablen immer eine `Beschreibung` hinzu, auch wenn Sie denken, dass es offensichtlich ist.

## Ausgänge

Der Name für die Ausgaben ist wichtig, um sie außerhalb ihres Geltungsbereichs konsistent und verständlich zu machen (wenn der Benutzer ein Modul verwendet, sollte offensichtlich sein, welcher Typ und welches Attribut des Werts zurückgegeben wird\).

1. Die allgemeine Empfehlung für die Namen von Ausgaben lautet, dass sie für den darin enthaltenen Wert beschreibend und weniger frei sein sollten, als Sie es normalerweise wünschen würden.
2. Eine gute Struktur für Ausgabenamen sieht wie folgt aus: `{name}_{type}_{attribute}` , wobei:
   1. `{name}` ist ein Ressourcen- oder Datenquellenname ohne Anbieterpräfix. `{name}` für `aws_subnet` ist `subnet`, für`aws_vpc` ist es `vpc`.
   2. `{type}` ist ein Typ einer Ressourcenquelle
   3. `{attribute}` ist ein Attribut, das von der Ausgabe zurückgegeben wird
   4. [Siehe Beispiele](Namensnennung.md#Code-Beispiele-der-Ausgabe).
3. Wenn die Ausgabe einen Wert mit Interpolationsfunktionen und mehreren Ressourcen zurückgibt, sollten die `{name}` und `{type}` dort so generisch wie möglich sein \(`dies` ist oft die generischste und sollte bevorzugt werden\) . [Siehe Beispiel](naming.md#code-examples-of-output).
4. Wenn der zurückgegebene Wert eine Liste ist, sollte er einen Pluralnamen haben. [Siehe Beispiel](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Geben Sie immer `Beschreibung` für alle Ausgaben an, auch wenn Sie denken, dass es offensichtlich ist.

### Codebeispiele für `Ausgabe`

Geben Sie höchstens eine ID der Sicherheitsgruppe zurück:

{% hint style="Erfolg" %}
{% Code-Tabs %}
{% code-tabs-item title="outputs.tf" %}
```Text
Ausgabe "this_security_group_id" {
  description = "Die ID der Sicherheitsgruppe"
  value = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.this_name_prefix.*.id), list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

Wenn mehrere Ressourcen des gleichen Typs vorhanden sind, sollte `this` bevorzugt werden und es sollte Teil des Namens in der Ausgabe sein, auch `another_security_group_id` sollte `web_security_group_id` heißen:

{% hint style="danger" %}
{% Code-Tabs %}
{% code-tabs-item title="outputs.tf" %}
```Text
Ausgabe "security_group_id" {
  description = "Die ID der Sicherheitsgruppe"
  value = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), list("")), 0)}"
}

Ausgabe "another_security_group_id" {
  description = "Die ID der Websicherheitsgruppe"
  value = "${element(concat(aws_security_group.web.*.id, list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Verwenden Sie Pluralnamen, wenn der Rückgabewert eine Liste ist

{% hint style="Erfolg" %}
{% Code-Tabs %}
{% code-tabs-item title="outputs.tf" %}
```Text
Ausgabe "this_rds_cluster_instance_endpoints" {
  description = "Eine Liste aller Endpunkte von Clusterinstanzen"
  Wert = ["${aws_rds_cluster_instance.this.*.endpoint}"]
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Bedingungen in `Ausgabe`

Es gibt zwei Ressourcen vom Typ `aws_db_instance` mit den Namen `this` und `this_mssql`, bei denen maximal eine Ressource gleichzeitig erstellt werden kann.

{% hint style="Erfolg" %}
{% Code-Tabs %}
{% code-tabs-item title="outputs.tf" %}
```Text
Ausgabe "this_db_instance_id" {
  description = "Die RDS-Instanz-ID"
  value = "${element(concat(coalescelist(aws_db_instance.this_mssql.*.id, aws_db_instance.this.*.id), list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

\*\*\*\*
