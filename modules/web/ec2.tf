resource "aws_instance" "my_ec2_instance" {
  ami           = data.aws_ami.latest_ubuntu_ami.id
  instance_type = "t2.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.key_pair.key_name

  associate_public_ip_address = true


  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y nginx

    systemctl enable --now nginx
    
    cat > /var/www/html/index.html <<'HTML'
    <h1>Nginx ok - provisionado via Terraform user_data</h1>
    HTML
  EOF

  root_block_device {
    volume_size = 8
    volume_type = "gp3"

    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "root-volume-ubuntu"
    }
  }
}