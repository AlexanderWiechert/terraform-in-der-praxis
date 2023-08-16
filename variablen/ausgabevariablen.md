---
layout: home
title: Variablen
subtitle: Welche Arten von Variablen gibt es in Terraform. Ein Übersicht.
---

# Ausgabevariablen
In Szenarien, in denen eine umfangreiche Webanwendungsinfrastruktur über Terraform bereitgestellt wird, besteht häufig der Bedarf an bestimmten Endpunkten, IP-Adressen, Datenbankbenutzeranmeldeinformationen und ähnlichen Daten. Diese Informationen sind neben anderen potenziellen Anwendungsfällen von großem Wert für die Übermittlung dieser Werte an Module.

> Diese Informationen sind auch in der Terraform state Datei verfügbar. Aber diese Dateien sind groß, und normalerweise müssten wir eine komplizierte Suche nach dieser Art von Informationen durchführen.
> Ausgabevariablen in Terraform werden verwendet, um nach einer erfolgreichen Anwendung der Konfiguration für das Root-Modul die erforderlichen Informationen in der Konsolenausgabe anzuzeigen.
```
output "instance_id" {
  value       = aws_instance.this.id
  description = "AWS EC2 instance ID"
  sensitive   = false
}
```
Nachdem wir Terraform angewendet haben, erhalten wir
```bash
Changes to Outputs:
  + instance_id = (sensitive value)
```
Wenn wir den **apply** Befehl ausführen, kennen wir nach erfolgreicher Erstellung der EC2-Instanz gleichermaßen deren Instanz-ID. Sobald die Bereitstellung erfolgreich ist, kann auf Ausgabevariablen auch mit dem folgenden **output** Befehl zugegriffen werden:
```bash
terraform output
instance_id = “i-xxxxxxxx”
```

