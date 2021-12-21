output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.this_instance.*.public_ip
}

