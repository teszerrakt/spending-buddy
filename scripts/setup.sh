#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 Spending Buddy - First Time Setup${NC}"
echo ""

# Check prerequisites
echo -e "${YELLOW}📋 Checking prerequisites...${NC}"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker not found. Please install Docker first.${NC}"
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
else
    echo -e "${GREEN}✅ Docker found${NC}"
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ docker-compose not found. Please install docker-compose first.${NC}"
    echo "   Visit: https://docs.docker.com/compose/install/"
    exit 1
else
    echo -e "${GREEN}✅ docker-compose found${NC}"
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker first.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Docker is running${NC}"
fi

echo ""
echo -e "${YELLOW}🔧 Setting up Spending Buddy...${NC}"

# Make scripts executable
echo -e "${BLUE}📝 Making scripts executable...${NC}"
chmod +x scripts/*.sh
echo -e "${GREEN}✅ Scripts are now executable${NC}"

# Create directories if they don't exist
echo -e "${BLUE}📁 Creating necessary directories...${NC}"
mkdir -p ssl logs backups
echo -e "${GREEN}✅ Directories created${NC}"

# Pull Docker images
echo -e "${BLUE}📦 Pulling Docker images (this may take a while)...${NC}"
docker-compose -f docker-compose.local.yml pull
echo -e "${GREEN}✅ Docker images pulled${NC}"

echo ""
echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
echo ""
echo -e "${YELLOW}🚀 Next steps:${NC}"
echo "1. Start the local environment:"
echo -e "   ${BLUE}./scripts/start-local.sh${NC}"
echo ""
echo "2. Open http://localhost:5678 in your browser"
echo "3. Login with admin/admin123"
echo "4. Import your workflow file"
echo "5. Configure Gmail and Telegram credentials"
echo ""
echo -e "${BLUE}📋 Available scripts:${NC}"
echo "  ./scripts/start-local.sh  - Start development environment"
echo "  ./scripts/stop.sh         - Stop services"
echo "  ./scripts/logs.sh         - View logs"
echo "  ./scripts/restart.sh      - Restart services"
echo "  ./scripts/reset.sh        - Reset all data"
echo ""
echo -e "${YELLOW}💡 Pro tip: Bookmark http://localhost:5678 for quick access!${NC}"