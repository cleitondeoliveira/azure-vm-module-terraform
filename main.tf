terraform {

   required_version = ">=0.12"

   required_providers {
     azurerm = {
       source = "hashicorp/azurerm"
       version = "~>2.0"
     }
   }
 }

provider "azurerm" {
  client_id           = var.client_id
  client_secret       = var.client_secret
  tenant_id           = var.tenant_id
  subscription_id     = var.subscription_id
  features {}
  
}

 data "azurerm_resource_group" "vm" {
   name     = var.rg-name
 }

 data "azurerm_virtual_network" "vm" {
   name                =  var.vnet
   resource_group_name =  var.vnet_rg
 }

 data "azurerm_subnet" "vm" {
   name                 = var.sub-name
   resource_group_name  = var.vnet_rg
   virtual_network_name = var.vnet
 }

 resource "azurerm_network_interface" "vm" {   
   name                = "${count.index}"
   location            = data.azurerm_resource_group.vm.location
   resource_group_name = data.azurerm_resource_group.vm.name

   ip_configuration {
     name                          = "vmConfiguration"
     subnet_id                     = var.sub-id
     private_ip_address_allocation = "dynamic"
   }
 }

 resource "azurerm_managed_disk" "vm" {   
   name                 = "${count.index}"
   location             = data.azurerm_resource_group.vm.location
   resource_group_name  = data.azurerm_resource_group.vm.name
   storage_account_type = ""
   create_option        = ""
   disk_size_gb         = ""
 }

 resource "azurerm_availability_set" "avset" {
   name                         = ""
   location                     = data.azurerm_resource_group.vm.location
   resource_group_name          = data.azurerm_resource_group.vm.name
   platform_fault_domain_count  = 2
   platform_update_domain_count = 2
   managed                      = true
 }

 resource "azurerm_virtual_machine" "vm" {   
   name                  = "${count.index}"
   location              = data.azurerm_resource_group.vm.location
   availability_set_id   = azurerm_availability_set.avset.id
   resource_group_name   = data.azurerm_resource_group.vm.name
   network_interface_ids = [element(azurerm_network_interface.vm.*.id, count.index)]
   vm_size               = "Standard_D2as_v4"

   # Uncomment this line to delete the OS disk automatically when deleting the VM
   # delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
   # delete_data_disks_on_termination = true

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "22.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "StandardSSD_LRS"
   }


   storage_data_disk {
     name            = element(azurerm_managed_disk.vm.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.vm.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.vm.*.disk_size_gb, count.index)
   }

   os_profile {
     computer_name  = "hostname"
     admin_username = ""
     admin_password = ""
   }

   os_profile_linux_config {
     disable_password_authentication = false
   }

   tags = {
     env = ""
     business_unit = ""
     client = ""
     product = ""
     vertical = ""
   }
 }