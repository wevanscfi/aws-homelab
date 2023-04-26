variable "cluster_version" {
  default     = "1.25"
  type        = string
  description = "The K8s version to use for the cluster"
}

variable "env" {
  default     = "developement"
  type        = string
  description = "The enviornment that the cluster is being deployed in"
}

variable "name" {
  type        = string
  description = "The name of the cluter to create"
}

