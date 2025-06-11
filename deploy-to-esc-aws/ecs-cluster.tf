# ecs_cluster.tf

resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
