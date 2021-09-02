variable "security_group_name" {
  type = string
  default = "instance_sg"
}

variable "environment" {
  type = string
  default = "terraform"
}

variable "protocol" {
  type = string
  default = "tcp"
}

variable "label_order" {
  type = list(string)
  default = []
}

variable "vpc_id" {
  type = string
  default = "vpc-09d2f5e518c175100"
}

variable "allowed_ipv6" {
  type = list(string)
  default = []
}

variable "allowed_ports" {
  type = list(number)
  default = [22]
}

variable "instance_name" {
  type = string
  default = "terraform-created"
}

variable "instance_ami" {
  type = string
  default = "ami-0f8243a5175208e08"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "instance_key_name" {
  type = string
  default = "key-terraform-instance"
}

variable "instance_monitoring" {
  type = bool
  default = true
}

variable "subnet_id" {
  type = string
  default = "subnet-055f581ebf340bf67"
}
