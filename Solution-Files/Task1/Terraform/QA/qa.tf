module "QA" {
  source = "../modules"
  environment = "QA"
}

# output "public_ip" {
#   value = module.QA.public_ip
# }