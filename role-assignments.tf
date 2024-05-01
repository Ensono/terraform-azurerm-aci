data "azurerm_client_config" "spn_client" {
}

# Use a role assignment to set the SPN as an owner on the resource group
# This will allow the SPN to change role assignments of resources contained in the group
# resource "azurerm_role_assignment" "rg_owner" {
#   scope                = azurerm_resource_group.container_group_rg.id
#   role_definition_name = "Owner"
#   principal_id         = data.azurerm_client_config.spn_client.object_id
# }

# # Description: Assigns the "Contributor" role to a principal (e.g., service principal, user, managed identity) 
# #              on an Azure Container Registry (ACR) based on whether a new ACR is being created or an existing one is being used.
# resource "azurerm_role_assignment" "acr_contributor" {
#   scope                = var.create_acr ? azurerm_container_registry.new_acr.0.id : data.azurerm_container_registry.existing_acr.0.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_container_group.default.id # Might not work based on output of the ACG resource block
#   depends_on = [
#     azurerm_container_group.default
#   ]
# }
