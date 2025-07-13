# Spending Buddy 💰

An automated expense tracker that monitors Gmail for financial emails and sends spending alerts to Telegram using n8n workflows.

## Features

- **Gmail Integration**: Automatically detects spending-related emails
- **Smart Parsing**: Extracts transaction details from various bank/card providers
- **Telegram Notifications**: Real-time spending alerts sent to your Telegram chat
- **n8n Automation**: Visual workflow automation platform
- **Multi-Bank Support**: Compatible with various financial institutions

## How It Works

1. **Email Monitoring**: n8n monitors your Gmail for new emails from banks/financial institutions
2. **Transaction Detection**: Identifies spending-related emails (purchases, withdrawals, etc.)
3. **Data Extraction**: Parses transaction details (amount, merchant, date, account)
4. **Telegram Alert**: Sends formatted notification to your Telegram bot/channel

## Quick Setup

### Prerequisites

- n8n instance (self-hosted or cloud)
- Gmail account with app password
- Telegram bot token
- Basic knowledge of n8n workflows

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/teszerrakt/spending-buddy.git
   cd spending-buddy
   ```

2. **Import n8n workflow**
   - Open your n8n instance
   - Go to Workflows > Import from File
   - For development: Import `workflows/spending-tracker-dev.json`
   - For production: Import `workflows/spending-tracker-prod.json`

3. **Configure credentials**
   - Gmail: Add Gmail OAuth2 or App Password credentials
   - Telegram: Add your Telegram bot token
   - Update the workflow nodes with your credentials

4. **Test the workflow**
   - Send yourself a test email or wait for a real transaction
   - Check your Telegram for notifications

## Configuration

### Gmail Setup

1. Enable 2-factor authentication on Gmail
2. Generate an app password for n8n
3. Or use OAuth2 (recommended for better security)

### Telegram Setup

1. Create a bot via @BotFather
2. Get your bot token
3. Find your chat ID (personal chat or group)

## File Structure

```
spending-buddy/
├── workflows/          # n8n workflow files
│   ├── spending-tracker-dev.json
│   └── spending-tracker-prod.json
├── config/            # Configuration examples
├── docs/              # Documentation
└── README.md
```

## License

MIT License - feel free to use and modify for your needs.