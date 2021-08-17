# Große Infrastruktur mit Terraform

Quelle: [https://github.com/AlexanderWiechert/terraform-in-der-praxis/tree/master/beispiele/grosse-umgebung](https://github.com/AlexanderWiechert/terraform-in-der-praxis/tree/master/beispiele/grosse-umgebung)

Dieses Beispiel enthält Code als Beispiel für die Strukturierung von Terraform-Konfigurationen für eine große Infrastruktur, die Folgendes verwendet:

* 2 AWS-Konten
* 2 Regionen
* 2 separate Umgebungen \(`prod` und `stage` die nichts gemeinsam haben\). Jede Umgebung lebt in einem separaten AWS-Konto und umfasst Ressourcen zwischen 2 Regionen
* Jede Umgebung verwendet eine andere Version des Standard-Infrastrukturmoduls \(`alb`\) aus der [Terraform Registry](https://registry.terraform.io/)
* Jede Umgebung verwendet die gleiche Version des internen Moduls `modules/network`, da es aus einem lokalen Verzeichnis stammt.

{% hint style="info" %}
In einem großen Projekt wie hier beschrieben werden die Vorteile des Einsatzes von Terragrunt sehr deutlich. Siehe [Beispiele für Codestrukturen mit Terragrunt](/beispiele/terragrunt.md).
{% endhint %}

{% hint style="info" %}
* Perfekt für Projekte, bei denen die Infrastruktur logisch getrennt ist \(separate AWS-Konten\)
* Gut, wenn es nicht erforderlich ist, Ressourcen zu ändern, die zwischen AWS-Konten geteilt werden \(eine Umgebung = ein AWS-Konto = eine Statusdatei\)
* Gut, wenn keine Orchestrierung von Änderungen zwischen Umgebungen erforderlich ist
* Gut, wenn die Infrastrukturressourcen absichtlich je nach Umgebung unterschiedlich sind und nicht verallgemeinert werden können \(z. B. fehlen einige Ressourcen in einer Umgebung oder in einigen Regionen\)
{% endhint %}

{% hint style="warning" %}
Wenn das Projekt wächst, wird es schwieriger, diese Umgebungen untereinander auf dem neuesten Stand zu halten. Ziehen Sie die Verwendung von Infrastrukturmodulen \(von der Stange oder intern\) für wiederholbare Aufgaben in Betracht.
{% endhint %}
