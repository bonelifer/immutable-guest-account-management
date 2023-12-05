#!/bin/bash

# Script: guestacc_downloads_management.sh
# Description: Manages Downloads directory actions for the 'guestacc' account.

# Set XDG_DOWNLOAD_DIR for 'guest-template'
echo "export XDG_DOWNLOAD_DIR=/tmp/Downloads" >> "/home/guest-template/.profile"

# Clear Downloads directory on 'guestacc' logout
cat << 'EOF' > "/home/guest-template/guestacc_downloads_actions.sh"
#!/bin/bash

if [ -d "/tmp/Downloads" ]; then
    rm -rf /tmp/Downloads/*
    rmdir /tmp/Downloads
fi
EOF
chmod +x "/home/guest-template/guestacc_downloads_actions.sh"

# Check if 'guestacc' PAM logout configuration exists
if ! grep -q "session optional /home/guestacc/guestacc_downloads_actions.sh" /etc/pam.d/logout; then
    # Add PAM configuration for 'guestacc' logout
    echo "session optional /home/guestacc/guestacc_downloads_actions.sh" >> /etc/pam.d/logout
fi

# Create script for 'guestacc' Downloads directory check and creation on login
cat << 'EOF' > "/home/guest-template/guestacc_check_create_downloads.sh"
#!/bin/bash

if [ ! -d "/tmp/Downloads" ]; then
    mkdir -p /tmp/Downloads
    chown -R guestacc:guestacc /tmp/Downloads
    chmod -R go-rwx /tmp/Downloads
fi
EOF
chmod +x "/home/guest-template/guestacc_check_create_downloads.sh"

# Check if 'guestacc' PAM login configuration exists
if ! grep -q "session optional /home/guestacc/guestacc_check_create_downloads.sh" /etc/pam.d/login; then
    # Add PAM configuration for 'guestacc' login
    echo "session optional /home/guestacc/guestacc_check_create_downloads.sh" >> /etc/pam.d/login
fi

