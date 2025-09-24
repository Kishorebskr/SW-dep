resource "aws_ecr_repository" "sw_webapp" {
  name                 = "sw-webapp"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
}
