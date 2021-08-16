# FAQ

## Welche Tools sollte ich kennen und verwenden?

* [Terragrunt](https://terragrunt.gruntwork.io/)
* [tflint](https://github.com/terraform-linters/tflint)
* [tfenv](https://github.com/tfutils/tfenv)
* [Atlantis](https://www.runatlantis.io/)
* [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
* [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/)


## Was sind die Lösungen für die [Dependency Hell](https://en.wikipedia.org/wiki/Dependency_hell) in Modulen?

Versionen von Ressourcen- und Infrastrukturmodulen sollten angegeben werden. Provider sollten außerhalb von Modulen konfiguriert werden, aber nur in Komposition. Version von Anbietern und Terraform können auch gesperrt werden.

Es gibt kein Master-Dependency-Management-Tool, aber es gibt einige Tipps, um die Dependency-Hölle weniger problematisch zu machen. Beispielsweise kann [Dependabot](https://dependabot.com/) verwendet werden, um Abhängigkeitsaktualisierungen zu automatisieren. Dependabot erstellt Pull Requests, um Ihre Abhängigkeiten sicher und aktuell zu halten. Dependabot unterstützt Terraform-Konfigurationen.
