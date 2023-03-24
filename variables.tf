variable "deployment_bucket_id" {
  type = string
}

variable "deployment_bucket_prefix" {
  type    = string
  default = ""
}

variable "output_dir" {
  type = string
}

variable "source_dir" {
  type = string
}

variable "hash_sources" {
  type        = list(string)
  default     = []
  description = "List of file patterns to create a source hash. (omitted if 'source_hash' is specified)"
}

variable "source_hash" {
  type        = string
  default     = null
  description = "Hash of package source. This will determine possible changes to the package"
}

variable "package_type" {
  type    = string
  default = "zip"

  validation {
    condition     = contains(["zip"], var.package_type)
    error_message = "Currently package type supports only 'zip' type."
  }
}

variable "excluded_paths" {
  type    = list(string)
  default = []
}

variable "tags" {
  type        = map(string)
  description = "User defined resource tags"
}
