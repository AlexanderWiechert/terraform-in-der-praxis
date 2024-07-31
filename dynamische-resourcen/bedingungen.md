Erstellen Sie ein bedingtes Zählkriterium

Öffnen Sie `variables.tf` eine neue boolesche Variable und fügen Sie sie für hohe Verfügbarkeit hinzu.

```hcl
variable "high_availability" {
  type        = bool
  description = "If this is a multiple instance deployment, choose `true` to deploy 3 instances"
  default     = true
}
```
Als nächstes öffnen main.tfund aktualisieren Sie die aws_instanceRessource, um die neue high_availabilityVariable zu verwenden.

Aktualisieren Sie zunächst den Zählparameter mit einem bedingten Ausdruck basierend auf dem Wert von var.high_availability. Aktualisieren Sie dann den associate_public_ip_address Parameter, sodass nur der ersten Instanz eine öffentliche IP-Adresse zugewiesen wird. Zum Schluss führen Sie die Tags für die neuen Instanzen zusammen.

```hcl
resource "aws_instance" "ubuntu" {
  count                       = (var.high_availability == true ? 3 : 1)
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = (count.index == 0 ? true : false)
  subnet_id                   = aws_subnet.subnet_public.id
  tags                        = merge(local.common_tags)
}
```

condition ? true_val : false_val

|Zustand	|?	|wahrer Wert	|:	|falscher Wert|
|-----------|---|---------------|---|-------------|
|Wenn var.high_availabilityauf true gesetzt ist	|Dann	|Erstellen Sie drei aws_instanceRessourcen	|anders	|Erstellen Sie eine aws_instanceRessource
|Wenn count.indexist 0	|Dann	|Öffentliche IP zuweisen	|anders	|Weisen Sie keine öffentliche IP zu


___>

# if true
count      = var.use_staticOutgoingIp ? 1 : 0

#if false
count      = var.use_staticOutgoingIp ? 0 : 1

## varaible
variable "use_staticOutgoingIp" {
  type = bool
  default = true
}

# vpc setup based on bool
resource "aws_vpc" "lambda" {
  count      = var.use_staticOutgoingIp ? 1 : 0
  cidr_block = "10.72.0.0/16"
}

resource "aws_internet_gateway" "lambda" {
  count  = var.use_staticOutgoingIp ? 1 : 0
  vpc_id = aws_vpc.lambda[0].id
}

resource "aws_subnet" "lambdaPublic" {
  count      = var.use_staticOutgoingIp ? 1 : 0
  vpc_id     = aws_vpc.lambda[0].id
  cidr_block = "10.72.1.0/24"
}

# labmbda function based on bool

resource "aws_lambda_function" "m2p_diva_invoice_service" {
  function_name = "${var.project}-divaInvoiceService-${var.env}"
  filename      = data.archive_file.dummy.output_path
  role          = aws_iam_role.m2p_lambda_executer.arn
  description = "M2P Diva invoice service"
  handler     = "index.handler"
  runtime     = "nodejs12.x"
  timeout     = 300

  lifecycle {
    ignore_changes = [
      environment,
      filename,
      publish,
      last_modified]
  }

  dynamic "vpc_config" {
    for_each = aws_vpc.lambda
    content {
      security_group_ids = [
        aws_security_group.lambda[0].id]
      subnet_ids = [
        aws_subnet.lambdaPrivate[0].id]
    }
  }
}