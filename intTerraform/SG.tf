resource "aws_security_group" "web_ssh" {
  name        = "ssh-access(Blasse)"
  description = "open ssh traffic"
  vpc_id      = aws_vpc.KuraVpc.id
 

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "Web server001(Blasse)"
    "Terraform" : "true"
  }
  
}
