variable "subscription_id" {
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}
variable "tenant_id" {
  default = ""
}

variable "location" {
  default = "East US"
}
variable "name" {
  default = ""
}
variable "vnet_rg" {
  default = ""
}
variable "vnet" {
  default = ""
}
variable "rg-name" {
  default = ""
}
variable "sub-name" {
  default = ""
}

variable "sub-id" {
  default = "/subscriptions//resourceGroups//providers/Microsoft.Network/virtualNetworks//subnets/"
}

variable "dns_zone" {
  default = ""
}