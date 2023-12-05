#!/bin/bash
################################################################################
# Script Name: update-guest-squashfs.sh
# Description: Automates the update of content for the guest account 'guestacc' 
#              using SquashFS generated from the 'guest-template' account's 
#              preferences and software installations. The SquashFS file created
#              here is utilized by scripts configuring the 'guestacc' account.
#
# Usage: sudo bash update-guest-squashfs.sh
#        (Ensure to run with appropriate permissions)
################################################################################

check_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please run this script with sudo or as root."
        exit 1
    fi
}

get_xdg_runtime_dir() {
    GUEST_ACCOUNT="guestacc"
    XDG_RUNTIME_DIR=$(getent passwd "$GUEST_ACCOUNT" | cut -d: -f6)/$(basename $(ls -td -- /run/user/*/"$GUEST_ACCOUNT" 2>/dev/null | head -n 1))
    echo "$XDG_RUNTIME_DIR"
}

# Call the function to check for sudo
check_sudo

# Get the XDG_RUNTIME_DIR for the guest account
XDG_RUNTIME_DIR=$(get_xdg_runtime_dir)

# Directory containing updated content
UPDATED_CONTENT_DIR="/home/guest-template"  # Update to your guest template directory

# Guest account's SquashFS file
GUEST_SQUASHFS="/var/lib/guestacc/guest_content.squashfs"  # SquashFS location

# Unmount existing guest directory if mounted
if mountpoint -q /home/guest; then
    umount /home/guest
fi

# Create or update SquashFS
mksquashfs "$UPDATED_CONTENT_DIR" "$GUEST_SQUASHFS"

# Mount the SquashFS for the guest account
GUEST_ACCOUNT_DIR="$XDG_RUNTIME_DIR/home-overlay/basedir"
GUEST_WORK_DIR="$XDG_RUNTIME_DIR/home-overlay/workdir"
GUEST_UPPER_DIR="$XDG_RUNTIME_DIR/home-overlay/overlaydir"

mount -t overlay overlay -o lowerdir="$GUEST_ACCOUNT_DIR",upperdir="$GUEST_UPPER_DIR",workdir="$GUEST_WORK_DIR" /home/guest

