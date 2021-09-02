resource "aws_cloudformation_stack" "this" {
  name = "create-s3-cf"
  template_body = file("${path.module}/files/s3-bucket.yml")
}
