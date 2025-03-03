variable "wordpress_db_name" {
  type        = string
  description = "The name of the WordPress database."
}

variable "wordpress_db_user" {
  type        = string
  description = "The username for the WordPress database."
}

variable "wordpress_db_password" {
  type        = string
  description = "The password for the WordPress database."
  sensitive   = true
}

variable "db_instance_type" {
  type        = string
  description = "The RDS database instance type."
}

variable "db_sg_id" {
  type        = string
  description = "The ID of the database security group."
}

variable "subnet_group_name" {
  description = "The Subnets IDs of the RDS db."
  type        = string
}

variable "instance_identifier" {
  description = "The Subnets IDs of the RDS db."
  type        = string
  default     = "eli-wordpress"
}

variable "multi_az" {
  description = "The Subnets IDs of the RDS db."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "The Subnets IDs of the RDS db."
  type        = bool
  default     = true
}

variable "allocated_storage" {
  description = "The Subnets IDs of the RDS db."
  type        = number
  default     = 20
}

variable "engine" {
  type = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "8.0"
}