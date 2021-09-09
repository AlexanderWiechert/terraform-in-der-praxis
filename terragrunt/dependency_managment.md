---
description: >-
  Mit Terrgrunt kann man die Abhängikeiten zwischen Modulen an einer zentralen Stelle übersichtlich verwalten und darstellen.
---

# Mit Terragrunt Abhängigkeiten verwalten

Mitunter ist es ein ganz schöner Aufwand die Abhängigkeiten zwischen Modulen besonders, wenn diese noch zusätzlich Submodule beinhalten, zu prüfen. Typischerweise werden Input Variablen über die `variables.tf` im Modul und Output Variablen über die `outputs.tf` angelegt. Zusätzlich müssen diese in der Modulkonfiguration in der `main.tf` konfiguriert werden. Also mindestens an drei Stellen. Mit jedem Submodule kommen weiter hinzu.  

Diese muss man nun leider trotz allen weiter konfigurieren, aber man bekommt mit Terragrunt diese in der `terragrunt.hcl` prominent dargestellt.

```
# Include parent terragrunt.hcl
include {
  path = find_in_parent_folders()
}

# Load module
terraform {
  source = "../../..//modules/webserver"
}

# Load VPC dependency
dependency vpc {
  config_path = "../vpc"
}

# Load DNS dependency
dependency dns {
  config_path = "../dns"
}


# Pass required inputs to module
inputs = merge(
  app_name = "my-fancy-product",
  {
    # VPC Inputs
    vpc_id              = dependency.vpc.outputs.vpc_id
    vpc_public_subnets  = dependency.vpc.outputs.public_subnets
    vpc_private_subnets = dependency.vpc.outputs.private_subnets

    # Route53 Inputs
    route53_public_zone_id  = dependency.dns.outputs.public_zone_id
    route53_private_zone_id = dependency.dns.outputs.private_zone_id
    route53_zone_name       = dependency.dns.outputs.zone_name

  }
)
```

## Inkludieren einer Abhängikeit

Das Statement dazu sieht recht einfach aus; nämlich `dependency` und der Name den ich dafür verwenden will. Sowie der Pfad zum Modul per  `config_pathPfad`.

```
dependency vpc {
  config_path = "../vpc"
}
```

Dann werden über die `inputs` eine Input-Variable definiert und diese werden hier zusätzlich mit den Abhängikeiten in eine Konfiguration für das Modul gemergt und somit verfügbar gemacht. Im Module sind diese dann üblicherweise über terraform verfügbar im Format `var.route53_zone_name` usw.
