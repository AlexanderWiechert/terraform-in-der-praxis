---
layout: home
title: Projektstruktur
subtitle: Alles in einen State oder doch lieber trennen? Aber wo genau?
---

# Warum es Sinn macht logische Einheiten des Stacks in seperaten States zu speichern

Wir haben Module für alles von Netzwerk-Subnetzen bis hin zu Lambda-Funktionen verwendet, prima bis hier hin. Aber das gesamte Projekt/Produkt ist immer noch ein mehr oder weniger monolitischer Block. Warum? Nun nehmen wir mal an es gibt gute Gründe, das wir z.B. die Benennung der Sicherheitsgruppen ändern müssen. Dies könnte bei einem Tippfehler massive Auswirkungen haben, wenn wir alles von der VPC Konfiguration über die Datenbanken, Compute Nodes usw. in einem Remote State speichern.

Das Well Architected Framework von Amazon geht ausführlich auf solche Dinge ein, und sie verwenden bessere Worte, aber ein großes Problem ist der Explosionsradius oder die Minimierung des Umfangs einer Änderung. Wenn wir alles in einer einzigen Konfiguration ausführen, wirkt sich jedes Mal, wenn diese Konfiguration aktualisiert werden muss, auf alles in der Umgebung aus.

Teilen wir die Konfiguration in logisch getrennte Zustände auf, Netzwerk ist eine Sache, die man einmal anlegen muss, und insbesondere angesichts der Tatsache, dass Netzwerkänderungen in AWS ziemlich destruktiv sind, ist es am besten, sie anzulegen und dann zu vergessen.

Datenbanken und zentralisierter Speicher (EFS/S3) sind ähnlich. Es ist unwahrscheinlich, dass diese Ressourcen über das Wochenende entfernt(zerstört) werden, ebenso wie Datenbanken – je nach Betriebsmodell müssen Sie möglicherweise sogar eine Trennung von Berechtigungen erzwingen.





Sicherheit ist eine andere, die unabhängig sein sollte. Richtlinien, Verschlüsselungsschlüssel und sogar Sicherheitsgruppenregeln (obwohl nicht unbedingt Sicherheitsgruppen) erfordern wahrscheinlich eine separate Verwaltung oder zumindest eine Form der Aufsicht, und auf keinen Fall sollten Sie Geheimnisse auf dieselbe Weise verwalten Tool zum Bereitstellen eines Webservers.


Wenn wir von einer idealen Infrastruktur-als-Code (IaC)-Architektur sprechen, ist es unerlässlich, Ressourcen und Zustände in einer Weise zu organisieren, die sowohl den Explosionsradius minimiert als auch die Berechtigungen und Verwaltung isoliert, wie Sie es beschrieben haben.

Hier sind einige Empfehlungen, wie Sie dies in Ihrem IaC-Ansatz berücksichtigen können:

    Modulare Architektur: Anstatt eine einzige große Terraform-Datei (oder CloudFormation-Vorlage oder ein anderes IaC-Tool) zu haben, verwenden Sie Module, um bestimmte Ressourcengruppen oder Funktionsbereiche zu organisieren.

    Separate Zustände (State Files): Verwenden Sie separate Zustandsdateien für verschiedene logische Einheiten Ihrer Architektur. Zum Beispiel könnte man separate Zustände für Netzwerk, Datenbanken, Anwendungen und Sicherheitsressourcen haben. Dies minimiert den möglichen Schaden, der durch eine Änderung an einem Zustand verursacht wird.

    Prinzip der kleinsten Rechte: Vergeben Sie Berechtigungen auf der Basis des kleinsten notwendigen Rechts. Zum Beispiel sollte das Team, das für Datenbanken zuständig ist, nicht unbedingt die Fähigkeit haben, Netzwerkressourcen zu ändern.

    Automatisierte Tests: Implementieren Sie Tests, um sicherzustellen, dass Änderungen, die Sie vornehmen, die gewünschten Auswirkungen haben und nicht unbeabsichtigt andere Teile Ihrer Infrastruktur beeinflussen.

    Umgebungsmanagement: Betrachten Sie die Verwendung unterschiedlicher Umgebungen wie Entwicklung, Test und Produktion. So können Änderungen zuerst in einer weniger kritischen Umgebung getestet werden.

    Zentrales Management von Geheimnissen: Tools wie AWS Secrets Manager oder HashiCorp Vault sind speziell für das Management von Geheimnissen entwickelt worden. Sie bieten eine sicherere Möglichkeit zur Verwaltung von Zugriffsschlüsseln, Datenbank-Anmeldeinformationen und anderen sensitiven Informationen.

    Dokumentation und Änderungsprotokolle: Halten Sie Änderungen und Gründe für diese Änderungen in einem Änderungsprotokoll fest. Dies erleichtert das Verständnis der Historie und die Diagnose von Problemen.

    Backup und Wiederherstellungsstrategien: Stellen Sie sicher, dass Sie regelmäßige Backups Ihrer IaC-Konfigurationen und Ihrer Cloud-Ressourcen haben. Dies kann sehr nützlich sein, wenn unerwartete Probleme auftreten.

Zusammengefasst ist es wichtig, einen IaC-Ansatz zu haben, der sowohl robust als auch flexibel ist. Eine gute Organisation, klare Trennung von Zuständigkeiten und die Anwendung bewährter Praktiken können dazu beitragen, den Explosionsradius zu minimieren und gleichzeitig eine effektive und sichere Cloud-Architektur zu gewährleisten.