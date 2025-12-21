#!/usr/bin/env bash

set -e

# source constants
source "$GITHUB_ACTION_PATH/constants/config.sh"
source "$GITHUB_ACTION_PATH/constants/info.sh"
# state variables
required_vars=(BOT_TOKEN CHAT_ID)
missing_vars=()
success=false

for var in "${required_vars[@]}"; do
  if [[ -z "${!var}" ]]; then
    missing_vars+=("$var")
  fi
done

if [[ ${#missing_vars[@]} -ne 0 ]]; then
  echo "❌ Missing required environment variables: ${missing_vars[*]}"
  exit 1
fi

# if user inpput message not provided, use default message
if [[ -z "$MESSAGE" ]]; then
  MESSAGE="$DEFAULT_MESSAGE"
fi

FULL_MESSAGE="$MESSAGE

$GITHUB_INFO"

for i in $(seq 1 "$RETRY_COUNT"); do
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$TELEGRAM_API" \
    -d chat_id="$CHAT_ID" \
    -d text="$FULL_MESSAGE" \
    -d parse_mode="$PARSE_MODE")

  if [[ "$HTTP_STATUS" -eq 200 ]]; then
    echo "✅ Telegram notification sent successfully"
    success=true
    break
  else
    echo "⚠️ Attempt $i/$RETRY_COUNT failed (HTTP $HTTP_STATUS). Retrying in $RETRY_DELAY seconds..."
    sleep "$RETRY_DELAY"
  fi
done

if [[ "$success" != "true" ]]; then
  echo "❌ Failed to send Telegram notification after $RETRY_COUNT attempts."
  exit 1
fi
