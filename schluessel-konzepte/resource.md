---
layout: home
title: Schlüßelkonzepte
subtitle: Ressourcen
---

Ein Terraform Ressource ist z.B. `aws_vpc`, `aws_db_instance` usw. Ressourcen gehört zum Provider, akzeptieren Argumente, geben Attribute aus, haben Lebenszyklen. Ressourcen können erstellt, abgerufen, aktualisiert und gelöscht werden.
Terraform-Ressourcen repräsentieren eine einzelne Infrastruktur-Komponente, wie zum Beispiel eine einzelne virtuelle Maschine, einen einzelnen Klusterserver oder eine einzelne Datenbank. Jede Ressource hat eine eindeutige ID, die Terraform dazu dient, die Infrastruktur zu verfolgen und den Zustand jeder Komponente zu verwalten.
Die Benennung von Ressourcen in Terraform ist ein wichtiger Aspekt und hat viele Vorteile. Sie ermöglicht es Terraform und Benutzern, die Infrastruktur klar zu verstehen und zu verwalten. Eine gut strukturierte Benennungskonvention kann dazu beitragen, dass Ressourcen leichter zu finden und zu verstehen sind. Sie kann auch dazu beitragen, die Verwaltung und Wartung der Infrastruktur zu vereinfachen.

## Seien Sie vorsichtig mit programmatisch generierten Ressourcennamen.

Ein Fallstrick, auf den fast jeder bei der Arbeit mit Terraform mindestens einmal stößt, ist das Problem der dynamischen Benennung von Ressourcen. Es ist sehr verlockend, einen algorithmischen Ansatz für die Generierung von Cloud-Ressourcennamen zu verwenden, und es scheint sinnvoll zu sein, dies auf der untersten Ebene zu tun. Sie könnten zum Beispiel versuchen, Variablen wie Umgebungsname, Anwendungsname und Region zu verwenden, um eine Flotte von Recheninstanzen dynamisch zu benennen.
Programmatisch generierte Ressourcennamen sind jedoch ziemlich komplex und können leicht zu Problemen führen, wie das oben genannte Szenario zeigt. Trotz der Tatsache, dass sie in vielen Fällen nützlich sein können, kann die Änderung der Namenskonvention zu größeren Schwierigkeiten führen, da Terraform die Ressourcen nicht mehr korrekt verfolgen und verwalten kann.
{% hint style="info" %}
Das Problem dabei ist, was passiert, wenn Sie diesen Algorithmus jemals ändern müssen.
{% endhint %}

Denken Sie daran, dass Terraform nur lose mit Ihrer Cloud-Infrastruktur gekoppelt ist. Da die zugrunde liegende Plattform keine konsistenten Informationen darüber bereithält, was sich bei den bereitgestellten Ressourcen geändert hat, ist es Terraform nicht möglich, korrekt zu interpolieren, wenn sich der Name einer Ressource ändert.

Wenn Sie dynamisch Ressourcennamen in der Form $application_$environment_$region_$count generieren und Sie feststellen, dass Sie das Format in \`$application_$environment_$region_$availabilityzone\_$count\` ändern müssen, wird Terraform die Infrastruktur, die mit der alten Namenskonvention erstellt wurde, nicht mehr verfolgen. An diesem Punkt müssen Sie entweder alle Instanzen manuell umbenennen, damit sie mit der neuen Namenskonvention übereinstimmen, oder Sie zerstören alle Instanzen und erlauben Terraform, einen neuen Satz zu erstellen. Dies ist besonders heimtückisch, wenn die dynamische Namensgebung in einem Modul auf sehr niedriger Ebene gehandhabt wird, das von mehreren Anwendungen im gesamten Unternehmen wiederverwendet wird; eine solche Änderung kann umfangreiche Aktualisierungen der Anwendungen in der gesamten Infrastruktur erforderlich machen.

{% hint style="info" %}
Um dies zu umgehen, sollten Sie, wenn Sie eine dynamische Benennung benötigen, sicherstellen, dass Sie die Benennungslogik im zusammengesetzten Anwendungsmodul und nicht auf der Ebene des Low-Level-Ressourcenmoduls behandeln, indem Sie den gesamten Ressourcennamen an das Low-Level-Modul übergeben. Auf diese Weise können Sie die Logik, die für die Handhabung der alten und neuen Infrastruktur erforderlich ist, auf der Anwendungsebene verwalten, wenn sich die Namenskonvention jemals ändert.
{% endhint %}


## Vorteile statischer Ressourcennamen

Obwohl die dynamische Benennung von Ressourcen flexibel ist, kann die Verwendung statischer Ressourcennamen in bestimmten Szenarien vorteilhaft sein:

> **Vorhersehbarkeit:** Bei der Verwendung statischer Namen können Sie sicher sein, dass der Name einer Ressource über verschiedene Umgebungen und Bereitstellungen hinweg konsistent bleibt. Dies erleichtert die Fehlersuche und das Monitoring.

> **Stabile Terraform-States:** Die Änderung eines Ressourcennamens kann dazu führen, dass Terraform die Ressource als "gelöscht" und "neu erstellt" erkennt, was zu unerwünschten Nebenwirkungen führen kann.

## Tagging als Alternative

Anstelle der dynamischen Benennung könnten Sie Tags verwenden, um Metadaten wie Umgebung, Anwendung und Region hinzuzufügen. Viele Cloud-Anbieter, wie z.B. AWS, bieten umfangreiche Unterstützung für das Tagging von Ressourcen an. Tags können Ihnen die Flexibilität bieten, die Sie von dynamischen Namen erwarten, ohne die mit Namensänderungen verbundenen Herausforderungen.
Detaillierte Logging- und Audit-Funktionen

Wenn Sie sich für die dynamische Benennung entscheiden, stellen Sie sicher, dass Sie ein robustes Logging- und Audit-System haben. So können Sie Änderungen an den Ressourcen und deren Namen leicht nachverfolgen und bei Bedarf entsprechende Korrekturen vornehmen.
Abschließende Gedanken

Während die dynamische Benennung von Ressourcen ihre Vorteile hat, ist es wichtig, die potenziellen Fallstricke zu berücksichtigen. Wie bei vielen Aspekten der Infrastruktur- und Konfigurationsverwaltung geht es darum, einen Ausgleich zwischen Flexibilität und Stabilität zu finden. Mit den richtigen Richtlinien und Best Practices können Sie die Vorteile beider Ansätze nutzen und dabei die Risiken minimieren.

Ein guter Ansatz zur Problemlösung könnte sein, die Benennungslogik in das Anwendungsmodul und nicht in das ressourcenbasierte Modul aufzunehmen. Auf diese Weise kann die Logik, die zur Verwaltung der alten und neuen Infrastruktur erforderlich ist, auf der Anwendungsebene gehandhabt werden, was eine flexiblere und effizientere Verwaltung ermöglicht.

Letztendlich ist die Namensgebung der Ressourcen in Terraform entscheidend für eine effektive Infrastrukturverwaltung. Eine sorgfältige Planung und Kontrolle der Namenskonventionen ist deshalb für jedes Terraform-Projekt von grundlegender Bedeutung.