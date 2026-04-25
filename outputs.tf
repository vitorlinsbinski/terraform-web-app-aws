output "public_ip_instance" {
  value       = module.web.instance_ip
  description = "IP público da instância para SSH"
}

output "comando_ssh" {
  value       = "ssh -i ${module.web.key_path} ubuntu@${module.web.instance_ip}"
  description = "Comando pronto para copiar e colar no terminal"
}