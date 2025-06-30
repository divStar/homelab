#!/bin/sh
# alpine-upgrade.sh - Upgrade Alpine Linux to a new major version
# Usage: ./alpine-upgrade.sh 3.21

set -e

if [ -z "$1" ]; then
  echo "Error: Target Alpine version required"
  echo "Usage: $0 <version>"
  echo "Example: $0 3.21"
  exit 1
fi

NEW_VERSION="$1"
CURRENT_VERSION=$(cat /etc/alpine-release)

echo "🔍 Current Alpine version: $CURRENT_VERSION"
echo "🚀 Target Alpine version: $NEW_VERSION"

# Backup repositories file
echo "📋 Backing up repository configuration..."
cp /etc/apk/repositories /etc/apk/repositories.bak.$(date +%Y%m%d)

# Update repositories to point to new version
echo "🔄 Updating repository URLs to v$NEW_VERSION..."
sed -i "s/v$CURRENT_VERSION/v$NEW_VERSION/g" /etc/apk/repositories

# Update package index
echo "⏳ Updating package index..."
apk update

# Upgrade system packages
echo "⬆️ Upgrading system packages..."
apk upgrade

# Update world packages
echo "🌐 Upgrading all installed packages..."
apk fix
apk upgrade --available

echo "✅ Alpine Linux upgraded from v$CURRENT_VERSION to v$NEW_VERSION"
echo "📝 Note: You should reboot your system to use the new kernel"
echo "   Run: reboot"