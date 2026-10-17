# Autograder, Lab 3: the resources and their main settings.
# Runs without Azure: the azurerm provider is mocked, nothing is created.
# Editing this file does not change your grade: the instructor's copy is used.

mock_provider "azurerm" {
  # Mocked resources still go through the provider's checks, which expect
  # real Azure resource IDs: give each referenced resource a valid-looking one.
  mock_resource "azurerm_subnet" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet/subnets/snet"
    }
  }
  mock_resource "azurerm_network_security_group" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/networkSecurityGroups/nsg"
    }
  }
  mock_resource "azurerm_public_ip" {
    defaults = {
      id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/publicIPAddresses/pip"
      ip_address = "20.10.20.30"
    }
  }
  mock_resource "azurerm_network_interface" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/networkInterfaces/nic"
    }
  }
}

variables {
  owner               = "student"
  ssh_public_key_path = "./tests/fixtures/test_key.pub"
}

run "resources" {
  command = plan

  assert {
    condition     = azurerm_resource_group.main.location == "westeurope"
    error_message = "The resource group must be in var.location (default westeurope)."
  }

  assert {
    condition     = azurerm_resource_group.main.tags["course"] == "cao" && azurerm_resource_group.main.tags["owner"] == "student"
    error_message = "The resource group needs the tags course = \"cao\" and owner = var.owner."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.tags["owner"] == "student"
    error_message = "The VM needs the same tags as the resource group (owner = var.owner)."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.size == "Standard_B1s"
    error_message = "The VM size must come from var.vm_size (default Standard_B1s)."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.admin_username == "azureuser" && azurerm_linux_virtual_machine.web.disable_password_authentication
    error_message = "The VM must use admin_username = var.admin_username (azureuser) and SSH keys only."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.source_image_reference[0].offer == "ubuntu-24_04-lts"
    error_message = "The VM must run Ubuntu 24.04 (publisher Canonical, offer ubuntu-24_04-lts, sku server)."
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.custom_data != null
    error_message = "The VM must receive cloud-init.yaml as custom_data (base64-encoded)."
  }

  assert {
    condition     = azurerm_public_ip.web.allocation_method == "Static" && azurerm_public_ip.web.sku == "Standard"
    error_message = "The public IP must be Static with the Standard SKU."
  }

  assert {
    condition     = length([for r in azurerm_network_security_group.web.security_rule : r if r.destination_port_range == "80" && r.access == "Allow" && r.direction == "Inbound"]) == 1
    error_message = "The NSG needs one inline security_rule allowing inbound port 80."
  }

  assert {
    condition     = length([for r in azurerm_network_security_group.web.security_rule : r if r.destination_port_range == "22" && r.access == "Allow" && r.direction == "Inbound"]) == 1
    error_message = "The NSG needs one inline security_rule allowing inbound port 22."
  }

  assert {
    condition     = azurerm_subnet.main.virtual_network_name == azurerm_virtual_network.main.name
    error_message = "The subnet must belong to the virtual network azurerm_virtual_network.main."
  }
}
