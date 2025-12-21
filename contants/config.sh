#!/usr/bin/env bash

export TELEGRAM_API="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"

# Default retry count (can be overridden by user)
export ETRY_COUNT=${RETRY_COUNT:-3}
export RETRY_DELAY=${RETRY_DELAY:-2}
export PARSE_MODE=${PARSE_MODE:-"HTML"}
