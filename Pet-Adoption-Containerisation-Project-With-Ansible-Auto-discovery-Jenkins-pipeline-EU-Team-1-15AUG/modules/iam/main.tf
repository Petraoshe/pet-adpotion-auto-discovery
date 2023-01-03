################################################################################
# IAM ROLE
################################################################################
# Provision IAM role for Ansible Host
resource "aws_iam_role" "PACAAD1_Ansible_IAM_role" {
  name               = var.Ansible_IAM_role_Name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}


################################################################################
# Create Policy attachment for Ansible IAM role
resource "aws_iam_role_policy_attachment" "PACAAD1_Ansible_IAM_role_policy_att" {
  role       = aws_iam_role.PACAAD1_Ansible_IAM_role.name
  policy_arn = aws_iam_policy.PACAAD1_Ansible_IAM_policy.arn
}


################################################################################
# Create Instance profile for Ansible IAM role
resource "aws_iam_instance_profile" "PACAAD1_Ansible_IAM_instance_profile" {
  name = var.Ansible_IAM_instance_profile_Name
  role = aws_iam_role.PACAAD1_Ansible_IAM_role.name
}


################################################################################
# Provision Ansible IAM assume role policy
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Provision Ansible IAM role policy
resource "aws_iam_policy" "PACAAD1_Ansible_IAM_policy" {
  name        = var.Ansible_IAM_policy_Name
  description = "Ansible Role policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# # DUPLICATED CODE LIKE ABOVE
# # create Iam role policy
# resource "aws_iam_role" "ansible_host_role" {
#   name               = "ansible-host-aws-role"
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.ansible_host_policy_document.json
# }

# # Here we attach the iam policy to the iam role created
# resource "aws_iam_role_policy_attachment" "ansible_host_policy_attachment" {
#   role       = aws_iam_role.ansible_host_role.name
#   policy_arn = aws_iam_policy.ansible_host.arn
# }

# # create an iam instance profile to attach to our Ansible host
# resource "aws_iam_instance_profile" "ansible_host_instance_profile" {
#   name = "ansible_host_instance_profile"
#   role = aws_iam_role.ansible_host_role.name
# }

