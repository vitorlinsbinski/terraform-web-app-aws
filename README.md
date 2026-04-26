
<p align="center">
	<img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" alt="Terraform" width="96" />
	<span style="display:inline-block; background:#232F3E; padding:10px 14px; border-radius:6px; line-height:0; margin-left: 16px">
		<img src="https://raw.githubusercontent.com/lobehub/lobe-icons/refs/heads/master/packages/static-png/dark/aws.png" alt="AWS" width="105" style="filter: invert(1) brightness(1.2);" />
	</span>
</p>

# Terraform Exercício — EC2 (Ubuntu) + Nginx

Esse projeto consiste em um estudo sobre Infraestrutura como código (IaC) com Terraform para provisionar uma instância EC2 na AWS (Ubuntu 24.04) já configurada com Nginx via `user_data`, com acesso por SSH e HTTP liberados via Security Group.

> Projeto de estudo do curso **Engenharia de Dados / Deep Learning**.

## O que este projeto cria

No módulo [modules/web](modules/web) são provisionados:

- **1x EC2** (`t2.micro`) com **IP público**
- **Nginx instalado e iniciado automaticamente** (porta 80)
- **Security Group** permitindo:
	- SSH: porta 22 (0.0.0.0/0)
	- HTTP: porta 80 (0.0.0.0/0)
	- Egress liberado (IPv4)
- **Par de chaves SSH**:
	- Gera chave privada via `tls_private_key`
	- Cria `aws_key_pair` na AWS
	- Salva a chave privada localmente como `minha-chave-ssh.pem`

Na raiz do projeto:

- Encapsula o módulo `web`
- Expõe outputs úteis (IP público e comando SSH pronto)

## Pré-requisitos

- Terraform instalado (recomendado: versão 1.5+)
- Conta AWS e credenciais configuradas localmente (ex.: `aws configure` ou variáveis de ambiente)
- Permissões para criar EC2, Security Group e Key Pair
- Você precisa saber o `vpc_id` e um `subnet_id` público existentes

## Como usar

1) Configure as variáveis em `terraform.tfvars`:

- `aws_region`
- `project`
- `key_name`
- `vpc_id`
- `public_subnet_1_id`

2) Inicialize e aplique:

```bash
terraform init
terraform plan
terraform apply
```

3) Acesse por SSH (output `comando_ssh`):

```bash
terraform output -raw comando_ssh
```

4) Acesse o Nginx pelo navegador:

```bash
terraform output -raw public_ip_instance
```

Abra: `http://<IP_PUBLICO>`

## Inputs (variáveis)

Variáveis na raiz (veja [variables.tf](variables.tf)):

- `aws_region` (string) — região AWS (default `us-east-1`)
- `project` (string) — tag padrão do projeto
- `key_name` (string) — nome do Key Pair na AWS
- `vpc_id` (string) — ID da VPC onde o SG será criado
- `public_subnet_1_id` (string) — ID da subnet pública para alocar a EC2

## Outputs

Outputs na raiz (veja [outputs.tf](outputs.tf)):

- `public_ip_instance` — IP público da instância
- `comando_ssh` — comando SSH pronto (com `-i` apontando para o `.pem` criado)

## Arquivos gerados localmente (atenção)

Este projeto salva uma chave privada localmente:

- `minha-chave-ssh.pem` (na raiz do projeto)

Boas práticas:

- **Não comite** o arquivo `.pem`
- **Não comite** `terraform.tfstate*` (pode conter dados sensíveis)

Sugestão de `.gitignore`:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
*.pem
.terraform.lock.hcl
```

## Segurança

- As regras de ingress permitem SSH/HTTP a partir de `0.0.0.0/0` (internet inteira). Para uso real, restrinja para o seu IP.
- A instância recebe IP público (`associate_public_ip_address = true`).

## Destruir recursos

Para remover tudo o que foi criado:

```bash
terraform destroy
```

## Estrutura do repositório

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
		└── web/
				├── data.tf
				├── ec2.tf
				├── keys.tf
				├── network.tf
				├── outputs.tf
				└── variables.tf
```

