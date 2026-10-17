variable "prefix" {
  description = "Short name used in every resource name."
  type        = string
  default     = "cao-lab3"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "westeurope"
}

variable "owner" {
  description = "Your GitHub username, used in tags so we know whose resources these are."
  type        = string
}

# Lab 3, Part C: add three variables (see the handout for the exact rules).
#
# TODO vm_size              string, default "Standard_B1s", with a validation
#                           block that accepts only Standard_B1s, Standard_B1ms
#                           and Standard_B2s
# TODO admin_username       string, default "azureuser"
# TODO ssh_public_key_path  string, default "~/.ssh/cao_lab.pub"
