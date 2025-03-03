variable "availability_zone" {
  type = string
  description = "The Availability Zone to create the EBS volume in."
}

variable "instance_id" {
  type = string
  description = "The ID of the EC2 instance to attach the volume to."
}