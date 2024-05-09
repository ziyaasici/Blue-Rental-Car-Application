variable "instance_type" {
  default = "t3a.medium"
}

variable "key_name" {
  default = "Task4-Keypair"
}

variable "ports" {
  default = [22, 80, 443, 8080, 3000, 31001, 32001, 31000, 32000]
}

variable "cidr" {
  default = ["0.0.0.0/0"]  
}

variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "Blue-Rental"
  }
}