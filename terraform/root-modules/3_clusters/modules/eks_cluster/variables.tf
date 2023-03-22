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

variable "cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "The CIDR to use for the cluster's VPC"
}

variable "name" {
  type        = string
  description = "The name of the cluter to create"
}

