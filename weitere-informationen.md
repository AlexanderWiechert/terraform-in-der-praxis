# Weitere Links

## Beschreiben:

* Monorepo vs. mehrere Repos \(mbt, http get, size\) für Terraform-Code
  * Sollen App und Infrastruktur Code in einem Repository gespeichert werden? Wann ja und wann nein? [https://apparently.me.uk/terraform-environment-application-pattern/overview.html](https://apparently.me.uk/terraform-environment-application-pattern/overview.html)
* Scale-Up oder Scale-Down für Codestrukturen
* Terraform Tutorial
  - [https://www.elastic2ls.com/blog/terraform-tutorial-1/](https://www.elastic2ls.com/blog/terraform-tutorial-1/)
  - [https://www.elastic2ls.com/blog/terraform-tutorial-2/](https://www.elastic2ls.com/blog/terraform-tutorial-2/)
* Umgang mit Geheimnissen in Terraform
  - [https://tosbourn.com/hiding-secrets-terraform/](https://tosbourn.com/hiding-secrets-terraform/)
  - [https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073)
* geteilter Terraform-Zustand für Umgebungen
  * Fügen Sie bessere und reale Beispiele für Arbeitsbereiche hinzu - [https://www.terraform.io/docs/state/workspaces.html\#when-to-use-multiple-workspaces](https://www.terraform.io/docs/state/workspaces.html#when-to-use-multiple-workspaces)
* Integration mit Ansible \(über dynamisches Inventar\) im Vergleich zu den user\_data der AWS-Startkonfiguration
* Terragrunt-Skripte einbeziehen und beschreiben
* Infrastruktur-Versionierung, Gitops
* Rohrleitungen \(+- Spinnaker\)
* CI-CD allgemein
* Änderungsprotokoll dieses Repos, gitbook
* Arbeiten mit mehreren Instanzen derselben Anbieter in unmittelbarer Nähe \(gleiches Infrastrukturmodul\). z.B. AWS VPC-Peering, Route53-Zone/-Datensätze.
* Überprüfen Sie, wie [https://github.com/travis-ci/terraform-config](https://github.com/travis-ci/terraform-config) organisiert ist \(Haupt-Makefiles in Root, Module, Workflow\)
  * Links zu Modulsammlungen wie [https://github.com/wellcometrust/terraform-modules](https://github.com/wellcometrust/terraform-modules) und Telia-oss hinzufügen
* Paar Sätze als Rückblick auf Projekte im Zusammenhang mit Terraform - Atlantis, terragrunt
* [https://youtu.be/ShKNCBDQpd4?t=16m34s](https://youtu.be/ShKNCBDQpd4?t=16m34s) - über Ressourcen- und Infrastrukturmodule
* [https://stackoverflow.com/questions/52134830/using-terraform-modules-for-multiple-regional-api-gateway](https://stackoverflow.com/questions/52134830/using-terraform-modules-for-multiple-regional-api-gateway) - und ähnliche Fragen. Mehrere Provider-Aliasnamen sollten \(oft\) Teil der Zusammenstellung sein und nicht einzelne Infra-Module.
* Beispiel für die Verwendung von "http"- und "externen" Datenquellen zeigen, um fehlende Funktionen von externen APIs hinzuzufügen
* Regionsübergreifendes VPC-Peering - Beispielcode anzeigen \([https://github.com/grem11n/terraform-aws-vpc-peering/pull/6/files](https://github.com/grem11n/terraform-aws-vpc-peering/pull/6/files) - sollte keine Anbieter im Modul enthalten\), externe Orrationc
* Umgang mit globalen AWS-Organisationsservices in Bezug auf Services, die zwischen anderen Umgebungen, Konten angewendet/geteilt werden \(z. B. Cloudtrail, config, einige globale Rollen, Route53-Zonen usw.\)
* Verwenden Sie keine Terraform-Arbeitsbereiche
* Verwenden von TF zum Bereitstellen lokaler Entwicklungsumgebungen \(vs. vagrant+virtualbox\)
* Sichere Möglichkeit, kritische Infrastrukturkomponenten \(z. B. EIP, VPC, RDS\) mit Prevent\_Destroy = true + IAM-Richtlinie \(Deny\) zu verwalten
* Infrastruktur-Testoptionen
* Möglichkeiten zur Integration von Modulen beschreiben \(z. B. wie ich es in terraform-aws-atlantis getan habe - BYO-Ressourcen, neu erstellen, eigenständig\)
* Module detailliert mit Beispielen beschreiben - Infrastrukturmodule und Ressourcenmodule

Stackoverflow-Fragen dazu:[https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-fileshttps://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy](https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-fileshttps://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy)
