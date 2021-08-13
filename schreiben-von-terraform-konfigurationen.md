# Schreiben von Terraform-Konfigurationen

## Verwenden Sie `locals`, um explizite Abhängigkeiten zwischen Ressourcen anzugeben

Hilfreiche Möglichkeit, Terraform einen Hinweis zu geben, dass einige Ressourcen vorher gelöscht werden sollten, selbst wenn keine direkte Abhängigkeit in Terraform-Konfigurationen besteht.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/%20locals.tf)

## Terraform 0.12 - Erforderliche vs. optionale Argumente

1. Erforderliches Argument `index_document` muss gesetzt werden, wenn `var.website` keine leere Map ist.
2. Das optionale Argument `error_document` kann weggelassen werden.

main.tf:

```text
Variable "Website" {
  Typ = Karte (Zeichenfolge)
  Standard = {}
}

Ressource "aws_s3_bucket" "this" {
  # weggelassen...

  dynamische "Website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    Inhalt {
      index_document = website.value.index_document
      error_document = lookup(website.value, "error_document", null)
    }
  }
}
```

terraform.tfvars:

```text
Webseite = {
  index_document = "index.html"
}
```

