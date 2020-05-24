variable "public_key" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "admin_cidrs" {
  type    = list(string)
  default = []
}
