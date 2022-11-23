data "azurerm_subnet" "team_subnet" {
  name                 = var.team_name
  resource_group_name  = var.global_resource_group_name
  virtual_network_name = "${var.global_resource_group_name}_vnet"
}

data "azurerm_network_security_group" "network_nsg" {
  name                = "${var.global_resource_group_name}-nsg"
  resource_group_name = var.global_resource_group_name
}


# Create public IPs
resource "azurerm_public_ip" "vm_ip" {
  location            = var.location
  resource_group_name = var.team_name

  name              = coalesce(var.Public_IP.name, "${var.VM.name}-public-ip")
  allocation_method = coalesce(var.Public_IP.allocation_method, "Dynamic")
  #tags              = var.tags
}

# Create network interface
resource "azurerm_network_interface" "vm_nic" {
  name                = coalesce(var.Network_Interface.name, "${var.VM.name}-nic")
  location            = coalesce(var.Network_Interface.location, var.location)
  resource_group_name = coalesce(var.Network_Interface.resource_group_name, var.team_name)
  ip_configuration {
    name                          = "${var.VM.name}-ip-configuration"
    subnet_id                     = data.azurerm_subnet.team_subnet.id
    private_ip_address_allocation = try(var.Network_Interface.ip_configuration.private_ip_address_allocation, "Dynamic")
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
  #tags = var.tags
  depends_on = [data.azurerm_subnet.team_subnet, azurerm_public_ip.vm_ip]
}

#  Connect network interface to security group
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = data.azurerm_network_security_group.network_nsg.id


  depends_on = [data.azurerm_network_security_group.network_nsg, azurerm_network_interface.vm_nic]
  #tags       = var.tags
}

data "azurerm_dns_zone" "yesodot_dns" {
  name                = "branch-yesodot.org"
  resource_group_name = "yesodotaks"
}


# create child zone
data "azurerm_dns_zone" "child_zone" {
  name                = "${var.team_name}.${data.azurerm_dns_zone.yesodot_dns.name}"
  resource_group_name = var.team_name

}

# Alias record for the public IP
resource "azurerm_dns_a_record" "vm_ip" {
  name                = var.VM.name
  zone_name           = data.azurerm_dns_zone.child_zone.name
  resource_group_name = var.team_name
  ttl                 = 300
  records             = [azurerm_public_ip.vm_ip.ip_address]
  #tags                = var.tags
  depends_on = [azurerm_public_ip.vm_ip]
}
