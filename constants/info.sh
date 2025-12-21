#!/usr/bin/env bash
set -e

# Get the current branch name
export BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Get the current commit hash
export COMMIT_HASH=$(git rev-parse HEAD)

# Get the current commit message
export COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# Get the current commit author
export COMMIT_AUTHOR=$(git log -1 --pretty=%an)

# Get the current commit date
export COMMIT_DATE=$(git log -1 --pretty=%ad)

# Get the current commit subject
export COMMIT_SUBJECT=$(git log -1 --pretty=%s)

# Get the current commit body
export COMMIT_BODY=$(git log -1 --pretty=%b)

# Get the current commit email
export COMMIT_EMAIL=$(git log -1 --pretty=%ae)

# Get the current commit author email
export COMMIT_AUTHOR_EMAIL=$(git log -1 --pretty=%ae)

# Get the current commit author name
export COMMIT_AUTHOR_NAME=$(git log -1 --pretty=%an)

# Get the current commit author email
export COMMIT_AUTHOR_EMAIL=$(git log -1 --pretty=%ae)

# Get the current
export GITHUB_INFO=$(cat <<EOF
Actor: $GITHUB_ACTOR
Branch: <a href="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/tree/$GITHUB_REF_NAME">$GITHUB_REF_NAME</a>
Commit: <a href="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/commit/$GITHUB_SHA">$GITHUB_SHA</a>
Repository: <a href="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY">$GITHUB_REPOSITORY</a>
EOF
)
export DEFAULT_MESSAGE="🚨 <b>Deployment Failed</b>"
