<!-- BEGIN_TF_DOCS -->
# Terraform-AzureRM-ACI

DESCRIPTION:
---
Bootstraps the Azure Container Instance Infrastructure. 

Will be used within the provisioned pipeline for your application depending on the options you chose.

Pipeline implementation for infrastructure relies on workspaces, you can pass in whatever workspace you want from {{ SELECT_DEPLOYMENT_TYPE }} pipeline YAML.

PREREQUISITES:
---
**Azure Subscription**
  - *Service Principal* (SPN)
    - Terraform will use this to perform the authentication for the API calls
    - You will need the `client_id, subscription_id, client_secret, tenant_id`
    - Bash Example:
      ```bash 
      export ARM_CLIENT_ID=xxxx \
             ARM_CLIENT_SECRET=yyyyy \
             ARM_SUBSCRIPTION_ID=yyyyy \
             ARM_TENANT_ID=yyyyy
      ```
    - PowerShell Example:
      ```pwsh 
      $ARM_CLIENT_ID=xxxx
      $ARM_CLIENT_SECRET=yyyyy
      $ARM_SUBSCRIPTION_ID=yyyyy
      $ARM_TENANT_ID=yyyyy
      ```

**Terraform Backend**
  - Resource group (can be manually created for the terraform remote state)
  - Blob storage container within a storage account for the remote state management
  - Ensure you have set up your `backend.tf` file within your root directory (where you are using this module) unless you wish your terraform state to remain local.
    - **IMPORTANT: Ensure you are putting this in your .gitignore to ensure you are not passing sensitive values into your repositories!!**
  - Example TF Backend File:
    ```
    terraform {
      backend "azurerm" {
        resource_group_name  = "ResourceGroupName"  # Name of the resource group that your storage account resides in.
        storage_account_name = "StorageAccountName" # Name of the storage account for your terraform state file.
        container_name       = "tfstate"            # What your container name within the storage account is called.
        key                  = "terraform.tfstate"  # What your state output will be named.
      }
    }
    ```


USAGE:
---

To activate the terraform backend for running locally we need to initialise the SPN with env vars to ensure you are running the same way as the pipeline that will ultimately be running any incremental changes.
### **1. Create your `terraform.tfvars` file**

To get up and running locally you will want to create  a `terraform.tfvars` file. 

**Important: See the below instructions for more details on the content of your terraform.tfvars file and what the impact when running the module**

For the most basic Azure Container Instance set up, use the below `terraform.tfvars` set up. This includes minimal features and no virtual network integration:

- **PowerShell Example:**
```pwsh
# Define your variables
$TFVAR_CONTENTS = @'
vnet_id                 = "amido-stacks-vnet-uks-dev"
rg_name                 = "amido-stacks-rg-uks-dev"
resource_group_location = "uksouth"
name_company            = "amido"
name_project            = "stacks"
name_component          = "spa"
name_environment        = "dev" 
'@

# Write the content to a file
$TFVAR_CONTENTS | Set-Content -Path "terraform.tfvars"
```
- **Bash Example:**
```bash
# Define your variables
TFVAR_CONTENTS='''
vnet_id                 = "amido-stacks-vnet-uks-dev"
rg_name                 = "amido-stacks-rg-uks-dev"
resource_group_location = "uksouth"
name_company            = "amido"
name_project            = "stacks"
name_component          = "spa"
name_environment        = "dev" 
'''
# Write the content to a file
$TFVAR_CONTENTS > terraform.tfvars
```

### **2. Initialize your container**

- Ensure you are running the below terminal commands in the directory that contain the files you wish to emulate within the container, e.g. `~\stacks-projects\dchambers-web` to import all files into my container:
    

| Local Files in Repo    | Files Copied to Container |
|------------------------|---------------------------|
|![alt text](image-1.png)|![alt text](image-2.png)   |

Then you can initialize your container (if you wish to use containers, ensure you have docker desktop)
  - **Bash Example**
    ```docker
    docker run -it --rm -v $(pwd):/opt/tf-lib amidostacks/ci-tf:latest /bin/bash
    ```
  - **PowerShell Example**
    ```docker
    docker run -it --rm -v ${PWD}:/app amidostacks/runner-pwsh:0.4.60-stable pwsh
    ```

### **3. Export your authorization Credentials OR Login via Az CLI**
- **Bash Example:**
  ```bash 
  export ARM_CLIENT_ID=xxxx \
         ARM_CLIENT_SECRET=yyyyy \
         ARM_SUBSCRIPTION_ID=yyyyy \
         ARM_TENANT_ID=yyyyy
  ```

- **PowerShell Example:**
  ```pwsh 
  $ARM_CLIENT_ID=xxxx
  $ARM_CLIENT_SECRET=yyyyy
  $ARM_SUBSCRIPTION_ID=yyyyy
  $ARM_TENANT_ID=yyyyy
  ```

- **Az CLI Example:**
  ```
  az login
  ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Inputs (For Env Variables `TF_VAR_*` or `terraform.tfvars`)

| Name                    | Description                                                                 | Type           | Default | Example | Passing Required for Basic Deployment? | Passing Required for VNET Integration Deployment? |
|-------------------------|-----------------------------------------------------------------------------|----------------|---------|---------|---------------------------|--------------------------------------|
| container_group_name    | Name of the Azure Container Group                                           | string         | -       | "my_container_group" | `true`  | `true`                               |
| location                | Location of the Azure Resource Group                                        | string         | -       | "UKSouth" | `true`  | `true`                               |
| resource_group_name     | Name of the Azure Resource Group you wish to create.                        | string         | -       | "my_rg"   | `true`  | `true`                               |
| os_type                 | The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created. | string | Linux |"Windows"|`false`|`false`|
| container_group_sku     | Specifies the SKU of the Container Group. Possible values are Confidential, Dedicated, and Standard. Defaults to Standard. Changing this forces a new resource to be created. | string | Standard |"Confidential"|`false`|`false`|
| acr_admin_enabled       | A boolean flag indicating whether admin user should be enabled for the Azure Container Registry (ACR). | bool | true |true|`false`|`false`|
| acr_sku                 | The SKU (pricing tier) of the Azure Container Registry (ACR).               | string         | Standard |"Premium"|`false`|`false`|
| acr_resource_group_name | The name of the resource group where the Azure Container Registry (ACR) should be created or where the existing ACR is located. | string | null |"my_acr_rg"|`false`|`false`|
| acr_name                | Name of the Azure Container Registry you wish to create or to reference an existing ACR.| string | - | "my_acr" | `true` | `true` |
| acr_location            | Location of the Azure Container Registry                                    | string         | -       | "UKSouth" | `true`  | `true`                               |
| create_acr              | Whether to create Azure Container Registry                                  | bool           | -       | true      | `true`  | `true`                               |
| create_virtual_network | A boolean flag indicating whether to create a new virtual network. If set to true, a new virtual network will be created; if set to false, an existing virtual network will be used. | bool | false | false | `false` | `true` |
| integrate_with_vnet     | Whether or not you wish to integrate your ACI Group with a virtual network or not. If not, your IP address type must be public. Private IP address type if not integrated with a virtual network. | bool | - | false | `true` | `true` |
| vnet_name               | Name of the new OR existing Virtual Network to integrate into the Azure Container Group. If create_virtual_network is set to true you MUST provide this. | string | null | "my_vnet" | `false` | `true` |
| vnet_resource_group_name | The name of the resource group where the virtual network should be created or which resource group the existing virtual network is located. | string | null |"my_vnet_rg"|`false`|`false`|
| vnet_cidr               | The CIDR block(s) to be used for the address space of the virtual network. This specifies the range of IP addresses available for the virtual network. | list(string) | ["10.1.0.0/16"] | ["10.10.0.0/16"] |`false`|`true`|
| subnet_names            | List of names of new OR existing subnets to integrate into the Azure Container Group. If create_virtual_network is set to true you MUST provide this. | list(string) | null | ["my_subnet1", "my_subnet2"] | `false` | `true` |
| subnet_prefixes         | The CIDR block(s) to be used for the address space of each subnet within the virtual network. If left blank, this is calculated for you via the `locals.tf` file. | list(string) | null | ["10.10.0.0/24"] | - | - |

## Example `terraform.tfvars` for a simple Basic ACI Deployment (without Vnet Integration)
```bash
container_group_name = "my_acg"
location             = "uksouth"
resource_group_name  = "my_rg"

create_acr   = true
acr_name     = "my_acr"
acr_location = "uksouth"

integrate_with_vnet = false
```

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_adb_databricks_id"></a> [adb\_databricks\_id](#output\_adb\_databricks\_id) | n/a |
| <a name="output_databricks_hosturl"></a> [databricks\_hosturl](#output\_databricks\_hosturl) | Azure Databricks HostUrl |
<!-- END_TF_DOCS -->