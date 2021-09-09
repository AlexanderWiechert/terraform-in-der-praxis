# kleine Infrastruktur mit Terraform

Quelle: [https://github.com/AlexanderWiechert/terraform-in-%20der-praxis/tree/master/beispiele/kleine-umgebung](/tree/master/beispiele/kleine-umgebung)

Dieses Beispiel enthält Code als Beispiel für die Strukturierung von Terraform-Konfigurationen für eine kleine Infrastruktur, bei der keine externen Abhängigkeiten verwendet werden.

{% hint style="info" %}
* Perfekt, um loszulegen und unterwegs umzugestalten
* Perfekt für kleine Ressourcenmodule
* Gut für kleine und lineare Infrastrukturmodule \(z.B. [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis)\)
* Gut für eine kleine Anzahl von Ressourcen \(weniger als 20-30\)
{% endhint %}

{% hint style="warning" %}
Eine einzelne Zustandsdatei für alle Ressourcen kann die Arbeit mit Terraform verlangsamen, wenn die Anzahl der Ressourcen wächst \(erwägen Sie die Verwendung des `-target`-Arguments, um die Anzahl der Ressourcen zu begrenzen\)
{% endhint %}

