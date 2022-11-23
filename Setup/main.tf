data "azurerm_virtual_network" "global_vnet" {
  name                = coalesce(var.virtual_network_name, "${var.global_resource_group_name}_vnet")
  resource_group_name = var.global_resource_group_name
}

data "azurerm_subnet" "last_subnet" {
  name                 = data.azurerm_virtual_network.global_vnet.subnets[length(data.azurerm_virtual_network.global_vnet.subnets) - 1]
  resource_group_name  = var.global_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.global_vnet.name
}

data "azurerm_dns_zone" "yesodot_dns" {
  name                = "branch-yesodot.org"
  resource_group_name = "yesodotaks"
}

# Create subnet
resource "azurerm_subnet" "team_subnet" {
  name                 = coalesce(var.Subnet.name, var.team_name)
  virtual_network_name = data.azurerm_virtual_network.global_vnet.name
  address_prefixes     = [cidrsubnet(data.azurerm_virtual_network.global_vnet.address_space[0], 11, length(data.azurerm_virtual_network.global_vnet.subnets))]
  resource_group_name  = data.azurerm_virtual_network.global_vnet.resource_group_name

  depends_on = [
    data.azurerm_virtual_network.global_vnet
  ]
  #   tags = var.tags   
}


resource "azurerm_resource_group" "team_resource_group" {
  name     = var.team_name
  location = var.location
  #tags     = var.tags
}

# create child zone
resource "azurerm_dns_zone" "child_zone" {
  name                = "${var.team_name}.${data.azurerm_dns_zone.yesodot_dns.name}"
  resource_group_name = azurerm_resource_group.team_resource_group.name

}
