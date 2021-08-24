---
description: >-
  Die offizielle Terraform-Dokumentation beschreibt alle Aspekte der
  Konfiguration im Detail. Lesen Sie es sorgfältig durch, um den Rest dieses
  Abschnitts zu verstehen.
---

# Schlüsselkonzepte

Die offizielle Terraform-Dokumentation beschreibt [alle Aspekte der Konfiguration im Detail](https://www.terraform.io/docs/configuration/index.html). Lesen Sie es sorgfältig durch, um den Rest dieses Abschnitts zu verstehen. In diesem Abschnitt werden Schlüsselkonzepte beschrieben, die im Buch verwendet werden.

## Module und Strukturierung

{% hint style="info" %}
Zerlegen und abstrahieren Sie Ihren terraform Code, um die Wiederverwendung zu maximieren.
{% endhint %}

| Typ | Beschreibung |
| :--- | :--- |
| [Resourcen](resource.md) | Ein Terraform Ressource ist z.B. `aws_vpc`, `aws_db_instance` usw. |
| [Datenquellen](datenquelle.md) | Mehrere AWS-Konten und -Umgebungen, Standard-Infrastrukturmodule mit Terraform. |
| [Ressourcenmodule](ressourcenmodule.md) | Das Ressourcenmodul ist eine Sammlung verbundener Ressourcen, die zusammen eine gemeinsame Aktion ausführen. |
| [Infrastrukturmodule](infrastrukturmodule.md) | Infrastrukturmodul ist eine Sammlung von Ressourcenmodulen, die logischerweise nicht verbunden werden können, aber in der aktuellen Situation/Projekt/Setup denselben Zweck erfüllen. |
| [Komposition](kompositionen.md) | Kompositionen sind eine Sammlung von Infrastrukturmodulen, die sich über mehrere logisch getrennte Bereiche erstrecken kann. |

Wie jedes andere Framework kann auch Terraform-Code schlecht oder gut geschrieben sein. Schlecht geschriebener Infrastruktur-Code ist langsam, fehleranfällig und schwer zu warten. Viele der Grundsätze, die einem guten Anwendungscode zugrunde liegen, gelten auch für den Infrastrukturcode. Konzepte wie [DRY](http://c2.com/cgi/wiki?DontRepeatYourself), das [Single Responsibility Principle](https://codeburst.io/understanding-solid-principles-single-responsibility-b7c7ec0bf80) und [YAGNI](https://martinfowler.com/bliki/Yagni.html) gelten für Terraform-Code genauso wie für traditionellen Anwendungscode. Um einen guten Entwurf zu erleichtern, können Sie mit Terraform Ihre Infrastruktur in Module aufteilen, d.h. in atomare Infrastrukturkomponenten, die klar definierte Inputs und Outputs haben. Sie können diese Module verwenden, um wiederverwendbare Komponenten zu erstellen, die auf Ihre Anwendungsimplementierung zugeschnitten sind, und dann diese Komponenten verwenden, um eine Darstellung Ihrer Infrastruktur zu erstellen, die wiederverwendbar und leicht wartbar ist.

{% hint style="info" %}
Ein Beispiel: Sie haben eine Anwendung, die einen S3-Bucket, eine RDS-Instanz und eine EC2-Instanz verwendet. Eine geeignete Darstellung in Terraform wäre die Erstellung separater Module, die den S3-Bucket, die RDS-Instanz und die EC2-Instanz darstellen. Dann erstellen Sie ein weiteres Modul, das jedes dieser Module nutzt, um die Anwendung zu repräsentieren; dieses letzte Modul würde in der eigentlichen Logik der Umgebungsbereitstellung referenziert werden. Mit einer mehrstufigen Darstellung wie dieser können Sie die grundlegenden Ressourcenmodule für andere Anwendungen und die vollständig komponierten Anwendungsmodule für mehrere Umgebungen wiederverwenden.
{% endhint %}

### Halten Sie Ihre Module und Ihren Umgebungsimplementierungscode getrennt.

Sie sollten nicht nur Ihre Logik in Module aufteilen und einen separaten Status pro Umgebung und Anwendung aufrechterhalten, sondern auch den Terraform-Modulcode und den Terraform-Bereitstellungscode an separaten Stellen aufteilen. Im Allgemeinen tun wir dies, indem wir Module in ihrem eigenen Git Repository pflegen und für jede Anwendung, die wir bereitstellen müssen, ein eigenes Git Repository unterhalten. Dies erleichtert die Wiederverwendung und Zusammenarbeit, da Sie Ihre Modulbibliothek getrennt von Ihrem umgebungsspezifischen Code pflegen können.

