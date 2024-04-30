module "DEV" {
  source = "../modules"
  environment = "DEV"
}

# output "public_ip" {
#   value = module.DEV.public_ip
# }