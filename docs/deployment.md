# Production Deployment Guide

This guide covers deploying Spending Buddy with Docker in a production environment.

## Prerequisites

- Docker and Docker Compose installed
- Domain name pointing to your server
- SSL certificate (Let's Encrypt recommended)
- Server with at least 2GB RAM

## Quick Deployment

### 1. Clone and Setup

```bash
git clone https://github.com/teszerrakt/spending-buddy.git
cd spending-buddy
cp .env.example .env
```

### 2. Configure Environment

Edit `.env` file with your settings:

```bash
# Required settings
N8N_HOST=your-domain.com
N8N_PASSWORD=your-secure-password
POSTGRES_PASSWORD=your-database-password
LETSENCRYPT_EMAIL=your-email@domain.com
DOMAIN=your-domain.com
```

### 3. SSL Certificate Setup

#### Option A: Let's Encrypt (Recommended)
```bash
# Install certbot
sudo apt install certbot

# Get SSL certificate
sudo certbot certonly --standalone -d your-domain.com

# Copy certificates
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem ssl/
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem ssl/
sudo chown $USER:$USER ssl/*
```

#### Option B: Self-signed (Development only)
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ssl/privkey.pem \
  -out ssl/fullchain.pem \
  -subj "/CN=your-domain.com"
```

### 4. Update Nginx Configuration

Edit `nginx/sites-available/spending-buddy.conf`:
- Replace `your-domain.com` with your actual domain

### 5. Deploy

```bash
# Start services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f n8n
```

## Post-Deployment

### 1. Access n8n
- URL: `https://your-domain.com`
- Username: `admin` (or your N8N_USER)
- Password: Your N8N_PASSWORD

### 2. Import Workflows
1. Go to Workflows → Import from File
2. Import `workflows/spending-tracker-prod.json`
3. Configure credentials (Gmail, Telegram)
4. Activate the workflow

### 3. Test Setup
1. Send a test transaction email
2. Check Telegram for notifications
3. Monitor logs: `docker-compose logs -f n8n`

## Maintenance

### Backup Database
```bash
# Create backup
docker-compose exec postgres pg_dump -U n8n n8n > backup.sql

# Restore backup
docker-compose exec -T postgres psql -U n8n n8n < backup.sql
```

### Update n8n
```bash
# Pull latest images
docker-compose pull

# Restart services
docker-compose up -d
```

### SSL Certificate Renewal
```bash
# Renew Let's Encrypt certificate
sudo certbot renew

# Copy new certificates
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem ssl/
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem ssl/

# Restart nginx
docker-compose restart nginx
```

## Monitoring

### Check Service Health
```bash
# Service status
docker-compose ps

# Resource usage
docker stats

# Application logs
docker-compose logs -f n8n
docker-compose logs -f postgres
docker-compose logs -f nginx
```

### Health Check Endpoint
- URL: `https://your-domain.com/health`
- Should return: `healthy`

## Troubleshooting

### Common Issues

1. **n8n not accessible**
   - Check nginx logs: `docker-compose logs nginx`
   - Verify domain DNS resolution
   - Check SSL certificate validity

2. **Database connection issues**
   - Check postgres logs: `docker-compose logs postgres`
   - Verify database credentials in `.env`

3. **Workflow not triggering**
   - Check Gmail credentials in n8n
   - Verify webhook URLs
   - Check Telegram bot token

### Useful Commands
```bash
# Restart specific service
docker-compose restart n8n

# View real-time logs
docker-compose logs -f --tail=100 n8n

# Execute commands in containers
docker-compose exec n8n sh
docker-compose exec postgres psql -U n8n

# Clean up (DANGER: removes all data)
docker-compose down -v
```

## Security Considerations

- Use strong passwords for N8N_PASSWORD and POSTGRES_PASSWORD
- Regularly update SSL certificates
- Monitor access logs
- Keep Docker images updated
- Use firewall to restrict access to ports 80/443 only
- Consider using a VPN for admin access