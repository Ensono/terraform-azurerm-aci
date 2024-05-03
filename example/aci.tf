module "aci" {
  source = "git::https://github.com/Ensono/terraform-azurerm-aci?ref=v0.1.1-alpha"

  # Azure Container Group (For Container Apps/Instances)
  container_group_name = var.container_group_name
  location             = var.location
  resource_group_name  = var.resource_group_name

  # Azure Container Registry
  create_acr              = var.create_acr
  acr_name                = var.acr_name
  acr_resource_group_name = var.acr_resource_group_name
  acr_location            = var.acr_location

  # Network
  integrate_with_vnet      = var.integrate_with_vnet
  create_virtual_network   = var.create_virtual_network
  vnet_name                = var.vnet_name
  vnet_resource_group_name = var.vnet_resource_group_name
  subnet_names             = var.subnet_names
}
