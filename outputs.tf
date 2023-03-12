output "s3_key" {
  value = aws_s3_object.lambda_code_object.key
}

output "output_base64sha256" {
  value = data.archive_file.package.output_base64sha256
}

output "source_hash" {
  value = local.hash
}

output "hash_files_paths" {
  value = local.hash_files_paths
}
