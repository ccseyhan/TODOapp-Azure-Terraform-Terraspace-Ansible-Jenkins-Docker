resource "azurerm_virtual_machine" "vm" {
  name                             = var.vm_name
  location                         = var.location
  resource_group_name              = var.rg_name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  tags = {
    "name" = "${var.vm_name}"
    "environment" = "development"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.identity.id ]
  }

    storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = data.azurerm_ssh_public_key.ssh_public_key.public_key
    }
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  depends_on = [
    azurerm_public_ip.pip
  ]

  ip_configuration {
    name                          = "IPConfiguration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

data "azurerm_ssh_public_key" "ssh_public_key" {
  resource_group_name = var.ssh_key_rg
  name                = var.ssh_key_name
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.vm_name}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = "${var.vm_name}-identity"
  resource_group_name = var.rg_name
  location            = var.location
}

data "azurerm_subscription" "primary" {
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}