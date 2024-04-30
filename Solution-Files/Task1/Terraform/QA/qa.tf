module "QA" {
  source = "../modules"
  environment = "QA"
  ami = "ami-07caf09b362be10b8"
  key_name = "ziya2"
  instance_type = "t2.micro"
}

# output "public_ip" {
#   value = module.QA.public_ip
# }