terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-2a"
  ami               = "ami-00c03f7f7f2ec15c3"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  key_name      = "test"
  tags = {
    Name = "web"
  }
}

resource "aws_security_group" "sg" {  
  name = "web-sg"  
    
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

  ingress {    
    from_port   = 443    
    to_port     = 443    
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]  
  }
}