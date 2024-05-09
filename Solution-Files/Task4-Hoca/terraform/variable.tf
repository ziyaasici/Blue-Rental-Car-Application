variable "myami" {
  type = map(string)
  default = {
    devops_team = "ami-08d4ac5b634553e16"
    dev_team  = "ami-08d4ac5b634553e16"
    test_team   = "ami-08d4ac5b634553e16"
  }
  description = "in order of Amazon Linux 2023 ami, Red Hat Enterprise Linux 8 ami and Ubuntu Server 20.04 LTS"
}

variable "region" {
  default = "us-east-1"  
}


variable "ec2_type" {
  default = "t2.micro"
}
variable "ec2_key" {
  default = "ziya2" # change here
}

variable "num_of_instance" {
  default = 1
}


variable "ports" {
  type = map(list(number))
  default = {
    default = [80, 443, 22, 8080, 6443, 30001, 3000]
    dev_team= [80, 443, 22, 8080, 6443, 30001, 3000]
    test_team= [80, 443, 22, 8080, 6443, 30001, 3000]
    devops_team= [80, 443, 22, 8080, 6443, 30001, 3000]
  }
}