resource "aws_instance" "ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (Free tier eligible)
  instance_type = "t2.micro"  # Free tier eligible instance type

  tags = {
    Name = "MyFreeTierEC2Instance"
  }

  # This block is optional but recommended for security
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  # Provisioning with a key pair (if you want SSH access)
  key_name = aws_key_pair.my_key.key_name
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "free_tier_sg"

  ingress {
    from_port   = 22  # SSH
    to_port     = 22
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

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"  # Change to your preferred key name
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key
}
