---
description: >-
  Die offizielle Terraform-Dokumentation beschreibt alle Aspekte der Konfiguration im Detail. Lesen Sie es sorgfältig durch, um den Rest dieses Abschnitts zu verstehen. In diesem Abschnitt werden Schlüsselkonzepte beschrieben, die im Buch verwendet werden.
---

# Schlüsselkonzepte

Die offizielle Terraform-Dokumentation beschreibt [alle Aspekte der Konfiguration im Detail](https://www.terraform.io/docs/configuration/index.html). Lesen Sie es sorgfältig durch, um den Rest dieses Abschnitts zu verstehen. In diesem Abschnitt werden Schlüsselkonzepte beschrieben, die im Buch verwendet werden.

{% hint style="info" %}
Zerlegen und abstrahieren Sie Ihren terraform Code, um die Wiederverwendung zu maximieren.
{% endhint %}

Wie jedes andere Framework kann auch Terraform-Code schlecht oder gut geschrieben sein. Schlecht geschriebener Infrastruktur-Code ist langsam, fehleranfällig und schwer zu warten. Viele der Grundsätze, die einem guten Anwendungscode zugrunde liegen, gelten auch für den Infrastrukturcode. Konzepte wie [DRY](https://www.xtivia.com/blog/cloud/terraform-best-practices/#:~:text=code%3B%20concepts%20like-,DRY,-%2C%20the%20Single%20Responsibility), das [Single Responsibility Principle](https://www.xtivia.com/blog/cloud/terraform-best-practices/#:~:text=Single%20Responsibility%20Principle) und [YAGNI](https://martinfowler.com/bliki/Yagni.html) gelten für Terraform-Code genauso wie für traditionellen Anwendungscode. Um einen guten Entwurf zu erleichtern, können Sie mit Terraform Ihre Infrastruktur in Module aufteilen, d.h. in atomare Infrastrukturkomponenten, die klar definierte Inputs und Outputs haben. Sie können diese Module verwenden, um wiederverwendbare Komponenten zu erstellen, die auf Ihre Anwendungsimplementierung zugeschnitten sind, und dann diese Komponenten verwenden, um eine Darstellung Ihrer Infrastruktur zu erstellen, die wiederverwendbar und leicht wartbar ist.

{% hint style="info" %}
Ein Beispiel: Sie haben eine Anwendung, die einen S3-Bucket, eine RDS-Instanz und eine EC2-Instanz verwendet. Eine geeignete Darstellung in Terraform wäre die Erstellung separater Module, die den S3-Bucket, die RDS-Instanz und die EC2-Instanz darstellen. Dann erstellen Sie ein weiteres Modul, das jedes dieser Module nutzt, um die Anwendung zu repräsentieren; dieses letzte Modul würde in der eigentlichen Logik der Umgebungsbereitstellung referenziert werden. Mit einer mehrstufigen Darstellung wie dieser können Sie die grundlegenden Ressourcenmodule für andere Anwendungen und die vollständig komponierten Anwendungsmodule für mehrere Umgebungen wiederverwenden.
{% endhint %}
