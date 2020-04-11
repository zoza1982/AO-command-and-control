output "instances" {
  value=split(",", join(",", aws_instance.ao.*.public_ip))
}

