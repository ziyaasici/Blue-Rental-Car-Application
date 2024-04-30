module "STAG" {
  source = "../modules"
  environment = "STAG"
  ami = "ami-07caf09b362be10b8"
  key_name = "ziya2"
  instance_type = "t2.micro"
}

# output "public_ip" {
#   value = module.STAG.public_ip
# }