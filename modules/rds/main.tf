resource "aws_db_instance" "db" {
  allocated_storage      = var.allocated_storage
  db_name                = var.wordpress_db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.db_instance_type
  username               = var.wordpress_db_user
  password               = var.wordpress_db_password
  vpc_security_group_ids = [var.db_sg_id]
  multi_az               = var.multi_az
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = var.subnet_group_name
  identifier             = var.instance_identifier

  tags = {
    Name = "wordpress-db"
  }
}
