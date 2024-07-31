resource "azurerm_container_registry" "my_acr" {
  name = "dang12394"
  resource_group_name = azurerm_resource_group.name
  sku = "Basic"
  location = azurerm_resource_group.location
  admin_enabled = true
}

