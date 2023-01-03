output "vpc_id" {
 value = aws_vpc.PACAAD1_VPC.id
}
output "pubic_sn1_id" {
  value = aws_subnet.PACAAD1_PUB_SN1.id
}
output "public_sn2_id" {
  value = aws_subnet.PACAAD1_PUB_SN2.id
}
output "private_sn1_id" {
  value = aws_subnet.PACAAD1_PRV_SN1.id
}
output "private_sn2_id" {
  value = aws_subnet.PACAAD1_PRV_SN2.id
}