---
layout: home
title: Schlüßelkonzepte
subtitle: Datenquellen
---

Die Datenquellen in Terraform bieten eine Möglichkeit, Informationen aus externen Systemen oder anderen Terraform-Konfigurationen zu beziehen. Dies kann nützlich sein, um Werte aus anderen Projekten oder Systemen zu verwenden, ohne diese Werte hart in Ihre Terraform-Konfiguration kodieren zu müssen. Lassen Sie uns jede dieser Datenquellen genauer betrachten:

1. **terraform_remote_state**:
    * Zweck: Diese Datenquelle wird verwendet, um Zustandsinformationen aus einem anderen Terraform-Projekt zu importieren. Dies kann nützlich sein, wenn Sie z.B. einen Wert aus einem anderen Projekt benötigen, wie z.B. die ID einer erstellten Ressource.
    * Häufige Anwendung: In größeren Organisationen oder komplexen Projekten, wo mehrere Terraform-Projekte miteinander interagieren müssen.

2. **external**:
    * Zweck: Mit der external Datenquelle können Sie ein externes Programm oder Skript ausführen und dessen Ausgabe als Datenquelle in Terraform verwenden. Das externe Programm sollte im JSON-Format antworten.
    * Häufige Anwendung: Wenn Sie Daten aus einem System beziehen müssen, für das es keinen Terraform-Provider gibt oder wenn Sie eine benutzerdefinierte Logik implementieren möchten, die nicht direkt in Terraform verfügbar ist.

3. **http**:
    * Zweck: Mit dieser Datenquelle können Sie eine HTTP-GET-Anfrage an eine bestimmte URL senden und die Antwort verwenden. Sie ist nützlich, um Daten aus Systemen zu holen, für die es keinen spezifischen Terraform-Provider gibt.
    * Häufige Anwendung: Zum Abrufen von Konfigurationsdaten, Metadaten oder anderen Informationen aus HTTP-basierten Endpunkten.

Diese Datenquellen ermöglichen es Terraform, flexibel auf eine Vielzahl von Situationen und Infrastrukturen zu reagieren, indem sie Daten aus verschiedenen Quellen beziehen. Bei der Verwendung dieser Datenquellen ist es wichtig, sicherzustellen, dass Sie vertrauenswürdige Datenquellen verwenden und die Sicherheitsaspekte berücksichtigen, insbesondere wenn Sie externe oder http Datenquellen verwenden.


Die Datenquelle führt einen schreibgeschützten Vorgang aus und ist von der Providerkonfiguration abhängig. Sie wird in einem Ressourcenmodul und einem Infrastrukturmodul verwendet.

Die Datenquelle `terraform_remote_state` verbindet höherstufige Module und Kompositionen.

Die Datenquelle [external](https://www.terraform.io/docs/providers/external/data_source.html) ermöglicht es einem externen Programm, als Datenquelle zu fungieren und beliebige Daten zur Verwendung an anderer Stelle in der Terraform-Konfiguration verfügbar zu machen.

Die Datenquelle [http](https://www.terraform.io/docs/providers/http/data_source.html) stellt eine HTTP-GET-Anfrage an die angegebene URL und exportiert Informationen über die Antwort, die oft nützlich sind, um Informationen zu erhalten Endpunkte, auf denen kein nativer Terraform-Anbieter vorhanden ist.

