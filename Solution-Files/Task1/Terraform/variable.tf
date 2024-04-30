variable "environment" {

}

variable "instance_type" {

}

variable "ami" {

}

variable "key_name" {

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