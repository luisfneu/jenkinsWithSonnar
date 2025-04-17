resource "aws_vpc" "poc-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "poc"
  }
}

# Subnets precisam estar liberadas para mapear o ip publico automaticamente para os nodes
resource "aws_subnet" "poc1-subnet" {
  vpc_id                  = aws_vpc.poc-vpc.id
  cidr_block              = var.poc1_subnet_cidr_block
  availability_zone       = var.poc1_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "poc1-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "poc2-subnet" {
  vpc_id                  = aws_vpc.poc-vpc.id
  cidr_block              = var.poc2_subnet_cidr_block
  availability_zone       = var.poc2_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "poc2-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_internet_gateway" "poc-gw" {
  vpc_id = aws_vpc.poc-vpc.id

  tags = {
    Name = "poc-gw"
  }
}

resource "aws_route_table" "poc-route-table" {
  vpc_id = aws_vpc.poc-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc-gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.poc-gw.id
  }


  tags = {
    Name = "poc-rt"
  }
}

resource "aws_route_table_association" "poc1-sub-to-poc-rt" {
  subnet_id      = aws_subnet.poc1-subnet.id
  route_table_id = aws_route_table.poc-route-table.id
}

resource "aws_route_table_association" "poc2-sub-to-poc-rt" {
  subnet_id      = aws_subnet.poc2-subnet.id
  route_table_id = aws_route_table.poc-route-table.id
}

resource "aws_security_group" "allow-web-traffic" {
  name        = "allow_tls"
  description = "libera o acesso a porta 443 e 80 pra web"
  vpc_id      = aws_vpc.poc-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-web"
  }
}