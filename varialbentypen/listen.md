# Yaml Notation in Terraform format

The resolved value of variable "aws" is not appropriate: list of object

## Yaml

```
ports:
  -
    name: web
    protocol: TCP
    targetPort: 80
    nodePort: 8080
```

## Terraform

port = [
  {
    name = web
    protocol = “TCP”
    targetPort = 80
    nodePort = 8080
  }
]
