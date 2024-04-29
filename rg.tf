data "azurerm_client_config" "spn_client" {
}

resource "azurerm_resource_group" "container_group_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Use a role assignment to set the SPN as an owner on the resource group
# This will allow the SPN to change role assignments of resources contained in the group
resource "azurerm_role_assignment" "rg_owner" {
  scope                = azurerm_resource_group.container_group_rg.id
  role_definition_name = "Owner"
  principal_id         = data.azurerm_client_config.spn_client.object_id
}
