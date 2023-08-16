---
layout: home
title: Schlüßelkonzepte
subtitle: Ressourcen
---

Ein Terraform Ressource ist z.B. `aws_vpc`, `aws_db_instance` usw. Ressourcen gehört zum Provider, akzeptieren Argumente, geben Attribute aus, haben Lebenszyklen. Ressourcen können erstellt, abgerufen, aktualisiert und gelöscht werden.

## Seien Sie vorsichtig mit programmatisch generierten Ressourcennamen.

Ein Fallstrick, auf den fast jeder bei der Arbeit mit Terraform mindestens einmal stößt, ist das Problem der dynamischen Benennung von Ressourcen. Es ist sehr verlockend, einen algorithmischen Ansatz für die Generierung von Cloud-Ressourcennamen zu verwenden, und es scheint sinnvoll zu sein, dies auf der untersten Ebene zu tun. Sie könnten zum Beispiel versuchen, Variablen wie Umgebungsname, Anwendungsname und Region zu verwenden, um eine Flotte von Recheninstanzen dynamisch zu benennen.

> Das Problem dabei ist, was passiert, wenn Sie diesen Algorithmus jemals ändern müssen.


Denken Sie daran, dass Terraform nur lose mit Ihrer Cloud-Infrastruktur gekoppelt ist. Da die zugrunde liegende Plattform keine konsistenten Informationen darüber bereithält, was sich bei den bereitgestellten Ressourcen geändert hat, ist es Terraform nicht möglich, korrekt zu interpolieren, wenn sich der Name einer Ressource ändert.

Wenn Sie dynamisch Ressourcennamen in der Form `$application_$environment_$region_$count` generieren und Sie feststellen, dass Sie das Format in `$application_$environment_$region_$availabilityzone_$count` ändern müssen, wird Terraform die Infrastruktur, die mit der alten Namenskonvention erstellt wurde, nicht mehr verfolgen. An diesem Punkt müssen Sie entweder alle Instanzen manuell umbenennen, damit sie mit der neuen Namenskonvention übereinstimmen, oder Sie zerstören alle Instanzen und erlauben Terraform, einen neuen Satz zu erstellen. Dies ist besonders heimtückisch, wenn die dynamische Namensgebung in einem Modul auf sehr niedriger Ebene gehandhabt wird, das von mehreren Anwendungen im gesamten Unternehmen wiederverwendet wird; eine solche Änderung kann umfangreiche Aktualisierungen der Anwendungen in der gesamten Infrastruktur erforderlich machen.

>Um dies zu umgehen, sollten Sie, wenn Sie eine dynamische Benennung benötigen, sicherstellen, dass Sie die Benennungslogik im zusammengesetzten Anwendungsmodul und nicht auf der Ebene des Low-Level-Ressourcenmoduls behandeln, indem Sie den gesamten Ressourcennamen an das Low-Level-Modul übergeben. Auf diese Weise können Sie die Logik, die für die Handhabung der alten und neuen Infrastruktur erforderlich ist, auf der Anwendungsebene verwalten, wenn sich die Namenskonvention jemals ändert.


