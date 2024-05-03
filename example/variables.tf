variable "container_group_name" {
  type        = string
  description = "Name of the Azure Container Group"
}

variable "location" {
  type        = string
  description = "Location of the Azure Resource Group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group you wish to create."
}

variable "create_acr" {
  type        = bool
  description = "Whether to create Azure Container Registry"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "acr_resource_group_name" {
  type        = string
  default     = null
  description = "Name of the Resource Group that the new Azure Container Registry will de deployed OR where the existing Azure Container Registry exists."
}

variable "acr_location" {
  type        = string
  description = "Location of the Azure Container Registry"
}

variable "integrate_with_vnet" {
  type        = bool
  default     = false
  description = "Wether or not you wish to integrate your ACI Group with a virtual network or not. If not your IP address type must be public. Private ip address type if not integrated with a virtual network."
}

variable "create_virtual_network" {
  type        = bool
  default     = false
  description = "A boolean flag indicating whether to create a new virtual network. If set to true, a new virtual network will be created; if set to false, an existing virtual network will be used."
}

variable "vnet_name" {
  type        = string
  default     = null
  description = "Name of the new OR existing Virtual Network to integrate into the Azure Container Group. If integrate_virtual_network is set to true you MUST provide this."
}

variable "vnet_resource_group_name" {
  type        = string
  default     = null
  description = "Name of the new OR existing Resource Group that the Virtual Network is deployed withi; to integrate into the Azure Container Group."
}

variable "subnet_names" {
  type        = list(string)
  default     = null
  description = "List of names of new OR existing subnets to integrate into the Azure Container Group. If integrate_virtual_network and create_virtual_network is set to true you MUST provide this."
}
