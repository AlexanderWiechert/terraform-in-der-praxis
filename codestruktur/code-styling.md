# Code-Styling


* Beispiele und Terraform-Module sollten eine Dokumentation enthalten, in der die Funktionen und deren Verwendung erklärt werden.
* Die Dokumentation kann Diagramme enthalten, die mit \[mermaid\] \([https://github.com/knsv/mermaid](https://github.com/knsv/mermaid)\) erstellt wurden, und Blaupausen, die mit \[cloudcraft.co\] \([https://cloudcraft.co](https://cloudcraft.co)\) erstellt wurden.
* Verwenden Sie [Terraform Pre-Commit-Hooks](https://github.com/antonbabenko/pre-commit-terraform), um sicherzustellen, dass der Code gültig, richtig formatiert und automatisch dokumentiert ist, bevor er an Git übertragen und von Menschen überprüft wird .


## Dokumentation

### Automatisch generierte Dokumentation

[pre-commit](https://pre-commit.com/) ist ein Framework für die Verwaltung und Wartung mehrsprachiger Pre-Commit-Hooks. Es ist in Python geschrieben und ist ein leistungsstarkes Werkzeug, um auf dem Computer des Entwicklers automatisch etwas zu tun, bevor der Code in das Git-Repository übertragen wird. Normalerweise wird es verwendet, um Linters auszuführen und Code zu formatieren \(siehe [unterstützte Hooks](https://pre-commit.com/hooks.html)\).

Mit Terraform-Konfigurationen kann Pre-Commit zum Formatieren und Validieren von Code sowie zum Aktualisieren der Dokumentation verwendet werden.

Sehen Sie sich das [pre-commit-terraform-Repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) an, um sich damit und vorhandene Repositorys \(z. B. [terraform- aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)\), wo dies bereits verwendet wird.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) ist ein Tool, das die Erstellung von Dokumentationen aus Terraform-Modulen in verschiedenen Ausgabeformaten durchführt. Sie können es manuell ausführen \(ohne Pre-Commit-Hooks\) oder \[pre-commit-terraform-Hooks\] \([https://github.com/antonbabenko/pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)\) verwenden, um die Dokumentation automatisch zu aktualisieren.

## Ressourcen

1. [Pre-Commit-Framework-Homepage](https://pre-commit.com/)
2. [Sammlung von Git-Hooks für Terraform zur Verwendung mit dem Pre-Commit-Framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blogpost von [Dean Wilson](https://github.com/deanwilson): [pre-commit Hooks and Terraform – a safety net for your Repositorys](https://www.unixdaemon.net/tools/terraform%20-precommit-Hooks/)

