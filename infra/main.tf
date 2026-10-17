# Lab 3: your infrastructure, declared.
#
# Part B: a locals block with the tags, and the resource group.
# Part C: the network and the web VM.
#
# The autograder looks for these resource addresses (type.name):
#
#   azurerm_resource_group.main
#   azurerm_virtual_network.main
#   azurerm_subnet.main
#   azurerm_network_security_group.web            (inline security_rule blocks)
#   azurerm_subnet_network_security_group_association.main
#   azurerm_public_ip.web
#   azurerm_network_interface.web
#   azurerm_linux_virtual_machine.web
#
# Write your resources below this line.
