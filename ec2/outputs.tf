output "wordpress_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "instance_id" {
  value = aws_instance.web_server.id
}

output "wordpress_url" {
  value = "http://${aws_instance.web_server.public_ip}"
}
