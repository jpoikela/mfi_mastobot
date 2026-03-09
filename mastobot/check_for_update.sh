#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/mastobot/current"
SERVICE_NAME="mastobot"

cd "$APP_DIR"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: $APP_DIR is not a git repository"
    exit 1
fi

branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$branch" = "HEAD" ]; then
    echo "Error: detached HEAD detected, refusing to auto-update"
    exit 1
fi

current_head="$(git rev-parse HEAD)"
newest_head="$(git ls-remote origin "refs/heads/$branch" | cut -f1)"

echo "Current: $current_head"
echo "Newest:  $newest_head"

if [ -z "$newest_head" ]; then
    echo "Error: could not resolve remote head for branch '$branch'"
    exit 1
fi

if [ "$current_head" != "$newest_head" ]; then
    echo "Update available — updating..."

    git fetch origin "$branch"
    git reset --hard "origin/$branch"
    git clean -fd

    if [ -f requirements.txt ]; then
        echo "Installing Python dependencies..."
        /usr/bin/python3 -m pip install -r requirements.txt
    fi

    echo "Restarting service..."
    systemctl restart "$SERVICE_NAME"

    echo "Update complete."
else
    echo "Already up to date."
fi