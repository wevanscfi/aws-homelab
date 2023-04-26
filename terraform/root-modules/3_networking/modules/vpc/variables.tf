variable "env" {
  default     = "developement"
  type        = string
  description = "The enviornment that the cluster is being deployed in"
}

variable "networks" {
  description = "A dictionary of networks to create"
}

