resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = var.inbound_ports_map
    iterator = item
    content {
      name                       = "Allow-${item.value}"
      priority                   = item.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = item.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
