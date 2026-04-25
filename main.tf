module "web" {
  source = "./modules/web"

  vpc_id    = var.vpc_id
  subnet_id = var.public_subnet_1_id
  key_name  = var.key_name
}