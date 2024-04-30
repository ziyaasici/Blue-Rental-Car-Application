module "DEV" {
  source = "../modules"
  # environment = var.environment
  # instance_type = var.instance_type
  # ami = var.ami
  # key_name = var.key_name
  # tags = {
  #   Name = "Blue-Rental-${var.environment}"
  # }
}

# output "public_ip" {
#   value = module.DEV.public_ip
# }