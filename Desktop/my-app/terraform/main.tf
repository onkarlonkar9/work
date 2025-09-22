resource "aws_key_pair" "key" {
  key_name   = "terra-key-ec2"
  public_key = file("id_ed25519.pub")
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow SSH and Strapi"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi" {
  ami           = "ami-0851b76e8b1bce90b" # Ubuntu
  instance_type = var.instance_type
  key_name      = "terra-key-ec2"
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = file("${path.module}/docker.sh")

  tags = {
    Name = "Strapi-EC2-Ubuntu"
  }
}
