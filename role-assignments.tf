# Description: Assigns the "Contributor" role to a principal (e.g., service principal, user, managed identity) 
#              on an Azure Container Registry (ACR) based on whether a new ACR is being created or an existing one is being used.
resource "azurerm_role_assignment" "acr" {
  scope                = var.create_acr ? azurerm_container_registry.new_acr.0.id : data.azurerm_container_registry.existing_acr.0.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_container_group.default.id # Might not work based on output of the ACG resource block
  depends_on = [
    azurerm_container_group.default
  ]
}
