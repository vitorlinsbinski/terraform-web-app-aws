variable "vpc_id" {
  description = "ID da VPC onde o SG será criado"
  type        = string
}

variable "subnet_id" {
  description = "ID da Subnet onde a instância será alocada"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH"
  type        = string
}