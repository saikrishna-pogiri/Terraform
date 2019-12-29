#  ELB

resource "aws_elb" "CELB" {
 name = "classic-ELB"

  subnets = ["${aws_subnet.pub_subnet1.id}", "${aws_subnet.pub_subnet2.id}"]

  security_groups = ["${aws_security_group.elb.id}"]

   listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"

   }
   cross_zone_load_balancing = true
   health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30

   }

  }
