variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "name" {
  type    = string
  default = "devops-lab"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "key_name" {
  type        = string
  description = "Name of an existing EC2 key pair for SSH"
}

variable "admin_cidr" {
  type        = string
  description = "Your public IP in CIDR form, for example 203.0.113.7/32"
}
