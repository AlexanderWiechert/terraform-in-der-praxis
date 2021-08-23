# Datenquelle

Die Datenquelle führt einen schreibgeschützten Vorgang aus und ist von der Providerkonfiguration abhängig. Sie wird in einem Ressourcenmodul und einem Infrastrukturmodul verwendet.

Die Datenquelle `terraform_remote_state` verbindet höherstufige Module und Kompositionen.

Die Datenquelle [external](https://www.terraform.io/docs/providers/external/data_source.html) ermöglicht es einem externen Programm, als Datenquelle zu fungieren und beliebige Daten zur Verwendung an anderer Stelle in der Terraform-Konfiguration verfügbar zu machen.

Die Datenquelle [http](https://www.terraform.io/docs/providers/http/data_source.html) stellt eine HTTP-GET-Anfrage an die angegebene URL und exportiert Informationen über die Antwort, die oft nützlich sind, um Informationen zu erhalten Endpunkte, auf denen kein nativer Terraform-Anbieter vorhanden ist.
