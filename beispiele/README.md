# Beispiele für die Codestruktur

## Terraform-Codestrukturen

{% hint style="info" %}
Diese Beispiele zeigen AWS-Anbieter, aber die meisten der in den Beispielen gezeigten Prinzipien können auf andere öffentliche Cloud-Anbieter sowie andere Arten von Anbietern angewendet werden \(DNS, DB, Überwachung usw.\).
{% endhint %}

| Typ | Beschreibung | Bereitschaft |
| :--- | :--- | :--- |
| [small](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/cf49ff6b7c43b588321f54c01d131284df0a71ed/beispiele/terraform/small-size-infrastructure.md) | Wenig Ressourcen, keine externen Abhängigkeiten. Einzelnes AWS-Konto. Einzelne Region. Einzelne Umgebung. | Ja |
| [medium](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/cf49ff6b7c43b588321f54c01d131284df0a71ed/beispiele/terraform/medium-size-infrastructure.md) | Mehrere AWS-Konten und -Umgebungen, Standard-Infrastrukturmodule mit Terraform. | Ja |
| [groß](https://github.com/elastic2ls-awiechert/terraform-in-der-praxis/tree/cf49ff6b7c43b588321f54c01d131284df0a71ed/beispiele/terraform/große-infrastruktur-mit-terraform.md) | Viele AWS-Konten, viele Regionen müssen dringend das Kopieren und Einfügen, benutzerdefinierte Infrastrukturmodule und die starke Nutzung von Kompositionen reduzieren. Verwenden von Terraform. | WIP |
| sehr groß | Mehrere Anbieter \(AWS, GCP, Azure\). Multi-Cloud-Bereitstellungen. Verwenden von Terraform. | Nein |

## Terragrunt-Codestrukturen

| Typ | Beschreibung | Bereitschaft |
| :--- | :--- | :--- |
| mittel | Mehrere AWS-Konten und -Umgebungen, Standard-Infrastrukturmodule, Kompositionsmuster mit Terragrunt. | Nein |
| groß | Viele AWS-Konten, viele Regionen müssen dringend das Kopieren und Einfügen, benutzerdefinierte Infrastrukturmodule und die starke Nutzung von Kompositionen reduzieren. Terragrunt verwenden. | Nein |
| sehr groß | Mehrere Anbieter \(AWS, GCP, Azure\). Multi-Cloud-Bereitstellungen. Terragrunt verwenden. | Nein |

