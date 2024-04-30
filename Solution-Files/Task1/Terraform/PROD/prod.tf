module "PROD" {
  source = "../modules"
  environment = "PROD"
}

output "public_ip" {
  value = module.PROD.public_ip
}