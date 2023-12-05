#!/bin/bash
################################################################################
# Script Name: create-guest-template-account.sh
# Description: Automates the creation of a guest template account to establish 
#              systemwide software preferences and configurations. This account 
#              serves as the basis for 'guestacc' settings.
#
# Usage: sudo bash create-guest-template-account.sh
#        (Ensure to run with appropriate permissions)
################################################################################

check_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo "Please run this script with sudo or as root."
        exit 1
    fi
}

create_guest_template_account() {
    GUEST_TEMPLATE="guest-template"
    GUEST_TEMPLATE_PASSWORD="YourHardcodedPasswordHere"  # Change this to your desired password

    # Create the guest template account if it doesn't exist
    if ! id "$GUEST_TEMPLATE" &>/dev/null; then
        useradd -m -s /bin/bash -G users "$GUEST_TEMPLATE"
        echo -e "$GUEST_TEMPLATE_PASSWORD\n$GUEST_TEMPLATE_PASSWORD" | passwd "$GUEST_TEMPLATE"
    else
        echo "The guest template account '$GUEST_TEMPLATE' already exists."
        exit 1
    fi
}

# Call the function to check for sudo
check_sudo

# Create the guest template account and set up actions
create_guest_template_account

echo "Guest template account created successfully with the specified password."

