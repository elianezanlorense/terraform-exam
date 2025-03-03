variable "instance_type" {
  type = string
  description = "The EC2 instance type"
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet to launch the instance in."
}

variable "web_sg_id" {
  type = string
  description = "The ID of the web server security group."
}

variable "key_name" {
  type = string
  description = "The name of the SSH key pair to associate with the instance."
}

variable "ami_name_filter" {
  type = string
  description = "Filter to find AMI"
}

variable "ami_owners" {
    type = list(string)
    description = "AMI owners"
}

variable "availability_zone" {
  type = string
  description = "The Availability Zone to deploy in"
}