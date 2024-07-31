---
layout: home
title: Dynamische Resourcen
subtitle: Was tun, wenn man resourcen dynamisch erstellen muss?
---

In Terraform können Sie mithilfe von count und for_each mehrere ähnliche Ressourcen auf einmal erstellen, ohne für jede Ressource separate Blöcke schreiben zu müssen. Hier ist eine kurze Erklärung und einige Beispiele für beide:

    count
        Mit count können Sie eine bestimmte Anzahl von Instanzen einer Ressource erstellen.
        Die Ressourcen werden mit Indexen von 0 bis count-1 nummeriert.
        Beispiel:

        hcl

    resource "aws_instance" "example" {
      count = 5  # Erstellt 5 Instanzen

      # ... weitere Konfiguration ...
    }

for_each

    Mit for_each können Sie eine Menge von Werten angeben und für jeden Wert eine Ressource erstellen.
    Jede Ressource wird mit einem eindeutigen Schlüssel anstatt eines numerischen Index identifiziert.
    Beispiel:

    hcl

        resource "aws_instance" "example" {
          for_each = {
            a = "Wert1"
            b = "Wert2"
            c = "Wert3"
          }

          # Zugriff auf den aktuellen Wert:
          ami = each.value

          # ... weitere Konfiguration ...
        }

        Im obigen Beispiel wird für jeden Eintrag im Map (a, b und c) eine Instanz erstellt. Der Zugriff auf den aktuellen Schlüssel erfolgt über each.key und auf den aktuellen Wert über each.value.

Es ist zu beachten, dass count und for_each nicht zusammen in derselben Ressource verwendet werden können. Welche Methode Sie verwenden sollten, hängt von Ihrem speziellen Anwendungsfall und den Anforderungen ab. Generell ist for_each flexibler und besser für Fälle geeignet, in denen Sie eine dynamische Menge von Werten haben und jeder Wert eindeutig identifiziert werden muss.