resource "aws_instance" "public_instance" {
  ami                       = "ami-0ad21ae1d0696ad58"
  instance_type             = "t2.micro"
  subnet_id                 = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                  = "terraform"
  vpc_security_group_ids    = [aws_security_group.public_sg.id]

  tags = {
    Name = "Public_Instance"
  }
}



resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow inbound SSH and HTTP traffic"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "public_sg"
  }
}


