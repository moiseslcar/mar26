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

resource "aws_instance" "example" {
    ami           = "ami-02f3f602d23f1659d"
    instance_type = "t3.micro"
    tags = {
        Name = "Exemplo"
        ambiente = "dev"
    }
}