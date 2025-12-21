#!/usr/bin/env bash

set -e

if [[ -z "$BOT_TOKEN" ]]; then
  echo "❌ BOT_TOKEN is missing"
  exit 1
fi

if [[ -z "$CHAT_ID" ]]; then
  echo "❌ CHAT_ID is missing"
  exit 1
fi

if [[ -z "$MESSAGE" ]]; then
  echo "❌ MESSAGE is missing"
  exit 1
fi

source contants/init.sh
for i in {1..3}; do
    if curl -s -X POST "$TELEGRAM_API" \
      -d chat_id="$CHAT_ID" \
      -d text="$MESSAGE" \
      -d parse_mode="HTML"; then
      echo "✅ Telegram notification sent successfully"
      break
    fi
    sleep 2
done

