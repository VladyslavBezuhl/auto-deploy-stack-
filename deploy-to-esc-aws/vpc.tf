
module "vpc" {
   source = "terraform-aws-modules/vpc/aws"
   version = "5.1.1"


   name = "ecs-vpc"
   cidr = "10.0.0.0/16"


   azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
   public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
   private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


   enable_nat_gateway = true 
   single_nat_gateway = true
}
