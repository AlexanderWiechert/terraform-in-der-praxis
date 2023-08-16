---
layout: home
title: Projektstruktur
subtitle: Alles in einen State oder doch lieber trennen? Aber wo genau?
---

# Warum es Sinn macht logische Einheiten des Stacks in seperaten States zu speichern

Wir haben Module für alles von Netzwerk-Subnetzen bis hin zu Lambda-Funktionen verwendet, prima is hier hin. Aber das gesamte Projekt/Produkt ist immer noch ein mehr oder weniger monolitischer Block. Warum? Nun nehmen wir mal an es gibt gute Gründe, das wir z.B. die Benennung der Sicherheitsgruppen ändern müssen. Dies könnte bei einem Tippfehler massive Auswirkungen haben, wenn wir alles von der VPC Konfiguration über die Datenbanken, Compute Nodes usw. in einem Remote State speichern.

Das Well Architected Framework von Amazon geht ausführlich auf solche Dinge ein, und sie verwenden bessere Worte, aber ein großes Problem ist der Explosionsradius oder die Minimierung des Umfangs einer Änderung. Wenn wir alles in einer einzigen Konfiguration ausführen, wirkt sich jedes Mal, wenn diese Konfiguration aktualisiert werden muss, auf alles in der Umgebung aus.

Teilen wir die Konfiguration in logisch getrennte Zustände auf, Netzwerk ist eine Sache, die man einmal anlegen muss, und insbesondere angesichts der Tatsache, dass Netzwerkänderungen in AWS ziemlich destruktiv sind, ist es am besten, sie anzulegen und dann zu vergessen.

Datenbanken und zentralisierter Speicher (EFS/S3) sind ähnlich. Es ist unwahrscheinlich, dass diese Ressourcen über das Wochenende entfernt(zerstört) werden, ebenso wie Datenbanken – je nach Betriebsmodell müssen Sie möglicherweise sogar eine Trennung von Berechtigungen erzwingen.





Sicherheit ist eine andere, die unabhängig sein sollte. Richtlinien, Verschlüsselungsschlüssel und sogar Sicherheitsgruppenregeln (obwohl nicht unbedingt Sicherheitsgruppen) erfordern wahrscheinlich eine separate Verwaltung oder zumindest eine Form der Aufsicht, und auf keinen Fall sollten Sie Geheimnisse auf dieselbe Weise verwalten Tool zum Bereitstellen eines Webservers.
