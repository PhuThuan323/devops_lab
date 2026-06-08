resource "aws_instance" "public_ec2" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  associate_public_ip_address = false

  tags = {
    Name = "private-ec2"
  }
}