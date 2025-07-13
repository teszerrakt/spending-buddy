#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📋 Spending Buddy - View Logs${NC}"
echo ""

# Check if services are running
if ! docker-compose -f docker-compose.local.yml ps | grep -q "Up"; then
    echo -e "${RED}❌ Services are not running. Start them first with:${NC}"
    echo "  ./scripts/start-local.sh"
    exit 1
fi

echo -e "${YELLOW}Choose logs to view:${NC}"
echo "1. All services (live)"
echo "2. n8n only (live)"
echo "3. PostgreSQL only (live)"
echo "4. Recent logs (last 50 lines)"
echo "5. Exit"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo -e "${GREEN}📊 Showing all service logs (Ctrl+C to exit)...${NC}"
        docker-compose -f docker-compose.local.yml logs -f
        ;;
    2)
        echo -e "${GREEN}📊 Showing n8n logs (Ctrl+C to exit)...${NC}"
        docker-compose -f docker-compose.local.yml logs -f n8n
        ;;
    3)
        echo -e "${GREEN}📊 Showing PostgreSQL logs (Ctrl+C to exit)...${NC}"
        docker-compose -f docker-compose.local.yml logs -f postgres
        ;;
    4)
        echo -e "${GREEN}📊 Showing recent logs...${NC}"
        docker-compose -f docker-compose.local.yml logs --tail=50
        ;;
    5)
        echo -e "${BLUE}👋 Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}❌ Invalid choice. Please run the script again.${NC}"
        exit 1
        ;;
esac