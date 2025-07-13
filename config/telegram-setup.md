# Telegram Bot Setup Guide

## Creating a Telegram Bot

1. **Open Telegram** and search for `@BotFather`
2. **Start a conversation** with BotFather
3. **Create a new bot** by sending `/newbot`
4. **Choose a name** for your bot (e.g., "Spending Buddy")
5. **Choose a username** for your bot (must end with "bot", e.g., "spending_buddy_bot")
6. **Save the bot token** - you'll need this for n8n

## Getting Your Chat ID

### For Personal Chat
1. Send a message to your bot
2. Visit: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
3. Look for `"chat":{"id":` - this is your chat ID

### For Group Chat
1. Add your bot to the group
2. Send a message mentioning the bot
3. Visit: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
4. Look for the group chat ID (usually negative number)

## Bot Configuration

### Required Permissions
- Send messages
- Read messages (if you want to respond to commands)

### Optional Features
- Custom keyboard for quick actions
- Inline buttons for transaction categories
- Message formatting (Markdown/HTML)

## Example Bot Token Format
```
1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ-1234567890
```

## Security Notes
- Keep your bot token secret
- Don't share it in public repositories
- Use environment variables in production
- Regularly rotate tokens if compromised