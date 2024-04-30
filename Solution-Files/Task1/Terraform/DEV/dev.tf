module "DEV" {
  source = "../modules"
  environment = "test"
  instance_type = "test"
  ami = "test"
  key_name = "test"
  tags = {
    Name = "test"
  }
}

# output "public_ip" {
#   value = module.DEV.public_ip
# }