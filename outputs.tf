output "region" {
  value = var.region
}

output "acr_username" {
  value = azurerm_container_registry.my_acr.admin_username
}

output "acr_login" {
  value = azurerm_container_registry.my_acr.login_server
}

output "acr_password" {
  value     = azurerm_container_registry.my_acr.admin_password
  sensitive = true
}