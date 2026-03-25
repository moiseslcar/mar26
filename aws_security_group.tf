resource "aws_security_group" "bia-web" {
  description = "Acesso do bia web"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "All"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Liberado HTTPS"
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Liberado geral"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "acesso na porta 80"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = ["187.65.229.9/32"]
    description      = "Ip Mosley"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }]
  name                   = "bia-web"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0f920e5a0d3f0a5ca"
}

resource "aws_security_group" "bia-db" {
  description = "Acesso do bia db"
  egress = [{
    cidr_blocks      = []
    description      = "Acesso do bia web"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-0f161670b511836f2"]
    self             = false
    to_port          = 5432
  }]
  ingress = [{
    cidr_blocks      = []
    description      = "acesso do bia web"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-web.id]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do bia ec2"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-ec2.id]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do bia-dev"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-dev.id]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do bia-lambda"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-08f5988f3a70f611f"]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do bia-lambda-hom"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-075d811eeb8d0557b"]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do bia-lambda-prd"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-014d0fbbc6b2f8940"]
    self             = false
    to_port          = 5432
    }, {
    cidr_blocks      = []
    description      = "acesso do servidor de build"
    from_port        = 5432
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-01324514f0be8d073"]
    self             = false
    to_port          = 5432
  }]
  name                   = "bia-db"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0f920e5a0d3f0a5ca"
}

resource "aws_security_group" "bia-alb" {
  description = "acesso do bia alb"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = "Acesso apenas da ENI do Cloudfront"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-0273a6ae14e244729"]
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = []
    description      = "Acesso do bia-dev"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = ["sg-0308d881340c665a5"]
    self             = false
    to_port          = 80
  }]
  name                   = "bia-alb"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0f920e5a0d3f0a5ca"
}

resource "aws_security_group" "bia-ec2" {
  description = "acesso do bia ec2"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = "acesso vindo do bia alb"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.bia-alb.id]
    self             = false
    to_port          = 65535
  }]
  name                   = "bia-ec2"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0f920e5a0d3f0a5ca"
}

resource "aws_security_group" "bia-dev" {
  name        = "bia-dev"
  description = "acesso do bia-dev"
  vpc_id      = "vpc-0f920e5a0d3f0a5ca"

  ingress {
    description = "Acesso na porta 3001"
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