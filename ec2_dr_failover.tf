# 1. Define the Provider
provider "aws" {
  region = "us-east-1"
}

# 2. Security Group allowing essential traffic
resource "aws_security_group" "dr_sg" {
  name        = "disaster-recovery-sg"
  description = "Allow SSH and Web traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# 3. Create the Primary EC2 Instance (Active)
resource "aws_instance" "primary" {
  ami           = "ami-08ddded491c27c224" # Replace with your region's AMI
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dr_sg.id]

  tags = {
    Name = "Primary-Active"
  }
}

# 4. Create the Standby EC2 Instance (Failover)
resource "aws_instance" "standby" {
  ami           = "ami-08ddded491c27c224"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dr_sg.id]

  tags = {
    Name = "Standby-Failover"
  }
}

# 5. Provision the Elastic IP
resource "aws_eip" "floating_ip" {
  domain = "vpc"
}

# 6. Associate EIP with Primary Instance by default
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.primary.id
  allocation_id = aws_eip.floating_ip.id
}