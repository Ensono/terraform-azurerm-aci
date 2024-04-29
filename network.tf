# For Existing Network Infrastructure
data "azurerm_resource_group" "existing_vnet_rg" {
  count = var.create_virtual_network ? 0 : 1
  name  = var.vnet_resource_group_name
}

data "azurerm_virtual_network" "existing_vnet" {
  count               = var.create_virtual_network ? 0 : 1
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.existing_vnet_rg.0.name
}

data "azurerm_subnet" "existing_subnet" {
  count                = var.create_virtual_network ? 0 : 1
  name                 = var.existing_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.0.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.0.resource_group_name
}

# For New Network Infrastructure
resource "azurerm_virtual_network" "new_vnet" {
  count               = var.create_virtual_network ? 1 : 0
  name                = var.vnet_name
  resource_group_name = local.vnet_resource_group_name
  address_space       = var.vnet_cidr
  location            = var.location # MUST be in the same location as the Azure Container Group
  depends_on          = [azurerm_resource_group.container_group_rg]
}

# May want to use For_each here so if var.subnet_names changes we wont remove subnets we don't wish to change.
resource "azurerm_subnet" "new_subnet" {
  count               = var.create_virtual_network ? length(var.new_subnet_names) : 0
  name                = var.new_subnet_names[count.index]
  resource_group_name = local.vnet_resource_group_name
  # this can stay referencing above as they get created or not together
  virtual_network_name = azurerm_virtual_network.new_vnet.0.name
  address_prefixes     = [local.subnet_prefixes[count.index]]
  depends_on           = [azurerm_virtual_network.new_vnet]
}
