resource "aws_instance" "app_node" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_node.id]
  subnet_id = var.sub
  
  tags = {
    Name = var.node_name
  }

}

output "instance_id" {
  value = aws_instance.app_node.id
}

resource "aws_security_group" "sg_node"{
    vpc_id = var.vpc_id
    name = var.sg_name
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

 ingress {
    from_port = var.ingress_port_1
    to_port = var.ingress_port_1
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = var.ingress_port_2
    to_port = var.ingress_port_2
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}