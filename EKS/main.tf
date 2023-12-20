# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # VPC name and CIDR block
  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  # Availability Zones configuration
  azs = data.aws_availability_zones.azs.names

  # Private and public subnets configuration
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # Enable DNS hostnames, NAT Gateway, and use a single NAT Gateway
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  # Tags for the VPC
  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  # Tags for public subnets
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  # Tags for private subnets
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}

# EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  # Cluster name and version
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"

  # Allow public access to the EKS cluster endpoint
  cluster_endpoint_public_access = true

  # VPC and subnet configurations
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Managed node group configuration
  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_type = ["t2.small"]
    }
  }

  # Tags for the EKS Cluster
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
