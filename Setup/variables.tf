variable "team_name" {
  type        = string
  description = "The name of the team"
}

variable "location" {
  type        = string
  description = "The location for the deployment"
  default     = "northeurope"
}

variable "virtual_network_name" {
  type    = string
  default = null
}


variable "global_resource_group_name" {
  type = string
}

variable "Subnet" {
  type = object(
    {
      name                = optional(string),
      resource_group_name = optional(string)
    }
  )
  default = {
    name                = null,
    resource_group_name = null
  }
}
