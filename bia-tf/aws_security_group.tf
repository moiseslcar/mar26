resource "aws_security_group" "bia-web" {
  name        = "bia-web"
  description = "Acesso do bia web"
  vpc_id      = local.vpc_id

  ingress {
    description = "acesso na porta 80"
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

resource "aws_security_group" "bia-db" {
  name        = "bia-db"
  description = "Acesso do bia db"
  vpc_id      = local.vpc_id

  # Ingress centralizado: apenas componentes do projeto bia
  ingress {
    description = "Acesso Banco de Dados"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bia-web.id,
      aws_security_group.bia-ec2.id,
      aws_security_group.bia-dev.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bia-alb" {
  name        = "bia-alb"
  description = "acesso do bia alb"
  vpc_id      = local.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bia-ec2" {
  name        = "bia-ec2"
  description = "acesso do bia ec2"
  vpc_id      = local.vpc_id

  ingress {
    description     = "acesso vindo do bia alb"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.bia-alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bia-dev" {
  name        = "bia-dev"
  description = "acesso do bia-dev"
  vpc_id      = local.vpc_id

  ingress {
    description = "Acesso na porta 3001"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all trafic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
