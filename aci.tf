resource "azurerm_container_group" "default" {
  # Required
  name                = var.container_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.container_group_rg.name
  os_type             = var.os_type

  # Optional
  sku             = var.container_group_sku
  ip_address_type = var.container_group_ip_address_type
  subnet_ids      = [local.subnet_ids]

  # This Block is required! For now we are using a placeholder until an idea on design is agreed.
  container {
    name   = "placeholder_container"
    image  = "nginx"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "Test"
  }
}
