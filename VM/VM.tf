# Create virtual machine
resource "azurerm_linux_virtual_machine" "user_vm" {
  name                  = var.VM.name
  location              = var.location
  resource_group_name   = var.team_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = coalesce(var.VM.size, "Standard_D2s_v3")
  priority              = "Spot"
  eviction_policy       = "Deallocate"


  os_disk {
    name                 = "${var.VM.name}-osdisk"
    caching              = try(var.VM.os_disk.caching, "ReadWrite")
    storage_account_type = try(var.VM.os_disk.storage_account_type, "Standard_LRS")
  }


  source_image_reference {
    publisher = try(var.VM.source_image_reference.publisher, "Canonical")
    offer     = try(var.VM.source_image_reference.offer, "UbuntuServer")
    sku       = try(var.VM.source_image_reference.sku, "18.04-LTS")
    version   = try(var.VM.source_image_reference.version, "latest")
  }

  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.vm-tls-key.public_key_openssh
  }
  #tags = var.tags
}

