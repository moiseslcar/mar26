data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "zona_a" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}

data "aws_subnet" "zona_b" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1b"
}

locals {
  vpc_id        = data.aws_vpc.default.id
  subnet_zona_a = data.aws_subnet.zona_a.id
  subnet_zona_b = data.aws_subnet.zona_b.id
}
