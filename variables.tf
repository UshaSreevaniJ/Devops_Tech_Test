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

variable "public_subnet_range" {
  description = "IP Range of this subnet"
  type        = list(string)
}

variable "az_public" {
  description = "AZ of this subnet"
  type        = list(string)
}