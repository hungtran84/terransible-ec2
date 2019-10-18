variable "private_key_path" {
  default     = "~/.ssh/mykey.pem"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "admin"
}