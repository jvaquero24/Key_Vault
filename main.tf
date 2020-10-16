data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}

resource"azurerm_key_vault""KEYVAULT" {
  name                = var.name_keyvault
  location            = var.location
  resource_group_name = data.azurerm_resource_group.RG.name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_keyvault
}
