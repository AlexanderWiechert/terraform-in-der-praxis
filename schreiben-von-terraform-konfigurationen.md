# Schreiben von Terraform-Konfigurationen

## Verwenden Sie `locals`, um explizite Abhängigkeiten zwischen Ressourcen anzugeben

Hilfreiche Möglichkeit, Terraform einen Hinweis zu geben, dass einige Ressourcen vorher gelöscht werden sollten, selbst wenn keine direkte Abhängigkeit in Terraform-Konfigurationen besteht.

[locals.tf](/snippets/locals.tf)

## Terraform 0.12 - Erforderliche vs. optionale Argumente

1. Erforderliches Argument `index_document` muss gesetzt werden, wenn `var.website` keine leere Map ist.
2. Das optionale Argument `error_document` kann weggelassen werden.

main.tf:

```text
variable "website" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "this" {
  # omitted...

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    content {
      index_document = website.value.index_document
      error_document = lookup(website.value, "error_document", null)
    }
  }
}
```

terraform.tfvars:

```text
website = {
  index_document = "index.html"
}
```
