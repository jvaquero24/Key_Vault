data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "AKV" {
  name                        = "testvault"
  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.RG.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.sku_keyvault

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}
