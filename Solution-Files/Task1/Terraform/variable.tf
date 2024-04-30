variable "environment" {
  default     = "BlueRental"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-07caf09b362be10b8"
}

variable "key_name" {
  default = "ziya2"
}

variable "ports" {
  default = [22, 80, 8080, 5000, 3000]
}

variable "tags" {
  type        = map(string)
}