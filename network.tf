# For Existing Network Infrastructure
data "azurerm_resource_group" "existing_vnet_rg" {
  count = var.create_virtual_network ? 0 : 1
  name  = var.vnet_resource_group_name
}

data "azurerm_virtual_network" "existing_vnet" {
  count               = var.create_virtual_network ? 0 : 1
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.existing_vnet_rg.name
}

data "azurerm_subnet" "existing_subnet" {
  count                = var.create_virtual_network ? 0 : 1
  name                 = var.existing_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
}

# For New Network Infrastructure
resource "azurerm_virtual_network" "new_vnet" {
  count               = var.create_virtual_network ? 1 : 0
  name                = var.vnet_name
  resource_group_name = local.vnet_resource_group.name
  address_space       = var.vnet_cidr
  location            = var.resource_group_location
  depends_on          = [azurerm_resource_group.default]
}

# May want to use For_each here so if var.subnet_names changes we wont remove subnets we don't wish to change.
resource "azurerm_subnet" "new_subnet" {
  count               = var.create_virtual_network ? length(var.new_subnet_names) : 0
  name                = var.new_subnet_names[count.index]
  resource_group_name = local.vnet_resource_group.name
  # this can stay referencing above as they get created or not together
  virtual_network_name = azurerm_virtual_network.new_vnet.0.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
  depends_on           = [azurerm_virtual_network.new_vnet]
}
