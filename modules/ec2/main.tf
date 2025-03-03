data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ami_owners
}

resource "aws_key_pair" "wp_key" {
  key_name   = "eli-key"  
  public_key = file("${path.root}/eli-key.pub") 
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = aws_key_pair.wp_key.key_name 
  availability_zone      = var.availability_zone

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  user_data = file("${path.root}/install_wordpress.sh")

  tags = {
    Name = "wordpress-web-server"
  }
}

