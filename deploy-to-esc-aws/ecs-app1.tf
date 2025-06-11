resource "aws_ecs_task_definition" "app1" {
  family                   = "app1-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256" #######
  memory                   = "512" ####### 
 
  container_definitions = jsonencode([
    {
      name      = "app1"
      image     = "vldnew/jambo2-app1:1.0.0"
      essential = true
      portMappings = [
        { containerPort = 5000, hostPort = 0 }
      ],
      environment = [
        { name = "VIRTUAL_HOST", value = "app1.localhost" }
      ]
    }
  ])
}

resource "aws_ecs_service" "app1" {
  name            = "app1-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app1.arn
  desired_count   = 2
  launch_type     = "EC2"
}
