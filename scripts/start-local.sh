#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Spending Buddy Local Development Environment${NC}"
echo ""

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker and try again.${NC}"
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ docker-compose not found. Please install docker-compose.${NC}"
    exit 1
fi

echo -e "${YELLOW}📦 Starting containers...${NC}"
docker-compose -f docker-compose.local.yml up -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to start...${NC}"
sleep 10

# Check if services are running
if docker-compose -f docker-compose.local.yml ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Services started successfully!${NC}"
    echo ""
    echo -e "${BLUE}📊 Service Status:${NC}"
    docker-compose -f docker-compose.local.yml ps
    echo ""
    echo -e "${GREEN}🌐 Access n8n at: http://localhost:5678${NC}"
    echo -e "${GREEN}👤 Username: admin${NC}"
    echo -e "${GREEN}🔑 Password: admin123${NC}"
    echo ""
    echo -e "${YELLOW}💡 Next steps:${NC}"
    echo "1. Open http://localhost:5678 in your browser"
    echo "2. Login with admin/admin123"
    echo "3. Import workflows/spending-tracker-dev.json"
    echo "4. Configure your Gmail and Telegram credentials"
    echo ""
    echo -e "${BLUE}📋 Useful commands:${NC}"
    echo "  ./scripts/logs.sh     - View logs"
    echo "  ./scripts/stop.sh     - Stop services"
    echo "  ./scripts/restart.sh  - Restart services"
else
    echo -e "${RED}❌ Failed to start services. Check the logs:${NC}"
    docker-compose -f docker-compose.local.yml logs
    exit 1
fi