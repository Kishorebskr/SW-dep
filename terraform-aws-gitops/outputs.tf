output "cluster_name" { value = module.eks.cluster_id }
output "kubeconfig_command" { value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_id}" }
output "ecr_repository_url" { value = aws_ecr_repository.sw_webapp.repository_url }
