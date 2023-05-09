---
layout: home
title: Absicherung des Deployments
subtitle: Erforderlich sind ein einheitliches Authentifizierungsschema und ein Audit-Mechanismus, der eindeutig nachverfolgt, wer eine Terraform-Operation ausgelöst hat.
cover: /img/safeguarding.jpg
---

Dies ist eine Best Practice, die auf mehreren Ebenen einer Infrastructure-as-Code-Implementierung gehandhabt werden kann.

Wenn einzelne Infrastruktur Entwickler direkt gegen Ihre Cloud-Umgebung arbeiten, sollte dies auf der Authentifizierungs- und Autorisierungsebene für die Ziel-Cloud-Plattform gehandhabt werden.

Wenn Sie ein gemeinsames Continuous-Integration-Tool wie Jenkins für die Ausführung von Terraform-Code nutzen, sollte dies im CI/CD-Tool erfolgen. Mit dieser Best Practice soll sichergestellt werden, dass Ihre Terraform-Pipeline diskrete Zugriffskontroll- und Audit-Informationen für jeden Benutzer, der auf das System zugreifen kann, verwaltet und dass sie auch Informationen über jede Terraform-Ausführung aufzeichnet.

>Dazu sollte gehören, welcher Benutzer eine Aktualisierung Ihrer Cloud-Infrastruktur ausgelöst hat, wann sie ausgelöst wurde und welche Änderungen bei jeder einzelnen Ausführung vorgenommen wurden.


