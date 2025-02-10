#!/bin/bash
set -e

# Pull latest code
cd ~/hng12-stage2
git pull origin main

# Build and restart Docker container
docker compose down
docker compose up -d --build

# Reload Nginx
sudo systemctl reload nginx
