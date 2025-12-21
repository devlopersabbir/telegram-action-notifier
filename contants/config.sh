#!/usr/bin/env bash

export TELEGRAM_API="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"

# Default retry count (can be overridden by user)
export RETRY_COUNT=${RETRY_COUNT:-2}
export RETRY_DELAY=${RETRY_DELAY:-3}
export PARSE_MODE=${PARSE_MODE:-"HTML"}
