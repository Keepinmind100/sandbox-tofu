provider "aws" {
  region = "ap-northeast-2" # 서울 리전
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# subnet을 main vpc 에 붙인다.
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.100.0/24"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.200.0/24"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

