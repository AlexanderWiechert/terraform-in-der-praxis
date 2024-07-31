---
layout: home
title: Absicherung des Deployments
subtitle: Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen  kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen.
---

Terraform verwendet eine State-Datei, um den aktuellen Status Ihrer Infrastruktur zu speichern und Änderungen daran zu verfolgen. Wenn Sie in einem Team arbeiten oder Ihre Infrastruktur in verschiedenen Umgebungen oder von verschiedenen Maschinen aus verwalten, bietet die Verwendung eines gemeinsamen Remote-States erhebliche Vorteile:

    Zentralisierung: Ein Remote-State stellt sicher, dass der Zustand der Infrastruktur an einem zentralen Ort gespeichert wird, auf den alle Teammitglieder zugreifen können.

    Konsistenz: Durch die Zentralisierung verhindern Sie Diskrepanzen, die auftreten können, wenn mehrere lokale State-Dateien verwendet werden. Dies kann zu Konflikten führen, wenn verschiedene Personen gleichzeitig Änderungen an der Infrastruktur vornehmen.

    Sicherheit: Viele Remote-State-Lösungen, wie z. B. Amazon S3 in Kombination mit DynamoDB oder Terraform Cloud, bieten Versionierung, Verschlüsselung und automatische Backups. Dies erhöht die Sicherheit und Nachvollziehbarkeit Ihrer Infrastrukturänderungen.

    Sperrmechanismus (Locking): Wenn Sie einen Remote-State verwenden, können Sie auch einen Sperrmechanismus verwenden. Dies verhindert, dass zwei Personen gleichzeitig Änderungen an derselben Infrastruktur vornehmen, was zu unerwünschten Zuständen oder Konflikten führen könnte.

    Integration und Automatisierung: Mit einem Remote-State können Sie einfacher CI/CD-Pipelines (Continuous Integration/Continuous Deployment) einrichten. Da der State zentralisiert ist, können Automatisierungstools darauf zugreifen und sicherstellen, dass die Infrastruktur in einem bekannten Zustand bleibt.

    Teilen von Daten: Mit einem Remote-State können Sie Ausgaben (Outputs) zwischen verschiedenen Terraform-Projekten teilen. Dies ist nützlich, wenn ein Projekt Daten aus einem anderen Projekt benötigt.

    Performance: Bei großen Terraform-Projekten kann das Laden und Schreiben von lokalen State-Dateien langsamer werden. Ein Remote-State kann in solchen Fällen oft performanter sein.

Während ein Remote-State viele Vorteile hat, ist es wichtig, darauf zu achten, wer Zugriff auf diesen State hat, da er wertvolle Informationen über Ihre Infrastruktur enthalten kann. Es ist ratsam, den Zugriff entsprechend zu beschränken und sicherzustellen, dass der State verschlüsselt gespeichert wird.

>Es gibt keinen Grund einen geteilten Remote-state nicht zu nutzen. In unserem Fall, da unsere Infrastruktur auf AWS läuft, wird ein S3 Bucket verwendet.


Terraform verwendet einen persistenten Datenspeicher, um den Zustands Ihrer Cloud-Infrastruktur vorzuhalten.

Dieser Datenspeicher wird erstellt, wenn Terraform zum ersten Mal gegen einen Account Ihrer Cloud-Infrastruktur ausgeführt wird, und wird nachfolgend bei allen nachfolgenden Aufrufen beibehalten. Der Terraform-Status dient im Wesentlichen dazu, dass Terraform feststellen kann, welche Ressourcen sich geändert haben und welche Änderungen vorgenommen werden müssen, damit Ihre Cloud-Infrastruktur mit Ihrem Terraform-Code übereinstimmt. Für die Speicherung des Terraform-Status stehen verschiedene Backend-Dienste zur Verfügung, darunter das lokales Dateisystem, ein Netzwerkdateispeicher, oder eine relationale Datenbank.

>Unabhängig davon, für welche Variante Sie sich entscheiden, gilt es als Best Practice, ein einziges gemeinsames Backend zu verwenden, unabhängig von der Anzahl der Entwickler, die an Ihrem Infrastrukturcode arbeiten.


Es ist auch wichtig, dass Sie einen der verschiedenen verfügbaren Sperrmechanismen \(state lock\) nutzen, um sicherzustellen, dass immer nur ein einziger Vorgang zur Bereitstellung der Infrastruktur läuft. Mehrere Kopien Ihres Terraform-Status führen unweigerlich zu einem Abdriften des Infrastruktur-Codes und zu Kollisionen, und die Verwendung des geteilten Remote-States bietet Ihnen noch einen zweiten Vorteil. So können Sie Sicherheits- und Autorisierungsbeschränkungen durchsetzen, die festlegen, wer Ihre Infrastruktur aktualisieren darf und wie er dies tun kann.

## Trennen des Remote-States in zusammengehörige Resourcen

Technisch ist es für Terraform egal, wie Sie Ihren Infrastrukturcode strukturieren.

Sie können alles nach Ihren Wünschen und Bedürfnissen implementieren, von einer einzigen megalithischen Struktur, die alle Ihre Cloud-Ressourcen über mehrere Umgebungen hinweg beschreibt, bis hin zu kleinen, atomaren Komponenten, die einzeln bereitgestellt und nachverfolgt werden können. Wie bei den meisten Systemen dieser Art liegt der richtige Grad der Dekomposition irgendwo zwischen den beiden Extremen; es gilt als Best Practice, verwandte Ressourcen nach Umgebungen oder Anwendungen zu gruppieren und für jede Gruppierung einen eigenen Terraform-State zu pflegen. In der Praxis bedeutet dies, dass die Anzahl der Remote-States zunehmen wird, aber die Beibehaltung einer strikten logischen Trennung zwischen Umgebungen und Anwendungen verbessert die Performance des Tools und verhindert Konflikte.

>Wenn Sie beispielsweise sowohl ein ERP-System als auch ein CMS-System in der Cloud hosten und jedes System eine Test-, eine Staging- und eine Produktionsumgebung hat, werden Sie sechs separate Terraform-Status-Speicherorte haben, einen für jede Umgebung und jede Anwendung.


