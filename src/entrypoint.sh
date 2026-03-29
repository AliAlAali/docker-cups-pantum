#!/bin/bash
set -e

if [ -z "$CUPS_ADMIN_USER" ] || [ -z "$CUPS_ADMIN_PASSWORD" ]; then
    echo "ERROR: CUPS_ADMIN_USER and CUPS_ADMIN_PASSWORD must be set"
    exit 1
fi

# Create admin user
useradd -m "$CUPS_ADMIN_USER" || true
echo "$CUPS_ADMIN_USER:$CUPS_ADMIN_PASSWORD" | chpasswd
usermod -aG lpadmin "$CUPS_ADMIN_USER"

# Fix permissions
chown -R root:lp /etc/cups
chmod -R 750 /etc/cups

# Share printer using mDNS through avahi
rm -f /run/dbus/pid
mkdir -p /run/dbus
dbus-daemon --system --fork
avahi-daemon -D
ipp-usb standalone &

echo "Starting CUPS..."
exec /usr/sbin/cupsd -f