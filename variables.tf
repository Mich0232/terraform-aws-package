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
  type    = list(string)
  default = []
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
