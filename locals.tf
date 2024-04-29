locals {
  # Networking
  subnet_ids          = var.create_virtual_network ? azurerm_subnet.new_subnet.0.id : data.azurerm_subnet.existing_subnet.id
  vnet_resource_group = var.create_virtual_network && var.vnet_resource_group_name ? var.vnet_resource_group_name : azurerm_resource_group.container_group_rg

  # ACR
  acr_resource_group = var.create_acr && var.acr_resource_group_name ? var.acr_resource_group_name : azurerm_resource_group.container_group_rg
}
