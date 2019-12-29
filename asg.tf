# Auto Scalling Launch Configuration

resource "aws_launch_configuration" "ASG-LC" {
name = "webserver-launchconfiguration"
 image_id = "${var.ami_type}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.ASG-LC.id}"]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install  httpd -y
              service httpd start
              chkconfig httpd on
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

}

# Auto Scalling security_groups

resource "aws_autoscaling_group" "ASG" {
name = "${var.project_name}-ASG"

min_size           = 1
desired_capacity   = 2
max_size           = 4

health_check_type = "ELB"
load_balancers = ["${aws_elb.CELB.id}"]

launch_configuration = "${aws_launch_configuration.ASG-LC.name}"
vpc_zone_identifier = ["${aws_subnet.pub_subnet1.id}", "${aws_subnet.pub_subnet2.id}"]



lifecycle {
 create_before_destroy = true

}

   tags {
     key                 = "Name"
    value               = "autoscalling1"
    propagate_at_launch = true
     }


 }
