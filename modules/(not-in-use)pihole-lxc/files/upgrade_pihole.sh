#!/bin/sh
# pihole-upgrade.sh - Upgrade Pi-hole to the latest version
# Usage: ./pihole-upgrade.sh

set -e

# PiHole v6 does not yet support Alpine, but this line can be removed when it does
export PIHOLE_SKIP_OS_CHECK=true

echo "🛡️ Pi-hole Upgrade Script"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "❌ This script must be run as root"
  exit 1
fi

# Check if pihole command exists
if ! command -v pihole >/dev/null 2>&1; then
  echo "❌ Pi-hole does not appear to be installed (pihole command not found)"
  exit 1
fi

# Display current version
CURRENT_VERSION=$(pihole -v | grep -i "Pi-hole version" | awk '{print $4}')
echo "🔍 Current Pi-hole version: $CURRENT_VERSION"

# Run the Pi-hole updater
echo "⬆️ Upgrading Pi-hole..."
pihole -up

# Verify the upgrade
NEW_VERSION=$(pihole -v | grep -i "Pi-hole version" | awk '{print $4}')
echo "✅ Pi-hole upgraded from $CURRENT_VERSION to $NEW_VERSION"

# Check Pi-hole status
echo "🔍 Checking Pi-hole status..."
pihole status

# Unset the environment variables
unset PIHOLE_SKIP_OS_CHECK