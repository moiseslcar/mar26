terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
    profile = "bia"
}

resource "aws_security_group" "bia-dev" {
  name        = "bia-dev-tf"
  description = "Regra  paa a instancia de trab bia-dev2 com tf"
  vpc_id      = "vpc-0f920e5a0d3f0a5ca"

  ingress {
    description = "Liberado 3001 para o mundo"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # all trafic
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
    ami           = "ami-02f3f602d23f1659d"
    instance_type = "t3.micro"
    tags = {
        Name = var.instance_name
        ambiente = "dev"
    }
    vpc_security_group_ids = [aws_security_group.bia-dev.id]
    root_block_device {
      volume_size = 10
    }
}