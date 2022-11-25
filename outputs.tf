output "key" {
  value = aws_s3_object.lambda_code_object.key
}

output "hash" {
  value = aws_s3_object.lambda_code_object.source_hash
}

output "zip_id" {
  value = random_uuid.code_hash.result
}
