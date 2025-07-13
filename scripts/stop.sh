#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🛑 Stopping Spending Buddy Local Development Environment${NC}"
echo ""

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ docker-compose not found.${NC}"
    exit 1
fi

echo -e "${YELLOW}📦 Stopping containers...${NC}"
docker-compose -f docker-compose.local.yml down

echo -e "${GREEN}✅ Services stopped successfully!${NC}"
echo ""
echo -e "${YELLOW}💡 Options:${NC}"
echo "  To start again: ./scripts/start-local.sh"
echo "  To remove all data: ./scripts/reset.sh"
echo "  To view logs: ./scripts/logs.sh"