---
layout: home
title: Absicherung des Deployments
subtitle: Erforderlich sind ein einheitliches Authentifizierungsschema und ein Audit-Mechanismus, der eindeutig nachverfolgt, wer eine Terraform-Operation ausgelöst hat.
---

Dies ist eine Best Practice, die auf mehreren Ebenen einer Infrastructure-as-Code-Implementierung gehandhabt werden kann.

Wenn einzelne Infrastruktur Entwickler direkt gegen Ihre Cloud-Umgebung arbeiten, sollte dies auf der Authentifizierungs- und Autorisierungsebene für die Ziel-Cloud-Plattform gehandhabt werden.

Wenn Sie ein gemeinsames Continuous-Integration-Tool wie Jenkins für die Ausführung von Terraform-Code nutzen, sollte dies im CI/CD-Tool erfolgen. Mit dieser Best Practice soll sichergestellt werden, dass Ihre Terraform-Pipeline diskrete Zugriffskontroll- und Audit-Informationen für jeden Benutzer, der auf das System zugreifen kann, verwaltet und dass sie auch Informationen über jede Terraform-Ausführung aufzeichnet.

>Dazu sollte gehören, welcher Benutzer eine Aktualisierung Ihrer Cloud-Infrastruktur ausgelöst hat, wann sie ausgelöst wurde und welche Änderungen bei jeder einzelnen Ausführung vorgenommen wurden.


eine starke Authentifizierung und Auditierung ist entscheidend, insbesondere bei der Arbeit mit Infrastructure-as-Code (IaC), wo Änderungen weitreichende Auswirkungen haben können. Lassen Sie uns tiefer in beide Aspekte eintauchen:
1. Authentifizierung und Autorisierung:

   Cloud-Ebene: Die meisten Cloud-Anbieter bieten integrierte Identity and Access Management (IAM) Lösungen an. Mit diesen Tools können Sie sicherstellen, dass nur berechtigte Benutzer Ressourcen ändern können und dass sie nur Zugriff auf die spezifischen Ressourcen und Aktionen haben, die sie benötigen. Beispiele sind AWS IAM, Azure AD und GCP IAM.

   Terraform-Ebene: Sie können Backend-Konfigurationen verwenden, die eine Authentifizierung erfordern, um auf den Terraform-State zuzugreifen. Sie können auch Provider-spezifische Authentifizierungsmethoden verwenden, um sicherzustellen, dass Terraform mit den richtigen Berechtigungen gegenüber dem Cloud-Anbieter ausgeführt wird.

   CI/CD-Tools: Wenn Sie Tools wie Jenkins, GitLab CI oder GitHub Actions verwenden, sollten Sie sicherstellen, dass die Zugriffskontrollmechanismen korrekt konfiguriert sind. Dies bedeutet, dass Tokens oder Schlüssel sicher gespeichert werden und nur von autorisierten Pipelines verwendet werden.

2. Auditierung:

   Cloud-Ebene: Die meisten Cloud-Anbieter bieten Audit-Tools, die alle Aktionen innerhalb Ihres Kontos überwachen und protokollieren. AWS bietet beispielsweise CloudTrail an, während Azure Activity Log und GCP Stackdriver Logging ähnliche Funktionen bieten. Diese Logs können Ihnen genau zeigen, welche Änderungen vorgenommen wurden, von wem und wann.

   Terraform-Ebene: Der Terraform-State selbst kann Ihnen einen Verlauf der Infrastrukturänderungen zeigen. Es gibt jedoch keine native Auditierungsfunktionalität, die anzeigt, wer einen bestimmten terraform apply Befehl ausgeführt hat.

   CI/CD-Tools: Diese Tools protokollieren in der Regel, wer eine Pipeline ausgelöst hat und welche Änderungen vorgenommen wurden. Wenn Ihr CI/CD-Tool mit Ihrem Source-Control-System (z. B. Git) integriert ist, können Sie auch sehen, wer den Code geändert hat, der zur Infrastrukturänderung geführt hat.

Zusammenfassung:
Eine effektive Implementierung von Authentifizierung und Auditierung in Ihrer Terraform-Umgebung erfordert eine Kombination von Cloud-spezifischen Tools, CI/CD-Tools und besten Praktiken in Bezug auf die sichere Speicherung und den Umgang mit Anmeldeinformationen. Es ist wichtig, diese Prozesse sorgfältig zu planen und regelmäßig zu überprüfen, um sicherzustellen, dass Ihre Infrastruktur sowohl sicher als auch nachvollziehbar ist.