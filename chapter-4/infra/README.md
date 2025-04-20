# Infrastructure as Code with OpenTofu

This project demonstrates infrastructure management using OpenTofu (an open-source alternative to Terraform) to deploy Nginx and PostgreSQL services using Docker containers.

## Prerequisites

- OpenTofu installed
- Docker installed and running
- Access to Docker Hub

## Project Structure

```
infra/
├── environments/         # Environment-specific variables
│   ├── dev.tfvars       # Development environment variables
│   ├── stg.tfvars       # Staging environment variables
│   └── prd.tfvars       # Production environment variables
├── templates/           # Template files
│   └── .env.tpl        # Environment template file
├── main.tf             # Main infrastructure configuration
├── variables.tf        # Variable definitions
└── outputs.tf          # Output definitions
```

## Available Resources

- Nginx web server (exposed on port 8080)
- PostgreSQL database (exposed on port 5432)
- Environment configuration file

## Usage

1. Initialize OpenTofu:
```bash
tofu init
```

2. Review the execution plan:
```bash
tofu plan -var-file=environments/dev.tfvars
```

3. Apply the infrastructure:
```bash
tofu apply -var-file=environments/dev.tfvars -auto-approve
```

4. Destroy the infrastructure:
```bash
tofu destroy -var-file=environments/dev.tfvars -auto-approve
```

## Environment Variables

The following variables are required in your tfvars file:

- `env`: Environment name (e.g., "dev", "stg", "prd")
- `postgres_user`: PostgreSQL username
- `postgres_password`: PostgreSQL password
- `postgres_db`: PostgreSQL database name
- `nginx_port`: Nginx port (default: 8080)
- `postgres_port`: PostgreSQL port (default: 5432)
