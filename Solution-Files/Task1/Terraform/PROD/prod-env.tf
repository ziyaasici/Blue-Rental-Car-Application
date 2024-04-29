module "tf-ec2" {
    source = "../modules"
    environment = "PROD"
    instance_type = "t2.micro"
    keypair = "PROD-Keypair"
}

# output "name" {
#   module.
# }