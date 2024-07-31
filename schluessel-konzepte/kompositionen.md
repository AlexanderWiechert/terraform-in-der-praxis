---
layout: home
title: Schlüßelkonzepte
subtitle: Kompositionen
---

# Kompositionen

Kompositionen sind eine Sammlung von Infrastrukturmodulen, die sich über mehrere logisch getrennte Bereiche erstrecken kann \(z. B. AWS-Regionen, mehrere AWS-Konten\). Komposition wird verwendet, um die vollständige Infrastruktur zu beschreiben, die für die gesamte Organisation oder das gesamte Projekt erforderlich ist.

Komposition besteht aus Infrastrukturmodulen, die aus Ressourcenmodulen bestehen, die einzelne Ressourcen implementieren.

![Einfache Infrastrukturzusammensetzung](/img/komposition.png "Übersicht Konzept")

Kompositionen in Cloud-Infrastruktur:

Kompositionen ermöglichen es Unternehmen, ihre Cloud-Infrastruktur effektiv und effizient zu organisieren. Stellen Sie sich das wie das Bauen mit Legosteinen vor. Jeder Stein (Ressourcenmodul) hat seine eigene Funktion, aber wenn sie zusammenkommen (Infrastrukturmodul), können sie etwas Größeres und Komplexeres darstellen.

    Infrastrukturmodule: Diese dienen als Container oder Sammlungen von Ressourcenmodulen. Ein Infrastrukturmodul könnte beispielsweise die Definition für eine komplette Webanwendungsumgebung enthalten, einschließlich der notwendigen Datenbanken, Netzwerkelemente und Compute-Ressourcen.

    Ressourcenmodule: Dies sind die Bausteine, aus denen Infrastrukturmodule bestehen. Ein Ressourcenmodul könnte eine einzelne Cloud-Ressource oder eine Gruppe eng verwandter Ressourcen repräsentieren. Zum Beispiel könnte ein Ressourcenmodul in AWS eine EC2-Instanz oder eine Gruppe von EC2-Instanzen mit dazugehörigem Load Balancer definieren.

Vorteile von Kompositionen:

    Wiederverwendbarkeit: Module können in verschiedenen Umgebungen oder Anwendungen wieder verwendet werden. Dies fördert Konsistenz und schnelle Bereitstellungen.

    Isolation: Durch die Trennung von Infrastruktur in unterschiedlichen Modulen können Sie Veränderungen in einem Modul vornehmen, ohne den Rest Ihrer Infrastruktur zu beeinflussen.

    Vereinfachung der Verwaltung: Durch die Verwendung von Modulen können große, komplexe Infrastrukturen in handhabbarere Einheiten zerlegt werden. Das erleichtert das Verständnis, die Wartung und das Troubleshooting.

    Flexibilität: Kompositionen ermöglichen es, Ressourcen über verschiedene geografische Regionen oder sogar über verschiedene Cloud-Konten hinweg zu verteilen. Das bietet Flexibilität in Bezug auf Verfügbarkeit, Compliance und Kostenoptimierung.

Die Idee der "Komposition" kann auf viele Cloud- und Infrastrukturdienste angewendet werden, aber sie ist besonders prominent in IaC-Tools wie Terraform, da diese Tools darauf ausgelegt sind, komplexe Infrastrukturen in kodifizierbarer und nachvollziehbarer Form zu definieren.