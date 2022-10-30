resource "aws_instance" "web_ec2" {
  ami                         = "ami-017fecd1353bcc96e"
  instance_type               = "t2.micro"
  key_name                    = "KEY-1"
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.web_secgrp.id]

  depends_on = [
    aws_security_group.web_secgrp,
  ]

  tags = {
    "Name" = "My_EC2"
  }

}

resource "null_resource" "web_provision" {
    triggers = {
      running_number = local.web_trigger
    }
    provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_instance.web_ec2.public_ip
    }
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo apt install tree -y"
    ]

  }

  depends_on = [
    aws_instance.web_ec2
  ]
  
}

