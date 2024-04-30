module "DEV" {
  source = "../modules"
  environment = "DEV"
  ami = "ami-07caf09b362be10b8"
  key_name = "ziya2"
  instance_type = "t2.micro"
}

# output "public_ip" {
#   value = module.DEV.public_ip
# }