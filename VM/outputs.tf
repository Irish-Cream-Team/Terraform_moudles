output "vm_name" {
  value = azurerm_linux_virtual_machine.user_vm.name
}

output "vm_ip" {
    value = azurerm_linux_virtual_machine.user_vm.public_ip_address
}

output "vm_username" {
  value = azurerm_linux_virtual_machine.user_vm.admin_username
}


output "vm_admin_username" {
  value = azurerm_linux_virtual_machine.user_vm
}


output "vm_dns" {
    value = azurerm_dns_a_record.vm_ip
}