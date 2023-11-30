variable "subscription_id" {
  default = "9b80411a-6b86-4903-b3c3-6de38998eeea"
}
variable "client_id" {
  default = "0861b574-93ac-4073-b1ee-a4ac0736336b"
}
variable "client_secret" {
  default = "c~u8Q~2YOZPLFI4SP4ef97bAlK6QsabCqUhcmaV9"
}
variable "tenant_id" {
  default = "81de5c69-22d5-4385-a4ab-c66da019ba52"
}

variable "location" {
  default = "East US"
}
variable "name" {
  default = "ksql"
}
variable "vnet_rg" {
  default = "rg-network-dev"
}
variable "vnet" {
  default = "vNetDefault"
}
variable "rg-name" {
  default = "rg-search-dev"
}
variable "sub-name" {
  default = "subNetVMs"
}

variable "sub-id" {
  default = "/subscriptions/9b80411a-6b86-4903-b3c3-6de38998eeea/resourceGroups/rg-network-dev/providers/Microsoft.Network/virtualNetworks/vNetDefault/subnets/subNetVMs"
}
# variable "tags" {
#   type = map
#   default = {
#     "Environment" = "prd"
#     "Project" = "cxaas"
#   }
# }
variable "dns_zone" {
  default = "typesense.ifcshopdev.net"
}
variable "ksqldb" {
  default = ["172.27.6.7", "172.27.6.8", "172.27.6.9"]
}