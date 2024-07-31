#varialbe
```hcl
variable "partnerId" {
  description = "List of partner ID'S"
  type        = list(string)
  default     = ["1234", "4567", "8901"]
}
````

# cognito pool with dynamic
```hcl
resource "aws_cognito_user_pool" "mb_userpool" {
    name = "partners"
   
    dynamic "schema" {
        for_each = ["partnerId"]
        content {
        attribute_data_type = "String"
        name                = schema.value
        mutable             = false
        required            = false
    
    }
  ...

}
```
