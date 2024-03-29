---
layout: home
title: Beispiele für die Codestruktur
---

## Terraform-Codestrukturen

>Diese Beispiele zeigen AWS-Anbieter, aber die meisten der in den Beispielen gezeigten Prinzipien können auf andere öffentliche Cloud-Anbieter sowie andere Arten von Anbietern angewendet werden \(DNS, DB, Überwachung usw.\).


| Typ | Beschreibung |
| :--- | :--- |
| [klein](terraform/kleine-infrastrukturtitle) | Wenig Ressourcen, keine externen Abhängigkeiten. Einzelnes AWS-Konto. Einzelne Region. Einzelne Umgebung. |
| [mittel](terraform/mittlere-infrastrukturtitle) | Mehrere AWS-Konten und -Umgebungen, Standard-Infrastrukturmodule mit Terraform. |
| [groß](terraform/grosse-infrastrukturtitle) | Viele AWS-Konten, viele Regionen müssen dringend das Kopieren und Einfügen, benutzerdefinierte Infrastrukturmodule und die starke Nutzung von Kompositionen reduzieren. Verwenden von Terraform. |
| sehr groß | Mehrere Anbieter \(AWS, GCP, Azure\). Multi-Cloud-Bereitstellungen. Verwenden von Terraform. |

## Terragrunt-Codestrukturen

| Typ | Beschreibung |
| :--- | :--- |
| mittel | Mehrere AWS-Konten und -Umgebungen, Standard-Infrastrukturmodule, Kompositionsmuster mit Terragrunt. |
| groß | Viele AWS-Konten, viele Regionen müssen dringend das Kopieren und Einfügen, benutzerdefinierte Infrastrukturmodule und die starke Nutzung von Kompositionen reduzieren. Terragrunt verwenden. |
| sehr groß | Mehrere Anbieter \(AWS, GCP, Azure\). Multi-Cloud-Bereitstellungen. Terragrunt verwenden. |

