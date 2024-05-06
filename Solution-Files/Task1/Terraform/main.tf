resource "aws_security_group" "ec2-sec-grp" {
  name        = "${var.environment}-Sec-Grp"
  description = "${var.environment} Security Group"
  tags = {
    Name = "${var.environment}-Sec-Grp"
  }

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = var.cidr
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }
}

resource "aws_instance" "ec2" {
  instance_type = var.instance_type
  ami = var.ami
  # ami = terraform.workspace != "PROD" ? lookup(var.ami, terraform.workspace) : data.aws_ami.al2023.id
  key_name = var.key_name
  # count = var.ec2_count
  vpc_security_group_ids = [aws_security_group.ec2-sec-grp.id]
  tags = {
    Project = "Blue-Rental-Car-Application-Project"
    Name = "Blue-Rental-${var.environment}"
  }
}
