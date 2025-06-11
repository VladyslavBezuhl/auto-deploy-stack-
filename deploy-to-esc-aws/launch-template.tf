resource "aws_launch_template" "ecs" {
  name_prefix   = "ecs-launch-template-"
  image_id      = "ami-0c22430d1de8481be" # ECS-optimized Amazon Linux 2 AMI
  instance_type = "t3.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
EOF
  )
}
