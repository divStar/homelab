#!/bin/bash
set -e

# Define common paths and URLs
LLDAP_DIR="/opt/lldap"
GITHUB_REPO="lldap/lldap"
GITHUB_API_URL="https://api.github.com/repos/${GITHUB_REPO}/releases/latest"
LLDAP_BINARY="${LLDAP_DIR}/lldap"
LLDAP_CONFIG="/data/lldap_config.toml"

# Function to get latest release version from GitHub
get_latest_version() {
  busybox wget -q -O - ${GITHUB_API_URL} | busybox grep '"tag_name":' | busybox sed -E 's/.*"([^"]+)".*/\1/' | busybox sed 's/^v//'
}

# Function to get currently installed version
get_current_version() {
  if [ -f "${LLDAP_BINARY}" ]; then
    # Extract version number and remove the "lldap " prefix
    ${LLDAP_BINARY} --version 2>/dev/null | head -n1 | sed 's/lldap //'
  else
    echo "not_installed"
  fi
}

# Get current version (without the v prefix)
CURRENT_VERSION=$(get_current_version)

# Get target version (either from command line or latest from GitHub)
# Remove 'v' prefix if present in the argument
TARGET_VERSION=${1#v}
if [ -z "$TARGET_VERSION" ]; then
  TARGET_VERSION=$(get_latest_version)
fi

echo "Current version: $CURRENT_VERSION"
echo "Target version: $TARGET_VERSION"

# Skip if versions are the same
if [ "$CURRENT_VERSION" = "$TARGET_VERSION" ]; then
  echo "LLDAP is already at version $TARGET_VERSION. No action needed."
  exit 0
fi

# Stop lldap service if it's running - using more specific matching
LLDAP_PROCESS="/opt/lldap/lldap run"
if pgrep -f "${LLDAP_PROCESS}" > /dev/null; then
  echo "Stopping LLDAP service..."
  pkill -f "${LLDAP_PROCESS}" || true
  # Wait a moment for service to stop
  sleep 2
  echo "Process stopped!"
fi

# Define backup directory
BACKUP_DIR="${LLDAP_DIR}_${CURRENT_VERSION}"

# If LLDAP is installed, back up the old version
if [ "$CURRENT_VERSION" != "not_installed" ]; then
  echo "Backing up existing installation..."
  mv ${LLDAP_DIR} "${BACKUP_DIR}"
fi

# Create lldap directory if it doesn't exist
mkdir -p ${LLDAP_DIR}

# Download and extract new version
echo "Downloading LLDAP version $TARGET_VERSION..."
TEMP_DIR=$(mktemp -d)
DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/v${TARGET_VERSION}/amd64-lldap.tar.gz"
TARBALL="${TEMP_DIR}/lldap.tar.gz"
busybox wget -O "${TARBALL}" "${DOWNLOAD_URL}"

echo "Extracting to ${LLDAP_DIR}..."
busybox tar -xzf "${TARBALL}" -C ${LLDAP_DIR} --strip-components=1

# Set permissions for executables
EXECUTABLES=("lldap" "lldap_set_password" "lldap_migration_tool")
for executable in "${EXECUTABLES[@]}"; do
  chmod +x "${LLDAP_DIR}/${executable}"
done

# Cleanup
rm -rf "${TEMP_DIR}"

echo "LLDAP $TARGET_VERSION installed to ${LLDAP_DIR}"
echo "Upgrade completed successfully."

# Start the service with nohup and proper redirection as requested
echo "Starting LLDAP service..."
rc-update add lldap default
rc-service lldap start