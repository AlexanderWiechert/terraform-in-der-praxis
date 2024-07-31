---
layout: home
title: Absicherung des Deployments
subtitle: Befolgen Sie eine strikte Richtlinie zur Überprüfung der Terraform-Validierung und der Planergebnisse, bevor Sie erlauben, dass Terraform-Änderungen auf eine  Umgebung angewendet werden.
---

Der Einsatz von terraform validate und terraform plan ist für eine sichere und zuverlässige Terraform-Implementierung unerlässlich. Diese Befehle ermöglichen es den Entwicklern, potenzielle Probleme zu erkennen, bevor sie in die Produktion überführt werden.

    terraform validate:
        Zweck: Dieser Befehl überprüft, ob das Terraform-Konfigurationsverzeichnis syntaktisch korrekt und intern konsistent ist, ohne jedoch die Cloud-Infrastruktur zu evaluieren.
        Vorteile:
            Schnelle Rückmeldung: Es gibt sofortige Rückmeldung, ob die Terraform-Dateien gültig sind oder nicht.
            Einbindung in CI/CD: Dies kann als erster Schritt in einer CI/CD-Pipeline integriert werden, um sicherzustellen, dass nur gültige Konfigurationen weitergeleitet werden.
            Keine Kosten oder Nebenwirkungen: Da keine Cloud-Ressourcen evaluiert oder erstellt werden, entstehen keine Kosten, und es gibt keine unbeabsichtigten Nebenwirkungen.
    terraform plan:
        Zweck: Dieser Befehl zeigt, welche Aktionen Terraform auf der tatsächlichen Infrastruktur ausführen wird, ohne diese Änderungen tatsächlich vorzunehmen. Es bietet eine Vorschau, was angewendet (applied) wird.
        Vorteile:
            Sicherheit: Es bietet einen klaren Überblick über die bevorstehenden Änderungen, sodass Sie diese überprüfen und bestätigen können, bevor sie in die Produktion überführt werden.
            Vermeidung von Überraschungen: terraform plan hilft dabei, unbeabsichtigte Änderungen zu erkennen und zu verhindern.
            Dokumentation: Der Output kann geteilt werden, um eine geplante Änderung mit einem Team zu diskutieren oder zu dokumentieren.

Best Practices:

    Immer validieren und planen: Bevor Sie terraform apply ausführen, sollten Sie immer terraform validate und terraform plan verwenden, um sicherzustellen, dass die Änderungen wie erwartet sind.
    Verwendung in CI/CD: Integrieren Sie diese Befehle in Ihre CI/CD-Pipelines, um eine automatisierte Überprüfung aller Terraform-Änderungen sicherzustellen.
    Teambesprechungen: Nutzen Sie den Output von terraform plan in Code-Reviews oder Team-Diskussionen, um sicherzustellen, dass alle Mitglieder die bevorstehenden Änderungen verstehen und ihnen zustimmen.

Das rigorose Einhalten dieser Best Practices kann dabei helfen, viele gängige Fehler und unerwünschte Änderungen in Ihrer Terraform-gesteuerten Infrastruktur zu vermeiden. Es ist ein einfacher Schritt, der aber oft übersehen wird, besonders wenn man unter Zeitdruck steht oder Änderungen schnell durchführen möchte. Es lohnt sich jedoch immer, diese Praktiken zu befolgen und dadurch mögliche kostspielige Fehler in der Zukunft zu vermeiden.


Dies ist eine Best Practice, die ziemlich einfach erscheint, aber oft aus Gründen der Zweckmäßigkeit übersehen wird. Terraform bietet eine Reihe von Aktionen, die Sie gegen Ihren Infrastrukturcode ausführen können; zwei, die für eine erfolgreiche Terraform-Implementierung entscheidend sind, sind `validate` und `plan`.

### terraform validate

Die terraform validate Aktion prüft im Wesentlichen die Syntax Ihres Terraform Codes, um sicherzustellen, dass er syntaktisch gültig ist; sie vergleicht ihn nicht mit dem aktuellen Zustand und listet auch nicht auf, welche Ressourcen durch den Code erstellt oder verändert werden. Diese Aktion sollte von Infrastrukturentwicklern regelmäßig genutzt werden, um zu überprüfen, ob die Syntax ihres Terraform-Codes korrekt ist.

### terraform plan

Die Terraform-Plan-Aktion nimmt Ihren Terraform-Code, untersucht den Remote-Zustand Ihrer Umgebung und listet auf, welche Änderungen bei der Ausführung des Codes gegen Ihre Remote-Umgebung angewendet werden. Die Ausführung und Überprüfung der Ausgabe dieses Befehls ist ein entscheidender Schritt für eine Infrastruktur-als-Code-Pipeline; dieser Befehl gibt Ihnen die Möglichkeit, alle Probleme im Code zu erkennen und zu beheben, bevor Sie Ihre Cloud-Umgebung ändern.

>Die regelmäßige Verwendung der Aktionen validieren und planen hilft Ihnen, Fehler in Ihrem Infrastrukturcode zu finden, bevor sie sich auf Ihre Cloud-Infrastruktur auswirken.


## automatisierte Test-Frameworks

>Verwenden Sie ein automatisiertes Test-Framework, um Unit- und Funktionstests zu schreiben, die Ihre terraform Module validieren.


Automatisierte Tests sind für das Schreiben von Infrastrukturcode genauso wichtig wie für das Schreiben von Anwendungscode. Da Terraform an Popularität gewonnen hat, sind viele Optionen zum Testen von Terraform-Code verfügbar geworden. Mögliche Kandidaten für die Validierung von Terraform-Modulen könnten [Terratest](https://terratest.gruntwork.io/). Mit Terratest können Sie Tests in Go schreiben. Eine weitere Option für die automatisierte Terraform-Validierung ist die Verwendung der Kitchen-Terraform, [Test Kitchen](https://github.com/test-kitchen/test-kitchen) Plugins. Diese Tests können in z.B. in Ruby implementiert werden.

