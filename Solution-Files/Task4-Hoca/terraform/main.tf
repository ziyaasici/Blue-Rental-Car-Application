resource "aws_instance" "devops_project_instance" {
  ami= terraform.workspace != "default" ? lookup(var.myami, terraform.workspace) : data.aws_ami.al2023.id
  instance_type = var.ec2_type
  iam_instance_profile = "blue-rental-project-blue"
  key_name = var.ec2_key
  vpc_security_group_ids = [aws_security_group.devops-project-sgr.id]
  tags = {
    Name = "${terraform.workspace}_server"
     Project = "Blue-Rental-Car-Application-Project"
  }
}

resource "aws_security_group" "devops-project-sgr" {
  name        = "${terraform.workspace}-Security-Group"
  description = "Devops Project Security Group"

  dynamic "ingress" {
    for_each = lookup(var.ports, terraform.workspace)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    }
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}