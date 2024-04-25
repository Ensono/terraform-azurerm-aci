resource "azurerm_container_group" "default" {
  # Required
  name                = "example-continst"                      # (Required) Specifies the name of the Container Group. Changing this forces a new resource to be created.
  location            = azurerm_resource_group.example.location # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
  resource_group_name = azurerm_resource_group.example.name     # (Required) The name of the resource group in which to create the Container Group. Changing this forces a new resource to be created.
  os_type             = "Linux"                                 # (Required) The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created.

  # Optional
  sku             = "Standard" # (Optional) Specifies the sku of the Container Group. Possible values are Confidential, Dedicated and Standard. Defaults to Standard. Changing this forces a new resource to be created.
  exposed_port    = ""         # (Optional) Zero or more exposed_port blocks as defined below. Changing this forces a new resource to be created.
  ip_address_type = "Public"   # (Optional) Specifies the IP address type of the container. Public, Private or None. Changing this forces a new resource to be created. If set to Private, subnet_ids also needs to be set. Defaults to Public.
  subnet_ids      = [""]       # (Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created.
  priority        = ""         # (Optional) The priority of the Container Group. Possible values are Regular and Spot. Changing this forces a new resource to be created.
  restart_policy  = ""         # (Optional) Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created.
  zones           = [""]       # (Optional) A list of Availability Zones in which this Container Group is located. Changing this forces a new resource to be created.

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}
