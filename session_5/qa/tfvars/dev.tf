env           = "dev"
instance_type = "t2.micro"
key_name      = "my_tf_key"
http_inbound_rule = "80"
ssh_inbound_rule = "22"
outbound_rule = "0"
#cidr_blocks = ["0.0.0.0/0"]
sg_name = "web_sg"
ingress_protocol = "tcp"
egress_protocol = "-1"
web_sg_tcp_ports = ["22", "3306", "80"]
web_sg_tcp_ports_cidr = ["0.0.0.0/0", "10.0.1.0/32", "10.0.2.0/32"]