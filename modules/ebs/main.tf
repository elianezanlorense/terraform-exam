resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  size              = 10
  type              = "gp2"

  tags = {
    Name = "wordpress-data"
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = var.instance_id
  force_detach = true
}