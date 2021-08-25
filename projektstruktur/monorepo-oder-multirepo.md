---
description: >-
  Erfahren Sie mehr über die Vor- und Nachteile der Verwendung von Mono-Repositorys und Multi-Repositorys sowie den jeweils logischsten Anwendungsfall.
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

{% hint style="info" %}
Verwenden Sie KEINE Micro-Repos für Ihre Terraform-Module. Verwenden Sie ein Mono-Repo.
{% endhint %}

## Monolithische Repositorys

Zur Klärung vorweg: In diesem Beitrag konzentrieren wir uns auf ein Mono-Repo ausschliesslich für Infrastrukturkomponenten.

Mono-Repositorys funktionieren prima, wenn du ein persönliches Projekt oder ein kleineres Team hast. Es macht Sinn, in sogenannte Resourcenmodule, die kleinste logischste Gruppierung von Ressourcen und ihren Abhängigkeiten einzusortieren. In unserem Beispiel bieten sich hier an DNS, VPC, ECS.

![Monorepo](/img/monorepo-1.png "Monorepo")


### Vorteile
* Ein Mono-Repo wird zu einer einzigen Quelle der Wahrheit, um die gesamte Infrastrukturkonfiguration zu erhalten.

* Es konsolidiert die Infrastrukturkonfiguration zum Testen und Debuggen, was für Datenbanktests, Warteschlangen, Ereignisstreaming oder Datenpipelines wichtig sein kann.

### Nachteile

* Wenn Sie Module im Laufe der Zeit aktualisieren, erhöht sich der Verwaltungsaufwand für Module. Versionsverwaltung und Abhängigkeiten von Modulen und Provider können in diesem Paradigma ziemlich verwirrend sein, um zu debuggen. Als bewährte Methode sollten Sie Providerversionen in jedem Modul fixieren. Das Trennen und Versionieren von Modulen nach Unterverzeichnissen kann es jedoch erschweren, zu debuggen, welche Anbieterversionen in den einzelnen Modulen verwendet werden.

* Außerdem kann das Buildsystem nicht einfach skaliert werden, wenn weitere Unterverzeichnisse erstellen werden. Wenn Änderungen über eine Pipeline erfasst werden, muss jeder Ordner nach Änderungen abgesucht. Viele CI-Frameworks verwenden Changesets, um Unterschiede zu bewerten, was die Laufzeit der Pipeline erhöhen kann.

* Die Zugriffskontrolle wird standardmäßig auf das gesamte Mono-Repository angewendet. Unter bestimmten Umständen möchtst du möglicherweise nur, dass ein Benutzer oder eine Gruppe auf bestimmte Unterverzeichnisse zugreifen kann.

{% hint style="info" %}
Wenn du mehr Zeit damit verbringest, die Build-Systemlogik zu pflegen, um Ihr Infrastruktur-Mono-Repository beizubehalten, solltest du das Mono-Repository möglicherweise in mehrere Repositorys aufteilen.
{% endhint %}



## Mehrere Quell-Repositorys

### Vorteile

### Nachteile
