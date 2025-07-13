#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 Restarting Spending Buddy Services${NC}"
echo ""

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ docker-compose not found.${NC}"
    exit 1
fi

echo -e "${YELLOW}🛑 Stopping services...${NC}"
docker-compose -f docker-compose.local.yml down

echo -e "${YELLOW}🚀 Starting services...${NC}"
docker-compose -f docker-compose.local.yml up -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to start...${NC}"
sleep 10

# Check if services are running
if docker-compose -f docker-compose.local.yml ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Services restarted successfully!${NC}"
    echo ""
    echo -e "${GREEN}🌐 Access n8n at: http://localhost:5678${NC}"
    echo -e "${GREEN}👤 Username: admin${NC}"
    echo -e "${GREEN}🔑 Password: admin123${NC}"
else
    echo -e "${RED}❌ Failed to restart services. Check logs:${NC}"
    docker-compose -f docker-compose.local.yml logs
    exit 1
fi