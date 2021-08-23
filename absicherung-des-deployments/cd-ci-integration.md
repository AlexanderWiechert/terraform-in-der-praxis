---
description: >-
  Verwenden Sie ein Continuous Delivery / Continuous Integration oder ein
  gemeinsames Orchestrierungswerkzeug, um Ihre Terraform-Operationen von einem
  einzigen gemeinsamen Standort aus auszuführen.
---

# CI/CD Pipelines zur Absicherung der Cloudumgebung

\[Continuous Integration\]\([https://www.xtivia.com/blog/cloud/terraform-best-practices/\#:~:text=single common location.-,Continuous integration,-\(CI\) and continuous](https://www.xtivia.com/blog/cloud/terraform-best-practices/#:~:text=single%20common%20location.-,Continuous%20integration,-%28CI%29%20and%20continuous)\) \(CI\) und \[continuous delivery\]\([https://www.xtivia.com/blog/cloud/terraform-best-practices/\#:~:text=integration \(CI\) and-,continuous delivery,-\(CD\) are natural](https://www.xtivia.com/blog/cloud/terraform-best-practices/#:~:text=integration%20%28CI%29%20and-,continuous%20delivery,-%28CD%29%20are%20natural)\) \(CD\) eignen sich hervorragend für Infrastructure-as-Code-Projekte; die Nutzung eines zentralen CI/CD-Tools zur Ausführung Ihrer Terraform-Befehle in Ihrer Umgebung bietet Ihnen eine einfache Möglichkeit, um sicherzustellen, dass Sie mehrere der in diesem Dokument beschriebenen Best Practices befolgen.

Wenn Sie die Versionskontroll- und Continuous-Integration-Funktionen eines Cloud-Anbieters nutzen \(z. B. AWS [CodeCommit](https://aws.amazon.com/codecommit/)/[CodeBuild](https://www.xtivia.com/blog/cloud/terraform-best-practices/#:~:text=e.%2C%20AWS%20CodeCommit/-,CodeBuild,-or%20Azure%20Repos) oder Azure [Repos](https://azure.microsoft.com/en-us/services/devops/repos/)/[Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/)\), sind häufig Funktionen in das Tool integriert, die Ihnen helfen, Ihren Terraform-Code zu sichern und auszuführen, um Ressourcen in Ihrer Umgebung zu erstellen.

Ein Beispiel ist AWS CodeBuild. Wenn Sie Terraform mit CodeBuild ausführen, können Sie die IAM-Rolle nutzen, die Ihrer CodeBuild-Instanz zugewiesen ist, um die Notwendigkeit separat verwalteter und gepflegter IAM-Anmeldeinformationen zu vermeiden und so die allgemeine Systemsicherheit zu verbessern. Die Verwendung dieser Art von Tools ermöglicht es Ihnen, einen mehrstufigen Build-Prozess für die Infrastruktur zu erstellen, der automatisierte Tests, Validierung, Code-Reviews und eine konsistente Ausführungsplattform umfasst, um das Risiko von Problemen in Ihrem Infrastruktur-Management-Prozess zu minimieren.

