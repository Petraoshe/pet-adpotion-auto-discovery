# CREATE VPC
resource "aws_vpc" "PACAAD1_VPC" {
  cidr_block       = var.VPC_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.VPC_name
  }
}
# CREATE PUBLIC SUBNET1

resource "aws_subnet" "PACAAD1_PUB_SN1" {
  vpc_id            = aws_vpc.PACAAD1_VPC.id
  cidr_block        = var.PUB_SN1_cidr
  availability_zone = var.az_A
  tags = {
    Name = var.PUB_SN1_name
  }
}



##################################################################
# PUBLIC SUBNET 2
##################################################################

#CREATE PUBLIC SUBNET2

resource "aws_subnet" "PACAAD1_PUB_SN2" {
  vpc_id            = aws_vpc.PACAAD1_VPC.id
  cidr_block        = var.PUB_SN2_cidr
  availability_zone = var.az_B

  tags = {
    Name = var.PUB_SN2_name
  }
}

##################################################################
# PRIVATE SUBNET 1
##################################################################

#CREATE PRIVATE SUBNET1

resource "aws_subnet" "PACAAD1_PRV_SN1" {
  vpc_id            = aws_vpc.PACAAD1_VPC.id
  cidr_block        = var.PRV_SN1_cidr
  availability_zone = var.az_A

  tags = {
    Name = var.PRV_SN1_name
  }
}


##################################################################
# PRIVATE SUBNET 2
##################################################################

#CREATE PRIVATE SUBNET2
resource "aws_subnet" "PACAAD1_PRV_SN2" {
  vpc_id            = aws_vpc.PACAAD1_VPC.id
  cidr_block        = var.PRV_SN2_cidr
  availability_zone = var.az_B

  tags = {
    Name = var.PRV_SN2_name
  }
}
# INTERNET GATEWAY (IGW)
##################################################################
#CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "PACAAD1_IGW" {
  vpc_id = aws_vpc.PACAAD1_VPC.id
  tags = {
    Name = var.IGW_name
  }
}
# ELASTIC IP
##################################################################
#CREATE ELASTIC IP FOR NATGw
resource "aws_eip" "PACAAD1_EIP" {
  depends_on = [aws_internet_gateway.PACAAD1_IGW]
  vpc = true
  tags = {
    Name = var.EIP_name
  }
}

# NAT GATEWAY (NAT-GW)
##################################################################
#CREATE NAT GATEWAY FOR PRIVATE SUBNET
resource "aws_nat_gateway" "PACAAD1_NAT_GW" {
  allocation_id = aws_eip.PACAAD1_EIP.id
  subnet_id     = aws_subnet.PACAAD1_PUB_SN1.id
  tags = {
    Name = var.NAT_name
  }
}
#CREATE PUBLIC ROUTE TABLE
resource "aws_route_table" "PACAAD1_PUB_RT" {
  vpc_id = aws_vpc.PACAAD1_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.PACAAD1_IGW.id
  }
  tags = {
    Name = var.PUB_RT_name
  }
}
#CREATE PUBLIC Sbnt1 w/Pub ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "PACAAD1_PUB_SN1_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_PUB_SN1.id
  route_table_id = aws_route_table.PACAAD1_PUB_RT.id
}
#CREATE PUBLIC Sbnt2 w/Pub ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "PACAAD1_PUB_SN2_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_PUB_SN2.id
  route_table_id = aws_route_table.PACAAD1_PUB_RT.id
}
#CREATE PRIVATE ROUTE TABLE
resource "aws_route_table" "PACAAD1_PRV_RT" {
  vpc_id = aws_vpc.PACAAD1_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_nat_gateway.PACAAD1_NAT_GW.id
  }
  tags = {
    Name = var.PRV_RT_name
  }
}
#CREATE PRIVATE Sbnt1 w/Prv ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "PACAAD1_PRV_SN1_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_PRV_SN1.id
  route_table_id = aws_route_table.PACAAD1_PRV_RT.id
}
#CREATE PRIVATE Sbnt2 w/Prv ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "PACAAD1_PRV_SN2_RTAssc" {
  subnet_id      = aws_subnet.PACAAD1_PRV_SN2.id
  route_table_id = aws_route_table.PACAAD1_PRV_RT.id
}