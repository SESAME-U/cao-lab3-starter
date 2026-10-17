# Autograder, Lab 3: the outputs, after a mocked apply.
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

run "outputs" {
  command = apply

  assert {
    condition     = output.public_ip == "20.10.20.30"
    error_message = "output public_ip must be the public IP address."
  }

  assert {
    condition     = output.web_url == "http://20.10.20.30"
    error_message = "output web_url must be \"http://<public IP>\"."
  }

  assert {
    condition     = strcontains(output.ssh_command, "azureuser@20.10.20.30")
    error_message = "output ssh_command must contain <admin_username>@<public IP>."
  }
}
