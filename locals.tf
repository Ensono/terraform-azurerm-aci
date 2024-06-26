locals {
  # Networking
  subnet_ids                      = var.integrate_with_vnet ? (var.create_virtual_network ? azurerm_subnet.new_subnet.0.id : data.azurerm_subnet.existing_subnet.0.id) : ""
  subnet_prefixes                 = [cidrsubnet(var.vnet_cidr.0, 4, 0)]
  vnet_resource_group_name        = var.create_virtual_network && var.vnet_resource_group_name != null ? var.vnet_resource_group_name : azurerm_resource_group.container_group_rg.name
  container_group_ip_address_type = var.integrate_with_vnet ? "Private" : "Public"

  # ACR
  acr_resource_group_name = var.create_acr && var.acr_resource_group_name != null ? var.acr_resource_group_name : azurerm_resource_group.container_group_rg.name
}
