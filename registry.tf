resource "azurerm_container_registry" "my_acr" {
  name                = "dang12394"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  location            = var.region
  admin_enabled       = true
}
data "azurerm_container_registry" "my_acr" {
  name = "dang12394"
  resource_group_name = azurerm_resource_group.rg.name
}
