variable "Network_Interface" {
  type = object({
    name                = optional(string),
    location            = optional(string),
    resource_group_name = optional(string),
    ip_configuration = optional(object({
      private_ip_address_allocation = optional(string),
    }))
  })
  default = {
    name                = null,
    location            = null,
    resource_group_name = null,
    ip_configuration    = null
  }
}


variable "Public_IP" {
  type = object({
    name              = optional(string),
    allocation_method = optional(string),
  })
  default = {
    name              = null,
    allocation_method = null
  }

}



variable "VM" {
  type = list(object({
    name = string,
    size = optional(string),

    os_disk = optional(object({
      caching              = optional(string),
      storage_account_type = optional(string),
    })),

    source_image_reference = optional(
      object({
        publisher = optional(string),
        offer     = optional(string),
        sku       = optional(string),
        version   = optional(string),
    })),

    admin_username                  = optional(string),
    disable_password_authentication = optional(bool),

  }))

}



variable "global_resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "The location for the deployment"
  default     = "northeurope"
}


variable "team_name" {
  type = string
}


variable "tags" {

}
