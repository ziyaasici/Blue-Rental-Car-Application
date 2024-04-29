module "tf-ec2" {
    source = "../modules"
    environment = "DEV"
    instance_type = "t2.micro"
    keypair = "DEV-Keypair"
}

# output "name" {
#   module.
# }