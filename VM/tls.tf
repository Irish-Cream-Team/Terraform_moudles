# Create (and display) an SSH key
resource "tls_private_key" "vm-tls-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


data "azurerm_key_vault" "azvault" {
  name                = "valut4yesodot"
  resource_group_name = "devops"
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "${var.VM.name}-private-key"
  value        = tls_private_key.vm-tls-key.private_key_openssh
  key_vault_id = data.azurerm_key_vault.azvault.id
  content_type = "application/x-pem-file"
  tags = {
    "belongs_to_vm"   = "${var.VM.name}",
    "belongs_to_user" = "${var.VM.name}",
    "belongs_to_team" = "${var.team_name}",
  }
  depends_on = [
    data.azurerm_key_vault.azvault
  ]
}
