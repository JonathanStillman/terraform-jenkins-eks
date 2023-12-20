# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # VPC name
  name = "jenkins-vpc"

  # CIDR block for VPC
  cidr = var.vpc_cidr

  # Availability Zones configuration
  azs = data.aws_availability_zones.azs.names

  # Public subnets configuration
  public_subnets = var.public_subnets
  map_public_ip_on_launch = true

  # Enable DNS hostnames
  enable_dns_hostnames = true

  # Tags for the VPC
  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  # Tags for public subnets
  public_subnet_tags = {
    Name = "jenkins-subnet"
  }
}

# Security Group
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  # Security Group name and description
  name        = "jenkins-sg"
  description = "Security Group for Jenkins Server"

  # VPC ID reference from the VPC module
  vpc_id      = module.vpc.vpc_id

  # Ingress rules for allowing traffic
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # Egress rule to allow all outbound traffic
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # Tags for the Security Group
  tags = {
    Name = "jenkins-sg"
  }
}

# EC2 Instance
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # EC2 Instance name
  name = "Jenkins-Server"

  # Instance type, key name, and other configurations
  instance_type               = var.instance_type
  key_name                    = "jenkins-server-key"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("jenkins-install.sh")
  availability_zone           = data.aws_availability_zones.azs.names[0]

  # Tags for the EC2 Instance
  tags = {
    Name        = "Jenkins-Server"
    Terraform   = "true"
    Environment = "dev"
  }
}
