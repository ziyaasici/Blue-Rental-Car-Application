variable "environment" {
  default = "DEFAULT"
}

variable "instance_type" {
  default = "DEFAULT"
}

variable "ami" {
  default = "DEFAULT"
}

# variable "ami" {
#   type = map(string)
#   default = {
#     QA  = "ami-06640050dc3f556bb"
#     DEV   = "ami-08d4ac5b634553e16"
#     STAG = "ami-08d4ac5b634553e16"
#   }
#   description = "in order of Amazon Linux 2023 ami, Red Hat Enterprise Linux 8 ami and Ubuntu Server 20.04 LTS"
# }


variable "key_name" {
  default = "DEFAULT"
}

variable "count" {
  default = 1
}

variable "ports" {
  default = [22, 80, 8080, 5000, 3000]
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