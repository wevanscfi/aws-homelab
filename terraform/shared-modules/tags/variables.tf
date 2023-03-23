variable "env" {
  description = "The environment this resource is associated with (development, staging, production, tools)"
  type        = string
}
variable "criticality" {
  description = "The business impact this resource has (low, medium, high)"
  type        = string
}
variable "owner" {
  description = "The team that owns this resource"
  type        = string
}
variable "data_classification" {
  description = "The level of data classification the resource contains, or grants access to (sensisitive, confidential, customer-confidential)"
  type        = string
}

