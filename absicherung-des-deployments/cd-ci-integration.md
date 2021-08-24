---
description: >-
  Verwenden Sie ein Continuous Delivery / Continuous Integration oder ein
  gemeinsames Orchestrierungswerkzeug, um Ihre Terraform-Operationen von einem
  einzigen gemeinsamen Standort aus auszuführen.
---

# CI/CD Pipelines zur Absicherung der Cloudumgebung

Continuous Integration \(CI\) und Continuous Delivery \(CD\) sind für Infrastructure-as-Code-Projekte bestens geeignet. Die Nutzung eines zentralisierten CI/CD-Tools zur Ausführung Ihrer Terraform-Befehle gegen Ihre Umgebung bietet Ihnen eine einfache Möglichkeit, um sicherzustellen, dass Sie mehrere der Best Practices in diesem Dokument befolgen.

Wenn Sie die Versionskontroll- und Continuous-Integration-Funktionen eines Cloud-Anbieters nutzen \(z. B. AWS [CodeCommit](https://aws.amazon.com/codecommit/)/[CodeBuild](https://aws.amazon.com/de/codebuild/) oder Azure [Repos](https://azure.microsoft.com/en-us/services/devops/repos/)/[Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/)\), sind häufig Funktionen in das Tool integriert, die Ihnen helfen, Ihren Terraform-Code zu sichern und auszuführen, um Ressourcen in Ihrer Umgebung zu erstellen.

Ein Beispiel ist AWS CodeBuild. Wenn Sie Terraform mit CodeBuild ausführen, können Sie die IAM-Rolle nutzen, die Ihrer CodeBuild-Instanz zugewiesen ist, um die Notwendigkeit separat verwalteter und gepflegter IAM-Anmeldeinformationen zu vermeiden und so die allgemeine Systemsicherheit zu verbessern. Die Verwendung dieser Art von Tools ermöglicht es Ihnen, einen mehrstufigen Build-Prozess für die Infrastruktur zu erstellen, der automatisierte Tests, Validierung, Code-Reviews und eine konsistente Ausführungsplattform umfasst, um das Risiko von Problemen in Ihrem Infrastruktur-Management-Prozess zu minimieren.

