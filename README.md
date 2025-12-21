# Telegram Failure Notifier 🚨

**Send Telegram messages when GitHub Actions jobs fail.**

This action allows your CI/CD workflow to **notify your team instantly on Telegram** if a job fails, including default GitHub context like repository, branch, commit, and actor.

---

## ⚡ Features

- Sends Telegram messages on **job failure** (`failure()` condition)
- Prepend **default GitHub context** to all messages:
  - Repository
  - Branch
  - Commit
  - Actor
- Fully customizable message body (supports `<b>` and `<i>` HTML formatting)
- Configurable **retry count** and **retry delay**
- Supports **HTML** or **Markdown** parse modes

---

## 🛠️ Inputs

| Name          | Description                         | Default                        | Required |
| ------------- | ----------------------------------- | ------------------------------ | -------- |
| `bot_token`   | Telegram Bot Token                  | —                              | ✅       |
| `chat_id`     | Telegram Chat ID (group or channel) | —                              | ✅       |
| `message`     | Message to send                     | `❌ GitHub Actions job failed` | ❌       |
| `retry_count` | Number of retries                   | `2`                            | ❌       |
| `retry_delay` | Delay between retries in seconds    | `5`                            | ❌       |
| `parse_mode`  | Parse mode: `HTML` or `Markdown`    | `HTML`                         | ❌       |

> **Note:** Telegram Bot must be added to your group/channel. Channels usually require the bot to be an admin.

---

## 🔧 Usage Example

### Notify Telegram on Failure Only

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build & Deploy
        run: |
          echo "Building app..."
          ./deploy.sh  # This may fail

      - name: Notify Telegram on Failure
        if: failure()
        uses: devlopersabbir/telegram-action-notifier@v1.0.0
        with:
          bot_token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          chat_id: ${{ secrets.TELEGRAM_CHAT_ID }}
          message: |
            <b>🚨 Deployment Failed!</b>
            Please check logs immediately.
          retry_count: 3
          retry_delay: 3
          parse_mode: HTML
```

### ✅ Telegram Message Output Example

```makefile
🚨 Deployment Failed!
Please check logs immediately.

Actor: sabbir
Branch: main
Commit: a1b2c3d
Repository: my-org/my-app
```

- User message appears on top

- GitHub context is **always appended** automatically

### 🔐 Security Best Practices

- Never hardcode secrets in your workflow.
- Use GitHub Secrets:
  - TELEGRAM_BOT_TOKEN
  - TELEGRAM_CHAT_ID

### 🧠 Pro Tips

- Use `if: failure()` to send messages only when jobs fail
- Use `always()` for cleanup steps, if needed
- Use HTML formatting for rich messages (`<b>`, `<i>`, `<a>` links)
- Limit message length (~4096 characters) to avoid Telegram API errors

### 🏷️ Author

Sabbir Hossain Shuvo
