# Gmail Setup Guide

## Method 1: App Password (Recommended for simplicity)

### Prerequisites
- 2-Factor Authentication must be enabled on your Google account

### Steps
1. Go to [Google Account Settings](https://myaccount.google.com/)
2. Navigate to **Security** > **2-Step Verification**
3. Scroll down to **App passwords**
4. Select **Mail** and **Other (custom name)**
5. Enter "n8n Spending Buddy" as the name
6. Copy the generated 16-character password
7. Use this password in n8n (not your regular Gmail password)

## Method 2: OAuth2 (Recommended for production)

### Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the Gmail API
4. Create OAuth2 credentials
5. Add authorized redirect URIs for your n8n instance
6. Configure the OAuth2 credentials in n8n

## Gmail Labels for Better Filtering

Create these labels to organize transaction emails:
- `Transactions/Banking`
- `Transactions/Credit-Card`
- `Transactions/Digital-Payments`

## Email Filters

### Automatic Labeling
Set up filters to automatically label emails from:
- Banks: `from:(chase.com OR bankofamerica.com OR wellsfargo.com)`
- Credit Cards: `from:(visa.com OR mastercard.com OR americanexpress.com)`
- Digital: `from:(paypal.com OR venmo.com OR zelle.com)`

### Filter Criteria
- **From**: Bank domain
- **Subject**: Contains "transaction", "purchase", "payment"
- **Action**: Apply label and mark as important

## Security Considerations
- Use OAuth2 in production environments
- Regularly review app permissions
- Monitor for unauthorized access
- Enable security alerts from Google