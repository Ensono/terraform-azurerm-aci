<!-- BEGIN_TF_DOCS -->
# PROJECT_NAME

DESCRIPTION:
---
Bootstraps the infrastructure for {{SELECT_APP_TYPE }}. 

Will be used within the provisioned pipeline for your application depending on the options you chose.

Pipeline implementation for infrastructure relies on workspaces, you can pass in whatever workspace you want from {{ SELECT_DEPLOYMENT_TYPE }} pipeline YAML.

PREREQUISITES:
---
Azure Subscripion
  - SPN 
    - Terraform will use this to perform the authentication for the API calls
    - you will need the `client_id, subscription_id, client_secret, tenant_id`

Terraform backend
  - resource group (can be manually created for the terraform remote state)
  - Blob storage container for the remote state management


USAGE:
---

To activate the terraform backend for running locally we need to initialise the SPN with env vars to ensure you are running the same way as the pipeline that will ultimately be running any incremental changes.

```bash
docker run -it --rm -v $(pwd):/opt/tf-lib amidostacks/ci-tf:latest /bin/bash
```

```bash 
export ARM_CLIENT_ID=xxxx \
ARM_CLIENT_SECRET=yyyyy \
ARM_SUBSCRIPTION_ID=yyyyy \
ARM_TENANT_ID=yyyyy
```

alternatively you can run `az login` 

To get up and running locally you will want to create  a `terraform.tfvars` file 
```bash
TFVAR_CONTENTS='''
vnet_id                 = "amido-stacks-vnet-uks-dev"
rg_name                 = "amido-stacks-rg-uks-dev"
resource_group_location = "uksouth"
name_company            = "amido"
name_project            = "stacks"
name_component          = "spa"
name_environment        = "dev" 
'''
$TFVAR_CONTENTS > terraform.tfvars
```

```
terraform workspace select dev || terraform workspace new dev
```

terraform init -backend-config=./backend.local.tfvars
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.lb_be_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_outbound_rule.lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_outbound_rule) | resource |
| [azurerm_monitor_diagnostic_setting.databricks_log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_zone.dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.db_dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.pe_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.private_subnet_nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.public_subnet_nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [databricks_group.project_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.project_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_user.rbac_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/user) | resource |
| [databricks_workspace_conf.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/workspace_conf) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_monitor_diagnostic_categories.adb_log_analytics_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.vnet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.pe_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [databricks_current_user.db](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/current_user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_rbac_users"></a> [add\_rbac\_users](#input\_add\_rbac\_users) | If set to true, the module will create databricks users and  group named 'project\_users' with the specified users as members, and grant workspace and SQL access to this group. Default is false. | `bool` | `true` | no |
| <a name="input_create_lb"></a> [create\_lb](#input\_create\_lb) | Deploy Databricks with a Load Balancer. | `bool` | `false` | no |
| <a name="input_create_nat"></a> [create\_nat](#input\_create\_nat) | Deploy Databricks with a NAT Gateway. | `bool` | `false` | no |
| <a name="input_create_pe_subnet"></a> [create\_pe\_subnet](#input\_create\_pe\_subnet) | Set to true if you need the module to create the private endpoint subnet. | `bool` | `false` | no |
| <a name="input_create_pip"></a> [create\_pip](#input\_create\_pip) | Create Databricks with a Public IP. | `bool` | `false` | no |
| <a name="input_create_subnets"></a> [create\_subnets](#input\_create\_subnets) | Set to true if you need the module to create the subnets for you. | `bool` | `false` | no |
| <a name="input_data_platform_log_analytics_workspace_id"></a> [data\_platform\_log\_analytics\_workspace\_id](#input\_data\_platform\_log\_analytics\_workspace\_id) | The Log Analytics Workspace used for the whole Data Platform. | `string` | `null` | no |
| <a name="input_databricks_group_display_name"></a> [databricks\_group\_display\_name](#input\_databricks\_group\_display\_name) | If 'add\_rbac\_users' set to true then specifies databricks group display name | `string` | `"project_users"` | no |
| <a name="input_databricks_sku"></a> [databricks\_sku](#input\_databricks\_sku) | The SKU to use for the databricks instance | `string` | `"premium"` | no |
| <a name="input_databricksws_diagnostic_setting_name"></a> [databricksws\_diagnostic\_setting\_name](#input\_databricksws\_diagnostic\_setting\_name) | The Databricks workspace diagnostic setting name. | `string` | `"Databricks to Log Analytics"` | no |
| <a name="input_dns_record_ttl"></a> [dns\_record\_ttl](#input\_dns\_record\_ttl) | TTL for DNS Record. | `number` | `300` | no |
| <a name="input_enable_databricksws_diagnostic"></a> [enable\_databricksws\_diagnostic](#input\_enable\_databricksws\_diagnostic) | Whether to enable diagnostic settings for the Azure Databricks workspace | `bool` | `false` | no |
| <a name="input_enable_enableDbfsFileBrowser"></a> [enable\_enableDbfsFileBrowser](#input\_enable\_enableDbfsFileBrowser) | Whether to enable Dbfs File browser for the Azure Databricks workspace | `bool` | `false` | no |
| <a name="input_enable_private_network"></a> [enable\_private\_network](#input\_enable\_private\_network) | Enable Secure Data Platform. | `bool` | `false` | no |
| <a name="input_enable_sql_access"></a> [enable\_sql\_access](#input\_enable\_sql\_access) | Whether to enable sql access for the databricks group | `bool` | `true` | no |
| <a name="input_enable_workspace_access"></a> [enable\_workspace\_access](#input\_enable\_workspace\_access) | Whether to enable workspace access for the databricks group | `bool` | `true` | no |
| <a name="input_managed_vnet"></a> [managed\_vnet](#input\_managed\_vnet) | Used to determine if Databricks is created in a managed vnet configuration. | `bool` | `false` | no |
| <a name="input_nat_idle_timeout"></a> [nat\_idle\_timeout](#input\_nat\_idle\_timeout) | Idle timeout period in minutes. | `number` | `10` | no |
| <a name="input_network_security_group_rules_required"></a> [network\_security\_group\_rules\_required](#input\_network\_security\_group\_rules\_required) | Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. | `string` | `"NoAzureDatabricksRules"` | no |
| <a name="input_pe_subnet_name"></a> [pe\_subnet\_name](#input\_pe\_subnet\_name) | Name of the Subnet used to provision Private Endpoints into. | `string` | `""` | no |
| <a name="input_pe_subnet_prefix"></a> [pe\_subnet\_prefix](#input\_pe\_subnet\_prefix) | IP Address Space fo the Private Endpoints Databricks Subnet. | `list(string)` | `[]` | no |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | Name of the Private Databricks Subnet. | `string` | `""` | no |
| <a name="input_private_subnet_prefix"></a> [private\_subnet\_prefix](#input\_private\_subnet\_prefix) | IP Address Space fo the Private Databricks Subnet. | `list(string)` | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enables or Disabled Public Access to Databricks Workspace. | `bool` | `true` | no |
| <a name="input_public_subnet_name"></a> [public\_subnet\_name](#input\_public\_subnet\_name) | Name of the Public Databricks Subnet. | `string` | `""` | no |
| <a name="input_public_subnet_prefix"></a> [public\_subnet\_prefix](#input\_public\_subnet\_prefix) | IP Address Space fo the Public Databricks Subnet. | `list(string)` | `[]` | no |
| <a name="input_rbac_databricks_users"></a> [rbac\_databricks\_users](#input\_rbac\_databricks\_users) | If 'add\_rbac\_users' set to true then specifies RBAC Databricks users | <pre>map(object({<br>    display_name = string<br>    user_name    = string<br>    active       = bool<br>  }))</pre> | `null` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of Resource group | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of resource group | `string` | n/a | yes |
| <a name="input_resource_namer"></a> [resource\_namer](#input\_resource\_namer) | User defined naming convention applied to all resources created as part of this module | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Map of tags to be applied to all resources created as part of this module | `map(string)` | `{}` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | List of Service Endpoints Enabled on the Subnet. | `list(string)` | <pre>[<br>  "Microsoft.AzureActiveDirectory",<br>  "Microsoft.KeyVault",<br>  "Microsoft.ServiceBus",<br>  "Microsoft.Sql",<br>  "Microsoft.Storage"<br>]</pre> | no |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | Address Prefix of the VNET. | `string` | `""` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET inwhich the Databricks Workspace will be provisioned. | `string` | `""` | no |
| <a name="input_vnet_resource_group"></a> [vnet\_resource\_group](#input\_vnet\_resource\_group) | The Resource Group which the VNET is provisioned. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_adb_databricks_id"></a> [adb\_databricks\_id](#output\_adb\_databricks\_id) | n/a |
| <a name="output_databricks_hosturl"></a> [databricks\_hosturl](#output\_databricks\_hosturl) | Azure Databricks HostUrl |
<!-- END_TF_DOCS -->