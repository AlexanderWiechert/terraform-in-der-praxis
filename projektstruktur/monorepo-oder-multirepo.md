---
layout: home
title: Projektstruktur
subtitle: Erfahren Sie mehr über die Vor- und Nachteile der Verwendung von Mono-Repositories und Multi-Repositories sowie den jeweils logischsten Anwendungsfall.
cover: /img/projectstructure.jpg
---

# Monorepo oder dann doch lieber ein Multirepo Setup
Da du das hier liest verwendet ihr Terraform für Infrastruktur. Da hast du dir sicher die Fragen gestellt, wie das Ganze schneller und sicherer werden könnte.  Du bist nicht allein. Wir alle erstellen Konfigurationen, Codes in verschiedenen Tools und Sprachen und verbringen dann viel Zeit damit, sie lesbarer, erweiterbarer und skalierbarer zu machen.

Der so erzeugte Code auch sollte ein oder mehrere verschiedene Probleme lösen, und soll auch im Interesse der Deduplizierung wiederverwendbar sein. Normalerweise endeten solche Diskussionen mit „Lass uns Module verwenden“.

Es ist eine bekannte Praxis, den Code zu taggen, um sicherzustellen, dass die damit erzeugte Infrastruktur immer auf die gleiche Weise funktioniert, selbst wenn der Modulcode irgendwann einmal geändert wird. Diese Arbeitsweise sollte sich nach dem Teamprinzip richten, bei dem geeignete Module getaggt und entsprechend eingesetzt werden müssen. Nun aber haben wir so viele verschiedenste Abhängigkeiten, erzeugt ... willkommen in der Dependency-hell!

Was ist, wenn ich 120 Module habe, in verschiedenen Repositorien und ein Modulwechsel 20 verschiedene Module berührt. Bedeutet das, dass wir 20 + 1 Pull-Requests erstellen müssen ? Wenn die Mindestzahl der Reviewer auf 2 eingestellt ist , bedeutet dies 21 x 2 = 44 Peer-Reviews. Ernsthaft! Wir haben das Team gerade mit „einem Modulwechsel“ lahmgelegt.

Zurück zu den Grundlagen. Was sind die allgemeinen Voraussetzungen für ein Repository, dass ein Terraform-Modul enthält?
* Es sollte getaggt werden, um ungewollte Änderungen in der Infrastruktur zu unterbinden.
* Jede Änderung muss testbar sein
* Änderungen müssen einem Peer Review unterzogen werden

Eine Idee kann hier sein:

>Verwenden Sie KEINE Micro-Repos für Ihre Terraform-Module. Verwenden Sie ein Mono-Repo.


## Monolithische Repositories
Zur Klärung vorweg: In diesem Beitrag konzentrieren wir uns auf ein Mono-Repo ausschliesslich für Infrastrukturkomponenten.

Mono-Repositories funktionieren prima, wenn du ein persönliches Projekt oder ein kleineres Team hast. Es macht Sinn, in sogenannte Resourcenmodule, die kleinste logischste Gruppierung von Ressourcen und ihren Abhängigkeiten einzusortieren. In unserem Beispiel bieten sich hier an DNS, VPC, ECS.

![Monorepo](/img/monorepo-1.webp "Monorepo")

### Vorteile
* Ein Mono-Repo wird zu einer einzigen Quelle der Wahrheit, um die gesamte Infrastrukturkonfiguration zu erhalten.

* Es konsolidiert die Infrastrukturkonfiguration zum Testen und Debuggen, was für Datenbanktests, Warteschlangen, Ereignisstreaming oder Datenpipelines wichtig sein kann.

### Nachteile
* Wenn die Module im Laufe der Zeit aktualisieren werden müssen, erhöht sich der Verwaltungsaufwand. Versionsverwaltung und Abhängigkeiten von Modulen und Provider können in diesem Paradigma ziemlich verwirrend sein, um zu debuggen. Als bewährte Methode sollten Providerversionen in jedem Modul fixieren werden. Das Trennen und Versionieren von Modulen nach Unterverzeichnissen kann es jedoch erschweren, zu debuggen, welche Anbieterversionen in den einzelnen Modulen verwendet werden.

* Außerdem kann das Buildsystem nicht einfach skaliert werden, wenn weitere Unterverzeichnisse erstellen werden. Wenn Änderungen über eine Pipeline erfasst werden, muss jeder Ordner nach Änderungen abgesucht. Viele CI-Frameworks verwenden Changesets, um Unterschiede zu bewerten, was die Laufzeit der Pipeline erhöhen kann.

* Die Zugriffskontrolle wird standardmäßig auf das gesamte Mono-Repository angewendet. Unter bestimmten Umständen möchtst du möglicherweise nur, dass ein Benutzer oder eine Gruppe auf bestimmte Unterverzeichnisse zugreifen kann.

>Wenn du mehr Zeit damit verbringest, die Build-Systemlogik zu pflegen, um Ihr Infrastruktur-Mono-Repository beizubehalten, solltest du das Mono-Repository möglicherweise in mehrere Repositories aufteilen.




## Mehrere Quell-Repositories
Ein Multi-Repository Setup kann eine granulare Zugriffskontrolle und dadurch eine bessere Nachverfolgbarkeit von Konfigurationsänderungen gewährleisten. Wenn ein großes Team, das an einem komplexen Infrastruktursystem zusammenarbeitet, können mit mehreren Quell-Repositories Änderungen einfacher lokalisiert und Versionsupdates der Module gezielter vorgenommen werden. So können gezielt Verantwortlichkeiten für Änderungen auf die Teams übertragen werden, die für die einzelnen Infrastrukturkomponenten verantwortlich sind.

Es gibt viele Ansätze, ein Multi-Repository Setup zu organisieren. So kann beispielsweise jedes Modul in ein eigenes Repository ausgelagert werden. Im Fall der ```serverless``` Funktionen, der ```queues``` und des ```VPC``` bietet es sich an jeweils einzelne Repositories zu erstellen . Einzelne [Kompositionen](schluessel-konzepte/kompositionen.md) oder Produkte würden auf diese Remote-Module verweisen. [Umgebungen](schluessel-konzepte/infrastrukturmodule.md) würden durch Unterverzeichnisse in oben genannten Repositories abgebildet werden.

![Multirepo](/img/multirepo-1.webp "Multirepo")

![Multirepo mit Produkt](/img/multirepo-2.webp "Multirepo mit Produkt")

Das verwenden von Release Tags, erleichtert die Versionierung von Modulen erheblich und macht Änderungen nachvollziehbar. Wenn die Module in ihre eigenen Quell-Repositorys aufgeteilen werden, können diese unabhängig getestet, auf gezielte Modulversion im Produkt Code verwiesen, und zum Beispiel die Providerversionen mit der Modulversion aktualisieren werden.

### Vorteile
* Multi-Repositorys ermöglichen es Teams, schneller neue Infrastrukturen für Produkte aufzubauen und zu ändern.
* Änderungen können von den Produktteams einfacher angefordert werden und individuell mittels Tags bereitgestellt werden.
* Unabhängige Repositorys ermöglichen isolierte Tests für Modulsicherheit und -funktionalität.
* Sie können die Modulversionierung mithilfe von Release Tags anwenden.
* Individuelle Repositorys ermöglichen die Zugriffskontrolle von Modulen und Konfigurationen.

### Nachteile
* Wenn das Produkt auf viele verschiedene Remote-Module verweist, benötigt Terraform einige Zeit, um diese herunterzuladen.
* Wenn aus bestimmten Gründen Versionsupdates für einzelne Module ausgeführt werden müssen, kann das unter Umständen bedeuten, dass ich in allen davon abhängigen Repositories eine PR erstellen muss, was zu erheblichen Aufwand seitens der Entwickler führen kann. Insbesondere wenn diese im Peer Review geprüft werden müssen.

### Zusammenfassung

Es gibt keine richtige oder falsche Antwort, wenn es um die Verwendung von Mono-Repos und Multi-Repos geht. Indem wir einen Schritt zurücktreten und verschiedene Organisationsmuster beobachten, können wir feststellen, welche Umgebungsstruktur für uns am besten funktioniert. Man kann auch das Beste aus zwei Welten kombinieren. Sie können Ihr Multi-Repository mit separaten Repositorys für jede Geschäftsdomäne, jedes Produkt oder jedes Team weiter strukturieren. Verwenden Sie Unterverzeichnisse in diesen Repositorys, um Umgebungen zu trennen, wodurch die Konfigurationsunterschiede zwischen den Umgebungen sichtbar werden.
