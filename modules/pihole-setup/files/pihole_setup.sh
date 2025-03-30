#!/bin/bash
# Pi-hole v6 Installation Script for Alpine Linux
# Assumes packages are already installed and mount points are set up

# Configuration variables
PIHOLE_UID=1000
PIHOLE_GID=1000
PIHOLE_USER="pihole"
PIHOLE_GROUP="pihole"

# Repository URLs
WEB_REPO_URL="https://github.com/pi-hole/web.git"
# TODO: use when https://github.com/pi-hole/pi-hole/pull/6092 merged: CORE_REPO_URL="https://github.com/pi-hole/pi-hole.git"
CORE_REPO_URL="https://github.com/jrittenh/pi-hole.git"
FTL_RELEASE_URL="https://github.com/pi-hole/ftl/releases/latest/download"
MACVENDOR_URL="https://ftl.pi-hole.net/macvendor.db"

# Branch variables
WEB_BRANCH="master"
# TODO: use when https://github.com/pi-hole/pi-hole/pull/6092 merged: CORE_BRANCH="master"
CORE_BRANCH="alpine"

# Admin password (passed as parameter)
ADMIN_PASSWORD="${1:-}"

# Create pihole user and group
addgroup -S ${PIHOLE_GROUP} -g ${PIHOLE_GID} || true
adduser -S ${PIHOLE_USER} -G ${PIHOLE_GROUP} -u ${PIHOLE_UID} || true

# Download macvendor database
curl -sSL ${MACVENDOR_URL} -o /etc/pihole/macvendor.db

# Clone Pi-hole repositories
git clone --depth 1 --single-branch --branch ${WEB_BRANCH} ${WEB_REPO_URL} /var/www/html/admin
git clone --depth 1 --single-branch --branch ${CORE_BRANCH} ${CORE_REPO_URL} /etc/.pihole

# Install Pi-hole files without changing directories
install -Dm755 -t /opt/pihole /etc/.pihole/gravity.sh
install -Dm755 -t /opt/pihole /etc/.pihole/advanced/Scripts/*.sh
install -Dm755 -t /opt/pihole /etc/.pihole/advanced/Scripts/COL_TABLE
install -Dm644 -t /etc/pihole /etc/.pihole/advanced/Templates/logrotate
install -Dm755 -t /usr/local/bin /etc/.pihole/pihole
install -Dm644 /etc/.pihole/advanced/bash-completion/pihole /etc/bash_completion.d/pihole
install -T -m 0755 /etc/.pihole/advanced/Templates/pihole-FTL-prestart.sh /opt/pihole/pihole-FTL-prestart.sh
install -T -m 0755 /etc/.pihole/advanced/Templates/pihole-FTL-poststop.sh /opt/pihole/pihole-FTL-poststop.sh

# Download and install FTL (Pi-hole's engine)
curl -sSL "${FTL_RELEASE_URL}/pihole-FTL-amd64" -o /usr/bin/pihole-FTL
chmod +x /usr/bin/pihole-FTL

# Verify FTL binary
readelf -h /usr/bin/pihole-FTL || (echo "Error with downloaded FTL binary" && exit 1)
/usr/bin/pihole-FTL -vv

# Set Pi-hole environment variables
export DNSMASQ_USER=${PIHOLE_USER}
export FTL_CMD=no-daemon

# Enable FTL service at startup
rc-update add pihole-FTL default

# Make service executable
chmod +x /etc/init.d/pihole-FTL

# Start service
/etc/init.d/pihole-FTL start

# Run gravity to download blocklists
pihole -g

# Set admin password if provided
if [[ -n "${ADMIN_PASSWORD}" ]]; then
    pihole -a -p "${ADMIN_PASSWORD}"
    echo "Pi-hole admin password has been set to the provided value"
else
    echo "No admin password provided. You can set it later with: pihole -a -p PASSWORD"
fi

IP_ADDRESS=$(ip -4 addr show scope global | grep -oP '(?<=inet\s)[\d.]+' | head -1)

echo "Pi-hole v6 installation complete!"
echo "Web interface is available at: https://${IP_ADDRESS}/admin"