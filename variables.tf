# Resource Group Variables
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "acr_resource_group_name" {
  type        = string
  default     = null
  description = "The name of the resource group where the Azure Container Registry (ACR) should be created or where the existing ACR is located."
}

variable "vnet_resource_group_name" {
  type        = string
  default     = null
  description = "The name of the resource group where the virtual network should be created or where the existing virtual network is located."
}

# Azure Container Group Variables
variable "container_group_name" {
  type        = string
  description = "Name of your Azure Container Group."
}
variable "os_type" {
  type        = string
  default     = "Linux"
  description = "The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
}

variable "container_group_sku" {
  type        = string
  default     = "Standard"
  description = "Specifies the sku of the Container Group. Possible values are Confidential, Dedicated and Standard. Defaults to Standard. Changing this forces a new resource to be created."
}

# Azure Container Registry (ACR) Variables
variable "create_acr" {
  type        = bool
  description = "A boolean flag indicating whether to create a new Azure Container Registry (ACR). If set to true, a new ACR will be created; if set to false, an existing ACR will be used."
}

variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry (ACR)."
}

variable "acr_location" {
  type        = string
  description = "The location/region where the Azure Container Registry (ACR) should be created or where the existing ACR is located."
}

variable "acr_admin_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag indicating whether admin user should be enabled for the Azure Container Registry (ACR)."
}

variable "acr_sku" {
  type        = string
  default     = "Standard"
  description = "The SKU (pricing tier) of the Azure Container Registry (ACR)."
}

## Network Variables
# Virtual Network Varirables
variable "create_virtual_network" {
  type        = bool
  default     = false
  description = "A boolean flag indicating whether to create a new virtual network. If set to true, a new virtual network will be created; if set to false, an existing virtual network will be used."
}

variable "integrate_with_vnet" {
  type        = bool
  description = "Wether or not you wish to integrate your ACI Group with a virtual network or not. If not your IP address type must be public. Private ip address type if not integrated with a virtual network."
}

variable "vnet_cidr" {
  type        = list(string)
  default     = ["10.1.0.0/16"]
  description = "The CIDR block(s) to be used for the address space of the virtual network. This specifies the range of IP addresses available for the virtual network."
}

variable "vnet_name" {
  type        = string
  default     = null
  description = "The name of the virtual network."
}

variable "subnet_names" {
  type        = list(string)
  default     = null
  description = "The names of the subnets to be created within the virtual network, or exist witin the existing provided virtual network."
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "The CIDR block(s) to be used for the address space of each subnet within the virtual network."
  default     = null
}
