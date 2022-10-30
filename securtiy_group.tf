resource "aws_security_group" "sql_secgrp" {
  description = "From Terraform"
  ingress {
    cidr_blocks = [local.anywhere]
    from_port   = local.my_sql
    protocol    = local.protocol
    to_port     = local.my_sql
  }
  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
  tags = {
    "Name" = "sql_secgrp"
  }
}

resource "aws_security_group" "web_secgrp" {
  description = "From TF"
  ingress {
    cidr_blocks = [local.anywhere]
    from_port   = local.http_port
    protocol    = local.protocol
    to_port     = local.http_port
  }
  ingress {
    cidr_blocks = [local.anywhere]
    from_port   = local.open_ssh
    protocol    = local.protocol
    to_port     = local.open_ssh
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  vpc_id = module.vpc.vpc_id

  depends_on = [
    module.vpc,
    aws_security_group.sql_secgrp
  ]

  tags = {
    "Name" = "web_secgrp"
  }
}