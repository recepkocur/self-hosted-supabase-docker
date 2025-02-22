# Self-Hosted Supabase Docker

> Last Update: 17.02.2025

This project is a Docker-based infrastructure project prepared for running Supabase self-hosted on your own VPS server. It allows you to run all core features of Supabase under your own control.

## Contents

1. [Key Features](#key-features)
2. [Supported Services](#supported-services)
3. [Security Features](#security-features)
4. [Performance Optimizations](#performance-optimizations)
5. [Monitoring and Logging](#monitoring-and-logging)
6. [Backup and Disaster Recovery](#backup-and-disaster-recovery)
7. [Why Self-Hosted Supabase?](#why-self-hosted-supabase)
8. [Technical Infrastructure](#technical-infrastructure)
9. [Configurations](#configurations)
10. [Installation and Configuration](#installation-and-configuration)
11. [Deployment](#deployment)
12. [Commands](#commands)
13. [Requirements](#requirements)
14. [System Requirements](#system-requirements)
15. [Troubleshooting](#troubleshooting)
16. [Security Hardening](#security-hardening)
17. [Contributing](#contributing)
18. [License](#license)
19. [Support](#support)

## Key Features

- 🔒 **Full Data Control**: Your data on your server, under your control
- 🚀 **Easy Setup**: Single command deployment with Docker Compose
- 🔄 **Automatic SSL**: Automatic SSL certificate management with Traefik
- 📦 **Modular Structure**: Customize services according to your needs
- 🛡️ **Security Focused**: JWT, API key rotation and role-based access control
- 🔄 **CI/CD Integration**: Automatic deployment with GitHub Actions
- 📊 **Monitoring**: Realtime monitoring and logging infrastructure

## Supported Services

- PostgreSQL Database (15.8.1)
- Kong API Gateway (2.8.1)
- GoTrue Auth Service (v2.167.0)
- Storage API (v1.14.5)
- Realtime (v2.34.7)
- Edge Functions (v1.67.0)
- PostgREST API (v12.2.0)
- Supabase Studio UI

## Security Features

- SSL/TLS encryption (Traefik + Let's Encrypt)
- JWT-based authentication
- API key rotation
- Role-based access control (RBAC)
- Secure environment variable management
- Docker container isolation

## Performance Optimizations

- Connection pooling optimization
- Caching strategies
- Load balancing
- Automatic scaling support
- Query optimization

## Monitoring and Logging

- Realtime system metrics
- Detailed log records
- Error tracking and reporting
- Performance metrics
- Resource usage statistics

## Backup and Disaster Recovery

- Automatic database backup
- Backup rotation
- Fast recovery procedures
- Data replication options

## Why Self-Hosted Supabase?

I need a centralized backend platform for my modern web and mobile applications. Supabase's offerings:

- Real-time database
- Authentication
- File storage
- Edge Functions
- Auto-API creation

allow me to host these on my own server, giving me full control over my data. This allows me to:

- Data sovereignty
- Cost optimization
- Customizable infrastructure
- High performance

advantages.

## Technical Infrastructure

The fundamental components used in the project:

- Ubuntu 24.04+ VPS server
- Docker 28.0.0
- Traefik reverse proxy
- Cloudflare DNS and SSL
- OpenAI API integration
- GitHub Actions CI/CD

## Configurations

### 1. Traefik Configuration

- Automatic SSL certificate management
- Secure routing with reverse proxy
- Let's Encrypt integration

### 2. GitHub Actions Deployment

- Main branch -> Development environment
- Prod branch -> Production environment
- Automatic deployment and rollback
- Secure connection via SSH

### 3. Supabase Services

- PostgreSQL database
- GoTrue auth service
- Storage API
- Realtime
- Edge Functions
- PostgREST API

### 4. Security Configurations

- SSL certificates (Traefik + Cloudflare)
- JWT token management
- API key rotation
- Role-based access control

### 5. Integrations

- Cloudflare DNS management
- OpenAI API connection
- SMTP mail service
- S3-compatible storage

## Installation and Configuration

## Pre-Installation Preparation

1. Domain settings:
   - A record: api.domain.com -> Server IP
   - CNAME: \*.api.domain.com -> api.domain.com
2. Cloudflare settings:

   - SSL/TLS mode: Full (strict)
   - Edge Certificates: Active
   - Always Use HTTPS: Active

3. Firewall settings:
   - HTTP (80)
   - HTTPS (443)
   - PostgreSQL (5432)
     must be open.

```bash
git clone https://github.com/username/vps-docker-supabase
cd vps-docker-supabase
cp .env.example .env
```

### .env file modification

SELF_HOST_NAME parameter specifies the domain name for the Traefik reverse proxy. This parameter:

- Must be in domain name format only (e.g., api.example.com)
- Must not include http:// or https:// protocol specifiers
- Can use subdomains (e.g., supabase.example.com)
- Correct format: api.domain.com
- Incorrect format: https://api.domain.com

This parameter is used by Traefik for SSL certificate management and reverse proxy routing. It is used in the labels of the relevant services in the docker-compose.dev.yml file.

Example usage:

```bash
SELF_HOST_NAME=kong.example.com
```

docker-compose -f docker-compose.dev.yml up -d

## Deployment

The project has automatic deployment capabilities via GitHub Actions:

- `main` branch -> Development environment
- `prod` branch -> Production environment

Automatic deployment occurs for each push to the relevant environment.

## Commands

### Reset Operation

The `reset.sh` script is used to reset the project. This script:

- Stops and removes all Docker containers
- Clears bind-mounted directories
- Preserves the .env file (for security reasons)

Usage:

```bash
./reset.sh
```

Note: The .env file is not removed in the reset operation due to security reasons. If you also want to reset the .env file, you can remove the commented out code block (related to .env) in the reset.sh script.

The commented out block in the reset.sh script (.env related) is kept to prevent accidental deletion of the .env file containing sensitive information. This ensures:

1. The existing running environment configuration is preserved
2. Critical API keys and passwords are kept safe
3. Production environment misconfiguration is prevented

Related code block:

```29:42:reset.sh
# echo "Resetting .env file..."
# if [ -f ".env" ]; then
#   echo "Removing existing .env file..."
#   rm -f .env
# else
#   echo "No .env file found. Skipping .env removal step..."
# fi

# if [ -f ".env.example" ]; then
#   echo "Copying .env.example to .env..."
#   cp .env.example .env
# else
#   echo ".env.example file not found. Skipping .env reset step..."
# fi
```

This block can be activated if needed, but should be used carefully in the production environment.

## Requirements

- Ubuntu 24.04+ VPS server
- Docker 28.0.0+
- Domain name
- Cloudflare account
- OpenAI API key (optional)

## System Requirements

- RAM: Minimum 4GB (Recommended: 8GB)
- CPU: Minimum 2 cores (Recommended: 4 cores)
- Disk: Minimum 20GB SSD (Recommended: 50GB SSD)
- Port Requirements:
  - 80/443: HTTP/HTTPS
  - 5432: PostgreSQL
  - 8000: Kong API Gateway
  - 9000: Storage API
  - 4000: Realtime API

## Troubleshooting

### Common Errors

1. SSL Certificate Errors:

```bash
docker logs supabase-traefik
```

2. Database Connection Errors:

```bash
docker logs supabase-db
```

3. API Gateway Errors:

```bash
docker logs supabase-kong
```

### Solution Suggestions

1. SSL Certificate Issues:
   - Check DNS records
   - Verify Cloudflare SSL mode
2. Database Issues:
   - Check PostgreSQL logs
   - Check disk space
3. Connection Issues:
   - Check port conflicts
   - Check Docker network settings

## Security Hardening

1. Network Security:

   - Internal network isolation
   - Reverse proxy security headers
   - Rate limiting rules

2. Database Security:

   - Role-based access control
   - Encryption policies
   - Audit logging

3. API Security:
   - JWT token rotation
   - API key management
   - Request/Response validation

## Contributing

I'm sharing this project as open source. I hope it serves as a starting point for anyone wanting to self-host Supabase. I'm open to issues and Pull Requests.

## License

MIT License - See LICENSE file for details.

## Support

Please use the [Supabase GitHub Issues](https://github.com/supabase/supabase/issues) page for your questions and issues.
