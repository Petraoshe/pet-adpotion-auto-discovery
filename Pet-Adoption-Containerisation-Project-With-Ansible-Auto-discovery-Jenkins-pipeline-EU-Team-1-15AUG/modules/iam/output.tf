#### IAM role Outputs

output "IAM_role_id" {
  value = aws_iam_role.PACAAD1_Ansible_IAM_role.id
}

output "IAM_role_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.PACAAD1_Ansible_IAM_role_policy_att.id
}

output "IAM_Instance_Profile_id" {
  value = aws_iam_instance_profile.PACAAD1_Ansible_IAM_instance_profile.id
}

# output "IAM_policy_document_AssumeRole_id" {
#   value = aws_iam_policy_document.instance-assume-role-policy.id
# }

output "IAM_role_policy_id" {
  value = aws_iam_policy.PACAAD1_Ansible_IAM_policy.id
}

