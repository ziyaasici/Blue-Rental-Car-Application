variable "ami" {
  default     = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  default = "t3a.medium"
}

variable "key_name" {
  default = "DEFAULT"
}

variable "ports" {
  default = [22, 80, 443, 8080, 3000]
}

variable "cidr" {
  default = ["0.0.0.0/0"]  
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "Task4"
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "Blue-Rental"
  }
}