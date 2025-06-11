resource "aws_ecs_task_definition" "traefik" {
  family                   = "traefik-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "512" ###### 0.5 cpu 
  memory                   = "1024" ###### 1G memory 

  container_definitions = jsonencode([
    {
      name      = "traefik"
      image     = "traefik:v2.10"
      essential = true
      command   = [
        "--api.insecure=true",
        "--providers.docker=true",
        "--entrypoints.web.address=:80",
        "--entrypoints.traefik.address=:8080",
        "--metrics.prometheus=true",
        "--metrics.prometheus.entryPoint=traefik"
      ],
      portMappings = [
        { containerPort = 80, hostPort = 80 },
        { containerPort = 443, hostPort = 443 },
        { containerPort = 8080, hostPort = 8080 }
      ],
      mountPoints = [
        {
          sourceVolume  = "docker_sock",
          containerPath = "/var/run/docker.sock",
          readOnly      = false
        }
      ],
      user = "0"
    }
  ])

  volume {
    name = "docker_sock"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_service" "traefik" {
  name            = "traefik-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.traefik.arn
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.traefik.arn
    container_name   = "traefik"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.frontend]
}
