# Schlüssel Konzepte

Die offizielle Terraform-Dokumentation beschreibt [alle Aspekte der Konfiguration im Detail](https://www.terraform.io/docs/configuration/index.html). Lesen Sie es sorgfältig durch, um den Rest dieses Abschnitts zu verstehen.

In diesem Abschnitt werden Schlüsselkonzepte beschrieben, die im Buch verwendet werden.

## Ressource

Ressource ist `aws_vpc`, `aws_db_instance` usw. Ressource gehört zum Provider, akzeptiert Argumente, gibt Attribute aus, hat Lebenszyklen. Ressourcen können erstellt, abgerufen, aktualisiert und gelöscht werden.

## Ressourcenmodul

Das Ressourcenmodul ist eine Sammlung verbundener Ressourcen, die zusammen die gemeinsame Aktion ausführen \(z. B. [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) erstellt VPC, Subnetze, NAT-Gateway usw.). Dies hängt von der Provider-Konfiguration ab, die darin definiert werden kann, oder in übergeordneten Strukturen \(zB im Infrastrukturmodul\).

## Infrastrukturmodul

Infrastrukturmodul ist eine Sammlung von Ressourcenmodulen, die logischerweise nicht verbunden werden können, aber in der aktuellen Situation/Projekt/Setup denselben Zweck erfüllen. Es definiert die Konfiguration für Anbieter, die an die nachgelagerten Ressourcenmodule und an Ressourcen weitergegeben wird. Es ist normalerweise darauf beschränkt, in einer Entität pro logischem Trennzeichen \(zB AWS-Region, Google-Projekt\) zu arbeiten. Ein Beispiel ist [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/), das Ressourcenmodule wie [terraform-aws-vpc](https://github .com/terraform-aws-modules/terraform-aws-vpc/) und [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) um eine Infrastruktur zu erstellen, die zum Ausführen von [Atlantis](https://www.runatlantis.io) auf [AWS Fargate](https://aws.amazon.com/fargate/) erforderlich ist.

## Komposition

Komposition ist eine Sammlung von Infrastrukturmodulen, die sich über mehrere logisch getrennte Bereiche erstrecken kann (z. B. AWS-Regionen, mehrere AWS-Konten). Komposition wird verwendet, um die vollständige Infrastruktur zu beschreiben, die für die gesamte Organisation oder das gesamte Projekt erforderlich ist.

Komposition besteht aus Infrastrukturmodulen, die aus Ressourcenmodulen bestehen, die einzelne Ressourcen implementieren.

![Einfache Infrastrukturzusammensetzung](.gitbook/assets/composition-1.png)

## Datenquelle

Die Datenquelle führt einen schreibgeschützten Vorgang aus und ist von der Providerkonfiguration abhängig. Sie wird in einem Ressourcenmodul und einem Infrastrukturmodul verwendet.

Die Datenquelle `terraform_remote_state` dient als Klebstoff für höherstufige Module und Kompositionen.

Die Datenquelle [external](https://www.terraform.io/docs/providers/external/data_source.html) ermöglicht es einem externen Programm, als Datenquelle zu fungieren und beliebige Daten zur Verwendung an anderer Stelle in der Terraform-Konfiguration verfügbar zu machen.

Die Datenquelle [http](https://www.terraform.io/docs/providers/http/data_source.html) stellt eine HTTP-GET-Anfrage an die angegebene URL und exportiert Informationen über die Antwort, die oft nützlich sind, um Informationen zu erhalten Endpunkte, auf denen kein nativer Terraform-Anbieter vorhanden ist.

## Remote-Status

Infrastrukturmodule und -kompositionen sollten ihren Zustand an einem entfernten Standort beibehalten, der von anderen auf kontrollierbare Weise erreicht werden kann \(ACL, Versionierung, Protokollierung\).

## Anbieter, Versorger usw.

Anbieter, Versorger und einige andere Begriffe sind in der offiziellen Dokumentation sehr gut beschrieben und es macht keinen Sinn, es hier zu wiederholen. Meiner Meinung nach haben sie wenig damit zu tun, gute Terraform-Module zu schreiben. Weitere Details werden später bekannt gegeben.

## Warum so _schwierig_?

Während einzelne Ressourcen wie Atome in der Infrastruktur sind, sind Ressourcenmodule Moleküle. Das Modul ist eine kleinste versionierte und gemeinsam nutzbare Einheit. Es hat eine genaue Liste von Argumenten, implementiert die grundlegende Logik für eine solche Einheit, um die erforderliche Funktion auszuführen. Z.B. [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) erstellt die Ressourcen `aws_security_group` und `aws_security_group_list` basierend auf der Eingabe. Dieses Ressourcenmodul allein kann zusammen mit anderen Modulen verwendet werden, um ein Infrastrukturmodul zu erstellen.

Der Zugriff auf Daten über Moleküle \(Ressourcenmodule und Infrastrukturmodule\) erfolgt unter Verwendung von (Modul-)Ausgaben und Datenquellen.

Der Zugriff zwischen Kompositionen erfolgt unter Verwendung von Datenquellen für den fernen Zustand.

Wenn man die oben beschriebenen Konzepte in Pseudo-Relationen setzt, kann das so aussehen:

```Text
Zusammensetzung-1 {
  Infrastruktur-Modul-1 {
    Datenquelle-1 => d1

    Ressourcenmodul-1 {
      Datenquelle-2 => d2
      Ressource-1 (d1, d2)
      Ressource-2 (d2)
    }

    Ressourcenmodul-2 {
      Datenquelle-3 => d3
      Ressource-3 (d1, d3)
      Ressource-4 (d3)
    }
  }

}
```
