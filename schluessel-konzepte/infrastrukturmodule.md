---
layout: home
title: Schlüßelkonzepte
subtitle: Infrastrukturmodule
---

Infrastrukturmodul ist eine Sammlung von Ressourcenmodulen, die logischerweise nicht verbunden werden können, aber in der aktuellen Situation/Projekt/Setup denselben Zweck erfüllen. Es definiert die Konfiguration für Anbieter, die an die nachgelagerten Ressourcenmodule und an Ressourcen weitergegeben wird. Es ist normalerweise darauf beschränkt, in einer Entität pro logischem Trennzeichen \(z.B. AWS-Region, Google-Projekt\) zu arbeiten. Ein Beispiel ist [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/), das Ressourcenmodule wie [terraform-aws-vpc](https://github%20.com/terraform-aws-modules/terraform-aws-vpc/) und [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) um eine Infrastruktur zu erstellen, die zum Ausführen von [Atlantis](https://www.runatlantis.io) auf [AWS Fargate](https://aws.amazon.com/fargate/) erforderlich ist.

