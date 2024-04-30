variable "environment" {
  default = "DEFAULT"
}

variable "instance_type" {
  default = "DEFAULT"
}

variable "ami" {
  default = "DEFAULT"
}

variable "key_name" {
  default = "DEFAULT"
}

variable "ports" {
  default = [22, 80, 8080, 5000, 3000]
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "Blue-Rental"
  }
}