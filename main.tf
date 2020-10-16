data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}


resource "azurerm_key_vault" "resource_group_keyVault" {
  name = var.keyvault_name
  location = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = data.azurerm_resource_group.RG.name
  enabled_for_disk_encryption = true
  tenant_id = var.vtenant_id
  sku_name = "standard"

  access_policy {
    tenant_id = var.vtenant_id
    object_id = var.user_id_dgonzalez

    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "delete",
      "get",
      "list",
      "set"
    ]
  }
  access_policy {
    tenant_id = var.vtenant_id
    object_id = var.user_id_szabala

    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "delete",
      "get",
      "list",
      "set"
    ]
  }
  access_policy {
    tenant_id = var.vtenant_id
    object_id = var.user_id_seperez

    secret_permissions = [
      "get",
      "list"
    ]
  }

  access_policy {
    tenant_id = var.vtenant_id
    object_id = "${azurerm_data_factory.data_factory.identity[0].principal_id}"

    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "delete",
      "get",
      "list",
      "set"
    ]
  }
}
