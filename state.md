---
description: >-
  Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen, damit Ihre Cloud-Infrastruktur mit Ihrem Terraform-Code übereinstimmt.
---

# Remote State

{% hint style="info" %}
Es sollte immer ein geteilter Remote state genutzt werden.
{% endhint %}


Terraform verwendet einen persistenten Datenspeicher, um den Zustands Ihrer Cloud-Infrastruktur vorzuhalten.

Dieser Datenspeicher wird erstellt, wenn Terraform zum ersten Mal gegen einen Account Ihrer Cloud-Infrastruktur ausgeführt wird, und wird nachfolgend bei allen nachfolgenden Aufrufen beibehalten. Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen, damit Ihre Cloud-Infrastruktur mit Ihrem Terraform-Code übereinstimmt. Für die Speicherung des Terraform-Status stehen verschiedene Backend-Dienste zur Verfügung, darunter das lokales Dateisystem, ein Netzwerkdateispeicher, oder eine relationale Datenbank.

{% hint style="info" %}
Unabhängig davon, für welche Variante Sie sich entscheiden, gilt es als Best Practice, ein einziges gemeinsames Backend zu verwenden, unabhängig von der Anzahl der Entwickler, die an Ihrem Infrastrukturcode arbeiten.
{% endhint %}

Es ist auch wichtig, dass Sie einen der verschiedenen verfügbaren Sperrmechanismen \(state lock\) nutzen, um sicherzustellen, dass immer nur ein einziger Vorgang zur Bereitstellung der Infrastruktur läuft. Mehrere Kopien Ihres Terraform-Status führen unweigerlich zu einem Abdriften des Infrastruktur-Codes und zu Kollisionen, und die Verwendung des geteilten Remote-States bietet Ihnen noch einen zweiten Vorteil. So können Sie Sicherheits- und Autorisierungsbeschränkungen durchsetzen, die festlegen, wer Ihre Infrastruktur aktualisieren darf und wie er dies tun kann.
