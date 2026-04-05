resource "aws_db_instance" "bia" {
  identifier        = "bia"
  engine            = "postgres"
  engine_version    = "17.4"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  username = "postgres"
  # Ativa o gerenciamento automático de senha pelo Secrets Manager
  manage_master_user_password = true
  # a AWS usará a chave padrão do Secrets Manager se não definida.
  # master_user_secret_kms_key_id = null 

  port                = 5432
  publicly_accessible = false
  # db_subnet_group_name = "default"

  vpc_security_group_ids = [aws_security_group.bia-db.id]

  parameter_group_name = "default.postgres17"
  skip_final_snapshot  = true
  storage_encrypted    = true
  apply_immediately    = true

  tags = {
    Name = "bia-db"
  }
}
