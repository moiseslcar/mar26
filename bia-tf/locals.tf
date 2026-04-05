data "aws_vpc" "default" {
  default = true
}

locals {
  vpc_id = data.aws_vpc.default.id
}
