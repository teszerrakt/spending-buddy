# Credential Mapping

This document contains the credential IDs and names for the Spending Buddy project.

## Current Credentials

### OpenAI API
- **Name**: `[PROD] Spending Buddy - OpenAI`
- **ID**: `OF2IT8CaE50EAllK`
- **Type**: `openAiApi`

### Gmail OAuth2
- **Name**: `[PROD] Gmail Account`
- **ID**: `RFya2JEV38OqBbXs`
- **Type**: `gmailOAuth2`

### Telegram API (Development)
- **Name**: `[DEV] Spending Buddy - Telegram`
- **ID**: `O8ofLOv3SCwd6K68`
- **Type**: `telegramApi`

### Telegram API (Production)
- **Name**: `[PROD] Spending Buddy - Telegram`
- **ID**: `pu6LKLZ6CNjG9jqz`
- **Type**: `telegramApi`

### Google Sheets OAuth2 API
- **Name**: `[PROD] Google Sheets `
- **ID**: `hUAzqwp1HvuLoRqy`
- **Type**: `googleSheetsOAuth2Api`

## Usage

- **DEV workflow** should use DEV Telegram credential
- **PROD workflow** should use PROD Telegram credential
- Both workflows can share the same Gmail and Google Sheets credentials
- OpenAI credential is available for AI-powered features

---
*Last updated: 2025-07-13*