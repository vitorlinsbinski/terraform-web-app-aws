output "instance_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

output "key_path" {
  value = local_file.ssh_key.filename
}
