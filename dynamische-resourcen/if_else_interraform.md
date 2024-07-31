#If/Else in Terraform – Verwendung eines Ternärs


Mit Terraform können Sie diese if/else-Anweisungen mithilfe von [ternary operations](https://en.wikipedia.org/wiki/Ternary_operation) ausführen, 
die in vielen Programmiersprachen als if/else-Anweisungen in Kurzform beliebt sind.

Da Terraform nur die Möglichkeit bietet, ein Ternär zu verwenden, könnte Folgendes verwendet werden:

```hcl
vpc_config {
  subnet_ids = (var.env == "dev") ? [data.aws_subnets.devsubnets.ids[0]] : [data.aws_subnets.prodsubnets.ids[0]]
}
```

Sie können es besser lesbar machen, indem Sie es in mehrere Zeilen aufteilen. Beachten Sie, dass Sie zum Hinzufügen eines mehrzeiligen Ternärs die Anweisung in Klammern setzen müssen(...)

```hcl
vpc_config {
  subnet_ids = (
    (var.env == "dev") ?
    [data.aws_subnets.devsubnets.ids[0]] :
    [data.aws_subnets.prodsubnets.ids[0]]
  )
}
```

## Mehrere If/Else-Anweisungen in einem einzigen Block
Das oben Gesagte funktioniert gut, wenn Sie eine einzelne Bedingung haben. Wenn Sie jedoch mehrere Bedingungen benötigen, müssen Sie Folgendes tun:

```hcl
vpc_config {
  subnet_ids = (var.env == "dev") ? [data.aws_subnets.devsubnets.ids[0]] : (var.env == "uat" ? [data.aws_subnets.uatsubnets.ids[0]] : [data.aws_subnets.prodsubnets.ids[0]] )
}
```

oder mehrzeilig:

```hcl
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