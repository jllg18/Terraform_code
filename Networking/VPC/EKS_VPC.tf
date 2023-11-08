resource "aws_vpc" "eks_vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_hostnames = true

 tags = {
    Name = "terraform-eks-vpc"
 }
}

output "vpc_id" {
  value       = "vpc.eks_vpc.id"
  sensitive   = true
  description = "output of vpc to will use it into eks cluster"
}


resource "aws_subnet" "public" {
 count                   = 2
 cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
 availability_zone       = data.aws_availability_zones.available.names[count.index]
 vpc_id                 = aws_vpc.eks_vpc.id
 map_public_ip_on_launch = true

 tags = {
    Name = "terraform-eks-public-subnet-${count.index}"
 }
}

output "public_subnet" {
    value = aws_subnet.public.*.id
}

resource "aws_subnet" "private" {
 count             = 2
 cidr_block        = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index + 2)
 availability_zone = data.aws_availability_zones.available.names[count.index]
 vpc_id            = aws_vpc.eks_vpc.id

 tags = {
    Name = "terraform-eks-private-subnet-${count.index}"
 }
}

output "subnet" {
    value = aws_subnet.private.*.id
}

data "aws_availability_zones" "available" {
 state = "available"

 filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
 }
}