# ACG Outputs
output "container_group_name" {
  value = azurerm_container_group.default.name
}

output "container_group_id" {
  value = azurerm_container_group.default.id
}

output "container_group_location" {
  value = azurerm_container_group.default.location
}

output "container_group_resource_group_name" {
  value = azurerm_container_group.default.resource_group_name
}

output "container_group_os_type" {
  value = azurerm_container_group.default.os_type
}

output "container_group_sku" {
  value = azurerm_container_group.default.sku
}

output "container_group_ip_address" {
  value = azurerm_container_group.default.ip_address
}

output "container_group_subnet_ids" {
  value = azurerm_container_group.default.subnet_ids
}

output "container_group_ports" {
  value = azurerm_container_group.default.container.*.ports
}

output "container_group_tags" {
  value = azurerm_container_group.default.tags
}

