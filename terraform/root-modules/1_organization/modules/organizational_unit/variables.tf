variable "name" {
  description = "The name of the organizational unit"
  type        = string
}
variable "org_id" {
  description = "The top level organization id"
  type        = string
}
variable "accounts" {
  description = "A list of accounts to create within the organizational unit"
  type        = list(string)
}

