terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-2a"
  ami               = "ami-06858f33bbe384bbb"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  key_name      = "mykey"
  tags = {
    Name = "web"
  }

  connection {
    host = "${self.public_ip}"
    user = "admin"
    private_key = "${file("${var.private_key_path}")}"
  }

  provisioner "ansible" {
    plays {
        playbook {
          file_path = "../ansible/apache.yml"
        }
        hosts = ["${self.public_ip}"]
        become = "true"
    }
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



