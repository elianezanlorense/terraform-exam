output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "wordpress_db_name" {
  value = var.wordpress_db_name
}

output "wordpress_db_user" {
  value = var.wordpress_db_user
}

output "wordpress_db_password" {
  value = var.wordpress_db_password
}
