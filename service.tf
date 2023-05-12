resource "aws_ecs_service" "demo_service" {
  name            = "demo_service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.demo_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = true

    subnets         = ["subnet-0c811582076540503", "subnet-0884158df4fabe73b"]
    security_groups = ["sg-0ffb7f7ab882aa8d2"]
  }
}


resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}
