---
description: >-
  Befolgen Sie eine strikte Richtlinie zur Überprüfung der Terraform-Validierung
  und der Planergebnisse, bevor Sie erlauben, dass Terraform-Änderungen auf eine
  Umgebung angewendet werden.
---

# Überprüfung und Validierung

## Überprüfung und Validierung

Dies ist eine Best Practice, die ziemlich einfach erscheint, aber oft aus Gründen der Zweckmäßigkeit übersehen wird. Terraform bietet eine Reihe von Aktionen, die Sie gegen Ihren Infrastrukturcode ausführen können; zwei, die für eine erfolgreiche Terraform-Implementierung entscheidend sind, sind `validate` und `plan`.

### terraform validate

Die terraform validate Aktion prüft im Wesentlichen die Syntax Ihres Terraform Codes, um sicherzustellen, dass er syntaktisch gültig ist; sie vergleicht ihn nicht mit dem aktuellen Zustand und listet auch nicht auf, welche Ressourcen durch den Code erstellt oder verändert werden. Diese Aktion sollte von Infrastrukturentwicklern regelmäßig genutzt werden, um zu überprüfen, ob die Syntax ihres Terraform-Codes korrekt ist.

### terraform plan

Die Terraform-Plan-Aktion nimmt Ihren Terraform-Code, untersucht den Remote-Zustand Ihrer Umgebung und listet auf, welche Änderungen bei der Ausführung des Codes gegen Ihre Remote-Umgebung angewendet werden. Die Ausführung und Überprüfung der Ausgabe dieses Befehls ist ein entscheidender Schritt für eine Infrastruktur-als-Code-Pipeline; dieser Befehl gibt Ihnen die Möglichkeit, alle Probleme im Code zu erkennen und zu beheben, bevor Sie Ihre Cloud-Umgebung ändern.


Die regelmäßige Verwendung der Aktionen validieren und planen hilft Ihnen, Fehler in Ihrem Infrastrukturcode zu finden, bevor sie sich auf Ihre Cloud-Infrastruktur auswirken.


## automatisierte Test-Frameworks


Verwenden Sie ein automatisiertes Test-Framework, um Unit- und Funktionstests zu schreiben, die Ihre terraform Module validieren.


Automatisierte Tests sind für das Schreiben von Infrastrukturcode genauso wichtig wie für das Schreiben von Anwendungscode. Da Terraform an Popularität gewonnen hat, sind viele Optionen zum Testen von Terraform-Code verfügbar geworden. Mögliche Kandidaten für die Validierung von Terraform-Modulen könnten [Terratest](https://terratest.gruntwork.io/). Mit Terratest können Sie Tests in Go schreiben. Eine weitere Option für die automatisierte Terraform-Validierung ist die Verwendung der Kitchen-Terraform, [Test Kitchen](https://github.com/test-kitchen/test-kitchen) Plugins. Diese Tests können in z.B. in Ruby implementiert werden.

