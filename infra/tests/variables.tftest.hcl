# Autograder, Lab 3: the variables really drive the configuration.
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

run "other_size_and_region" {
  command = plan

  variables {
    vm_size  = "Standard_B2s"
    location = "francecentral"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.web.size == "Standard_B2s"
    error_message = "Changing var.vm_size must change the VM size."
  }

  assert {
    condition     = azurerm_resource_group.main.location == "francecentral" && azurerm_linux_virtual_machine.web.location == "francecentral"
    error_message = "Changing var.location must move every resource (use the resource group's location)."
  }
}

run "big_vm_refused" {
  command = plan

  variables {
    vm_size = "Standard_D64s_v5"
  }

  expect_failures = [var.vm_size]
}
