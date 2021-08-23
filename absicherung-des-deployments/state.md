---
description: >-
  Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen
  kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen
  werden müssen, damit Ihre Cloud-Infrastruktur
---

# Remote State

## Remote State

{% hint style="info" %}
Es gibt keinen Grund einen geteilten Remote-state nicht zu nutzen. In unserem Fall, da unsere Infrastruktur auf AWS läuft, wird ein S3 Bucket verwendet.
{% endhint %}

Terraform verwendet einen persistenten Datenspeicher, um den Zustands Ihrer Cloud-Infrastruktur vorzuhalten.

Dieser Datenspeicher wird erstellt, wenn Terraform zum ersten Mal gegen einen Account Ihrer Cloud-Infrastruktur ausgeführt wird, und wird nachfolgend bei allen nachfolgenden Aufrufen beibehalten. Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen, damit Ihre Cloud-Infrastruktur mit Ihrem Terraform-Code übereinstimmt. Für die Speicherung des Terraform-Status stehen verschiedene Backend-Dienste zur Verfügung, darunter das lokales Dateisystem, ein Netzwerkdateispeicher, oder eine relationale Datenbank.

{% hint style="info" %}
Unabhängig davon, für welche Variante Sie sich entscheiden, gilt es als Best Practice, ein einziges gemeinsames Backend zu verwenden, unabhängig von der Anzahl der Entwickler, die an Ihrem Infrastrukturcode arbeiten.
{% endhint %}

Es ist auch wichtig, dass Sie einen der verschiedenen verfügbaren Sperrmechanismen \(state lock\) nutzen, um sicherzustellen, dass immer nur ein einziger Vorgang zur Bereitstellung der Infrastruktur läuft. Mehrere Kopien Ihres Terraform-Status führen unweigerlich zu einem Abdriften des Infrastruktur-Codes und zu Kollisionen, und die Verwendung des geteilten Remote-States bietet Ihnen noch einen zweiten Vorteil. So können Sie Sicherheits- und Autorisierungsbeschränkungen durchsetzen, die festlegen, wer Ihre Infrastruktur aktualisieren darf und wie er dies tun kann.

## Trennen des Remote-States in zusammengehörige Resourcen

Technisch ist es für Terraform egal, wie Sie Ihren Infrastrukturcode strukturieren.

Sie können alles nach Ihren Wünschen und Bedürfnissen implementieren, von einer einzigen megalithischen Struktur, die alle Ihre Cloud-Ressourcen über mehrere Umgebungen hinweg beschreibt, bis hin zu kleinen, atomaren Komponenten, die einzeln bereitgestellt und nachverfolgt werden können. Wie bei den meisten Systemen dieser Art liegt der richtige Grad der Dekomposition irgendwo zwischen den beiden Extremen; es gilt als Best Practice, verwandte Ressourcen nach Umgebungen oder Anwendungen zu gruppieren und für jede Gruppierung einen eigenen Terraform-State zu pflegen. In der Praxis bedeutet dies, dass die Anzahl der Remote-States zunehmen wird, aber die Beibehaltung einer strikten logischen Trennung zwischen Umgebungen und Anwendungen verbessert die Performance des Tools und verhindert Konflikte.

{% hint style="info" %}
Wenn Sie beispielsweise sowohl ein ERP-System als auch ein CMS-System in der Cloud hosten und jedes System eine Test-, eine Staging- und eine Produktionsumgebung hat, werden Sie sechs separate Terraform-Status-Speicherorte haben, einen für jede Umgebung und jede Anwendung.
{% endhint %}

