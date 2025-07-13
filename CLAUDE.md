# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Spending Buddy is an automated expense tracker that monitors Gmail for financial emails and sends spending alerts to Telegram using n8n workflows. The system uses a microservices architecture with Docker containers for n8n (workflow automation), PostgreSQL (data persistence), and nginx (reverse proxy for production).

## Development Environment Setup

### Quick Start Commands
```bash
# First-time setup (installs dependencies, pulls images)
./scripts/setup.sh

# Start local development environment
./scripts/start-local.sh

# View logs interactively
./scripts/logs.sh

# Stop services
./scripts/stop.sh

# Restart services (preserves data)
./scripts/restart.sh

# Nuclear reset (destroys all data)
./scripts/reset.sh
```

### Manual Commands (if scripts unavailable)
```bash
# Start local development
docker-compose -f docker-compose.local.yml up -d

# View n8n logs
docker-compose -f docker-compose.local.yml logs -f n8n

# Access database
docker-compose -f docker-compose.local.yml exec postgres psql -U n8n -d n8n

# Reset environment
docker-compose -f docker-compose.local.yml down -v
```

## Architecture

### Container Architecture
- **n8n**: Main workflow automation service (port 5678)
  - Local: Direct HTTP access with debug logging
  - Production: Behind nginx reverse proxy with SSL
- **PostgreSQL**: Persistent database for n8n data
- **nginx**: Production reverse proxy with SSL termination and security headers

### Environment Separation
- **Local (`docker-compose.local.yml`)**: HTTP, simple auth, debug logging, direct access
- **Production (`docker-compose.yml`)**: HTTPS, nginx proxy, production logging, SSL certificates

### Workflow Architecture
- **Development workflow**: `workflows/spending-tracker-dev.json`
- **Production workflow**: `workflows/spending-tracker-prod.json`
- Gmail trigger → Transaction parsing → Telegram notification

## Development Workflow

### n8n Access
- Local URL: http://localhost:5678
- Credentials: admin/admin123 (local), configured via environment (production)

### Testing Workflows
1. Import `workflows/spending-tracker-dev.json` into n8n
2. Configure Gmail credentials (OAuth2 or App Password)
3. Configure Telegram bot token
4. Send test transaction email
5. Verify Telegram notification received

### Workflow Development Process
1. Edit workflow in n8n UI
2. Test with sample data using n8n's test functionality
3. Export updated workflow from n8n (Workflows → Export)
4. Save to `workflows/spending-tracker-dev.json`
5. For production: copy to `workflows/spending-tracker-prod.json`

## Production Deployment

### Prerequisites
- Domain name with DNS pointing to server
- SSL certificates (Let's Encrypt recommended)
- Environment variables configured in `.env`

### Key Environment Variables
```bash
N8N_HOST=your-domain.com
N8N_PASSWORD=secure-password
POSTGRES_PASSWORD=database-password
WEBHOOK_URL=https://your-domain.com
```

### SSL Setup
```bash
# Let's Encrypt
sudo certbot certonly --standalone -d your-domain.com
sudo cp /etc/letsencrypt/live/your-domain.com/*.pem ssl/

# Update nginx config domain
# Edit nginx/sites-available/spending-buddy.conf
```

### Deployment Commands
```bash
# Deploy production
docker-compose up -d

# Database backup
docker-compose exec postgres pg_dump -U n8n n8n > backup.sql

# Update services
docker-compose pull && docker-compose up -d
```

## Configuration Files

### Critical Configuration
- `nginx/sites-available/spending-buddy.conf`: Domain-specific nginx config requiring domain updates
- `.env`: Production environment variables (copy from `.env.example`)
- `workflows/`: n8n workflow definitions (JSON format)

### Security Considerations
- n8n basic auth protects the interface
- nginx provides additional security headers and rate limiting
- PostgreSQL is not exposed externally
- SSL/TLS encryption for production traffic

## Troubleshooting

### Common Issues
- **n8n not accessible**: Check nginx logs, verify domain DNS, validate SSL certificates
- **Database connection**: Check postgres logs, verify credentials in environment
- **Workflow not triggering**: Verify Gmail credentials, check webhook URLs, validate Telegram bot token

### Debug Commands
```bash
# Service status
docker-compose ps

# Resource usage
docker stats

# Specific service logs
docker-compose logs -f n8n
docker-compose logs postgres
docker-compose logs nginx
```

## Integration Points

### Gmail Integration
- Requires OAuth2 credentials or App Password
- Monitors specific email patterns from financial institutions
- Uses Gmail API for real-time email detection

### Telegram Integration
- Requires bot token from @BotFather
- Sends formatted transaction notifications
- Supports both personal chats and group notifications

### n8n Workflow Logic
- Email parsing extracts transaction details (amount, merchant, date)
- Supports multiple bank email formats
- Configurable notification formatting and filtering