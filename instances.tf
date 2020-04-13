# INSTANCES

# Instance	vCPU*	Mem (GiB)	Storage	Dedicated EBS Bandwidth (Mbps)	Network Performance
# m4.large	2	8	EBS-only	450	Moderate
# m4.xlarge	4	16	EBS-only	750	High
# m4.2xlarge	8	32	EBS-only	1,000	High
# m4.4xlarge	16	64	EBS-only	2,000	High
# m4.10xlarge	40	160	EBS-only	4,000	10 Gigabit
# m4.16xlarge	64	256	EBS-only	10,000	25 Gigabit


resource "aws_instance" "ao" {
  count = var.ao_instance_count
  ami = var.aws_ami
  instance_type = "m4.2xlarge"
  key_name      = "AO_command"

root_block_device {
        volume_size = 80
  }


 ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 300
    volume_type           = "gp2"
    iops                  = 2000
    encrypted             = true
    delete_on_termination = true
  }

 tags = {
    Name     = "${var.server_base_name}-ao-${count.index +1 }"
    App = "AO"
    Role = "AO-cluster-node"
    Owner = var.owner_name
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,ebs_block_device
    ]
  }

}

