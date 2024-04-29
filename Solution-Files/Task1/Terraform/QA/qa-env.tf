module "tf-ec2" {
    source = "../modules"
    environment = "QA"
    instance_type = "t2.micro"
    keypair = "QA-Keypair"
}

# output "name" {
#   module.
# }