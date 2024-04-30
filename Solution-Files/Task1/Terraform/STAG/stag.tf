module "STAG" {
  source = "../modules"
  environment = "STAG"
}

# output "public_ip" {
#   value = module.STAG.public_ip
# }