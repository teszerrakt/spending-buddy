#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${RED}⚠️  DANGER: Reset All Data${NC}"
echo ""
echo -e "${YELLOW}This will permanently delete:${NC}"
echo "  • All workflows and configurations"
echo "  • Database data"
echo "  • Docker volumes"
echo ""
echo -e "${RED}This action cannot be undone!${NC}"
echo ""

read -p "Are you sure you want to reset all data? (type 'yes' to confirm): " confirm

if [ "$confirm" != "yes" ]; then
    echo -e "${BLUE}👍 Reset cancelled. Your data is safe.${NC}"
    exit 0
fi

echo ""
echo -e "${YELLOW}🛑 Stopping services...${NC}"
docker-compose -f docker-compose.local.yml down

echo -e "${YELLOW}🗑️  Removing volumes and data...${NC}"
docker-compose -f docker-compose.local.yml down -v

echo -e "${YELLOW}🧹 Cleaning up Docker resources...${NC}"
docker system prune -f

echo -e "${GREEN}✅ Reset completed!${NC}"
echo ""
echo -e "${YELLOW}🚀 To start fresh:${NC}"
echo "  ./scripts/start-local.sh"
echo ""
echo -e "${BLUE}💡 You'll need to reimport your workflows and reconfigure credentials.${NC}"