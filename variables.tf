variable "region" {
  type        = string
}

variable "keypair" {
  description = "Adding the SSH authorized key"
  type        = string
}

variable "cidr_block" {
  description = "cidr for the vpc"
  type        = string
}