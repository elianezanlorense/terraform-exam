variable "region" {
  type    = string
  default = "eu-west-3"
  description = "The AWS region to deploy to."
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
  description = "The EC2 instance type."
}

variable "db_instance_type" {
  type    = string
  default = "db.t3.micro"
  description = "The RDS database instance type."
}

variable "wordpress_db_name" {
  type    = string
  default = "wordpressdb"
  description = "The name of the WordPress database."
}

variable "wordpress_db_user" {
  type    = string
  default = "wpuser"
  description = "The username for the WordPress database."
}

variable "wordpress_db_password" {
  type    = string
  description = "The password for the WordPress database."
  sensitive = true  # Important: Mark as sensitive
  default="Pandora1"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones to use"
  default = ["eu-west-3a", "eu-west-3b"]
}

variable "ami_name_filter" {
  type    = string
  default = "amzn2-ami-hvm-*-x86_64-gp2" # Amazon Linux 2
  description = "Filter to find AMI"
}

variable "ami_owners" {
    type = list(string)
    default = ["amazon"]
    description = "AMI owners"
}

variable "key_name" {
  type    = string
  description = "The name of the SSH key pair to associate with the instance."
  default = "eli-key"
}

variable "domain_name" {
  type = string
  description = "Domain name for the wordpress site"
  default = "example.com"
}
