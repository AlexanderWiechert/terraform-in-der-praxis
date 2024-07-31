---
layout: home
title: Schlüßelkonzepte
subtitle: Infrastrukturmodule
---

Wenn Sie sich die Organisation und das Design von Terraform-Konfigurationen ansehen, stoßen Sie häufig auf Begriffe wie "Basismodule" oder "Ressourcenmodule" und "Infrastrukturmodule". Um diese Konzepte besser zu verstehen, kann man sie mit Bausteinen vergleichen, die zu einer größeren Struktur zusammengefügt werden.
Ressourcenmodule (Basismodule)

Ein Ressourcenmodul (manchmal auch als Basismodul bezeichnet) repräsentiert im Allgemeinen eine Sammlung von eng verbundenen Ressourcen, die gemeinsam eine bestimmte Infrastrukturkomponente erstellen. Ein gutes Beispiel ist das terraform-aws-vpc Modul, das alles enthält, was Sie benötigen, um eine VPC in AWS zu erstellen.
Infrastrukturmodule

Das Infrastrukturmodul dagegen ist eine höhere Ebene der Abstraktion. Es kombiniert mehrere Ressourcenmodule, um eine vollständige Lösung oder Infrastruktur bereitzustellen, die für eine bestimmte Anwendung oder einen bestimmten Zweck optimiert ist.

## Warum sind Infrastrukturmodule nützlich?

    Wiederverwendbarkeit auf höherem Niveau: Anstatt sich nur auf Einzelressourcen zu konzentrieren, können Sie vollständige Umgebungen oder Anwendungsstacks definieren und wiederverwenden.

    Vereinfachung der Bereitstellung: Ein komplexes Setup, das aus vielen Ressourcen besteht, kann durch einfaches Anwenden eines Infrastrukturmoduls bereitgestellt werden.

    Standardisierung: Unternehmen können Infrastrukturmodule erstellen, die ihren Best Practices entsprechen, und Entwicklerteams können diese Module dann verwenden, um konsistente und konforme Umgebungen zu erstellen.

### Beispiel - Atlantis mit AWS Fargate:

Das von Ihnen erwähnte terraform-aws-atlantis Modul ist ein perfektes Beispiel für ein Infrastrukturmodul. Es bündelt mehrere Ressourcenmodule zusammen, um eine vollständige Lösung bereitzustellen: Die Einrichtung von Atlantis in AWS, ausgeführt auf Fargate. Durch Verwenden dieses Moduls können Benutzer Atlantis einfach und konsistent in AWS bereitstellen, ohne sich um die Einzelheiten der zugrunde liegenden Ressourcen kümmern zu müssen.

Infrastrukturmodule sind äußerst nützlich in der modernen Softwareentwicklung und -bereitstellung. Sie ermöglichen es Entwicklern, verschiedene Arten von Infrastrukturen zu definieren, zu konfigurieren und zu verwalten, wie zum Beispiel Netzwerke, Server, Datenbanken und andere technische Ressourcen. Sie können als Bausteine betrachtet werden, die es Teams ermöglichen, komplexe Systeme zu erstellen, indem sie diese Module miteinander kombinieren.

Ein Infrastrukturmodul kann eine Reihe von Funktionen umfassen, wie z.B. die Erstellung von VPCs und Sicherheitsgruppen in AWS, die Bereitstellung von Docker-Containern, das Management von Kubernetes-Clustern oder die Einrichtung von VPNs und anderen Netzwerkfunktionen. Infrastrukturmodule können auch verwendet werden, um die Konfiguration von Softwareanwendungen zu managen, wie zum Beispiel die Definition von Umgebungsvariablen, die Einrichtung von Datenbankverbindungen oder die Bereitstellung von Webservern.

Mit den richtigen Infrastrukturmodulen können Entwicklungs-Teams Zeit und Aufwand sparen, indem sie wiederverwendbare und standardisierte Infrastrukturkomponenten nutzen, die den besten Praktiken der Branche entsprechen, anstatt jedes Mal von Grund auf neu zu beginnen. Außerdem fördern Infrastrukturmodule die Einhaltung von Sicherheits-, Compliance- und Leistungsstandards und reduzieren die Gefahr von Fehlern und Ausfällen. Sie bieten eine hohe Flexibilität und ermöglichen es den Teams, ihre Infrastrukturen an die spezifischen Anforderungen ihrer Projekte und Anwendungen anzupassen.



In Terraform bezeichnet man "Kompositionen" oft einfach als Module. Diese Module können aus mehreren Gründen verwendet werden:

    Strukturierung und Organisation: Module ermöglichen es Ihnen, Ihre Terraform-Konfiguration in kleinere, wiederverwendbare Stücke zu zerlegen. Anstatt alle Ressourcen in einer einzigen Datei oder einem einzigen Ordner zu haben, können Sie Module erstellen, die logisch zusammengehörende Ressourcen definieren.

    Wiederverwendbarkeit: Wenn Sie beispielsweise denselben Satz von AWS-Ressourcen in mehreren Umgebungen (z. B. Entwicklung, Test, Produktion) bereitstellen möchten, können Sie ein Modul erstellen, das diese Ressourcen definiert, und es dann in jeder Umgebung wiederverwenden.

    Vereinfachung der Komplexität: Durch die Verwendung von Modulen können Sie komplexe Infrastrukturen in handhabbare und verständliche Teile zerlegen.

Ein Ressourcenmodul in Terraform definiert eine bestimmte Ressource, wie z.B. eine AWS EC2-Instanz oder ein S3-Bucket. Ein Infrastrukturmodul könnte eine Sammlung dieser Ressourcenmodule sein, die gemeinsam eine funktionsfähige Einheit bilden, z.B. eine Anwendung, die auf EC2-Instanzen läuft und Daten in S3 speichert.

Beispiel:

arduino

module "webserver" {
source = "./webserver_module"
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}

module "database" {
source = "./database_module"
instance_type = "db.m4.large"
engine = "postgres"
}

In diesem Beispiel gibt es zwei Module: webserver und database. Jedes Modul könnte mehrere Ressourcen definieren und konfigurieren.

Wenn Sie also von "Kompositionen" in Terraform sprechen, beziehen Sie sich auf das Prinzip, mehrere Module (Infrastruktur- und Ressourcenmodule) zusammenzusetzen, um eine vollständige und funktionierende Infrastrukturlösung zu erstellen.