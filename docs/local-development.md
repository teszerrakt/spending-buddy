# Local Development Guide

This guide helps you run Spending Buddy locally while mimicking the production environment.

## Quick Start

### 1. Start Local Environment
```bash
# Start services (mimics production setup)
docker-compose -f docker-compose.local.yml up -d

# View logs
docker-compose -f docker-compose.local.yml logs -f n8n
```

### 2. Access n8n
- **URL**: http://localhost:5678
- **Username**: admin
- **Password**: admin123

### 3. Import Development Workflow
1. Open http://localhost:5678
2. Go to **Workflows** → **Import from File**
3. Select `workflows/spending-tracker-dev.json`
4. Configure your credentials (Gmail, Telegram)
5. **Activate** the workflow

## Local vs Production

### What's the Same (Production Mimic):
- ✅ PostgreSQL database (persistent data)
- ✅ Same n8n version and configuration
- ✅ Docker containers
- ✅ Volume mounts for data persistence
- ✅ Same workflow structure

### What's Different (Local Simplified):
- 🔄 HTTP instead of HTTPS (no SSL needed)
- 🔄 No nginx reverse proxy (direct access)
- 🔄 Simple passwords (not production-secure)
- 🔄 Debug logging enabled

## Development Workflow

### 1. Test Workflow Changes
```bash
# Edit workflow in n8n UI
# Export updated workflow: Workflows → Export
# Save to workflows/spending-tracker-dev.json
```

### 2. View Logs
```bash
# Real-time logs
docker-compose -f docker-compose.local.yml logs -f n8n

# Database logs
docker-compose -f docker-compose.local.yml logs postgres
```

### 3. Database Access
```bash
# Connect to database
docker-compose -f docker-compose.local.yml exec postgres psql -U n8n -d n8n

# View tables
\dt

# Exit
\q
```

### 4. Reset Environment
```bash
# Stop and remove all data
docker-compose -f docker-compose.local.yml down -v

# Start fresh
docker-compose -f docker-compose.local.yml up -d
```

## Testing

### 1. Test Gmail Integration
- Use your real Gmail credentials
- Send yourself a test transaction email
- Check n8n execution logs

### 2. Test Telegram Integration
- Create a test Telegram bot
- Use your personal chat ID
- Verify notifications are received

### 3. Test Workflow Logic
- Use n8n's built-in test functionality
- Check webhook endpoints
- Verify data parsing logic

## Common Commands

```bash
# Start development environment
docker-compose -f docker-compose.local.yml up -d

# Stop development environment
docker-compose -f docker-compose.local.yml down

# View all logs
docker-compose -f docker-compose.local.yml logs

# Restart just n8n
docker-compose -f docker-compose.local.yml restart n8n

# Update to latest n8n version
docker-compose -f docker-compose.local.yml pull n8n
docker-compose -f docker-compose.local.yml up -d n8n
```

## Advantages of This Approach

1. **Production Parity**: Same database, same containers
2. **Data Persistence**: Your workflows and data survive restarts
3. **Easy Testing**: Full production features available
4. **Simple Deployment**: Same workflows work in production
5. **Debugging**: Full access to logs and database

## When Ready for Production

Your local workflow will work seamlessly in production:

1. Export your tested workflow
2. Copy to `workflows/spending-tracker-prod.json`
3. Deploy using the production docker-compose.yml
4. Update domain and SSL settings

This approach gives you the best of both worlds! 🎯