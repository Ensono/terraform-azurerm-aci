# May currently be redundant as the data lookup below can simply pass the var.acr_resource_group_name value itself
data "azurerm_resource_group" "existing_acr_rg" {
  count = var.create_acr ? 0 : 1
  name  = var.acr_resource_group_name
}

# Description: This is fetched to allow a newly created ACI to have the contributor role assigned to the existing 
#              ACR to interact with container images.
data "azurerm_container_registry" "existing_acr" {
  count               = var.create_acr ? 0 : 1
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.existing_acr_rg.0.name
}

resource "azurerm_container_registry" "new_acr" {
  count               = var.create_acr ? 1 : 0
  name                = var.acr_name
  location            = var.acr_location
  resource_group_name = local.acr_resource_group_name
  admin_enabled       = var.acr_admin_enabled
  sku                 = var.acr_sku
}
