resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "ecs-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = module.vpc.private_subnets
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
}
