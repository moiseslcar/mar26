output "instance_id" {
  description = "ID da EC2"
  value       = aws_instance.example.id
}

output "instance_type" {
  description = "Tipo da instancia EC2"
  value       = aws_instance.example.instance_type
}

output "instance_security_groups" {
  description = "SG da EC2"
  value       = aws_instance.example.security_groups
}

output "instance_public_ip" {
  description = "IP público da EC2"
  value       = aws_instance.example.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do RDS da BIA"
  value       = aws_db_instance.bia.endpoint
}

output "rds_secrets" {
  description = "Secrets associado ao RDS"
  value       = tolist(aws_db_instance.bia.master_user_secret)[0].secret_arn
}

output "bia_repo_url" {
  value = aws_ecr_repository.bia.repository_url
}
