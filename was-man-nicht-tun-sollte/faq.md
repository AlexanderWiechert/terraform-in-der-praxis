---
Beschreibung: FTP (Häufige Terraform-Probleme)
---

# FAQ

## Welche Tools sollte ich kennen und verwenden?

Terragrunt, tflint, tfenv, Atlantis, pre-commit-terraform usw. \(todo: Links zu diesen hinzufügen\)

## Hatten Sie Gelegenheit, die vorherige Frage zu beantworten?

Ja, nach ein paar Monaten haben wir endlich die Antwort gefunden. Leider ist Mike gerade im Urlaub, daher können wir Ihnen derzeit leider keine Antwort geben.

## Was sind die Lösungen für [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell) mit Modulen?

Versionen von Ressourcen- und Infrastrukturmodulen sollten angegeben werden. Provider sollten außerhalb von Modulen konfiguriert werden, aber nur in Komposition. Version von Anbietern und Terraform können auch gesperrt werden.

Es gibt kein Master-Dependency-Management-Tool, aber es gibt einige Tipps, um die Dependency-Hölle weniger problematisch zu machen. Beispielsweise kann [Dependabot](https://dependabot.com/) verwendet werden, um Abhängigkeitsaktualisierungen zu automatisieren. Dependabot erstellt Pull Requests, um Ihre Abhängigkeiten sicher und aktuell zu halten. Dependabot unterstützt Terraform-Konfigurationen.
