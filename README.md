# Immutable Guest Account Management Scripts

![License: GPL-2.0](https://img.shields.io/badge/License-GPL%202.0-blue.svg) ![Bash Scripts](https://img.shields.io/badge/Scripts-Made%20with%20BASH-blue)

## Overview

The scripts automate the creation and setup of a guest account ('guestacc') based on settings inherited from a 'guest-template' account. They ensure a secure and isolated environment for guest users.

For a detailed overview of the project including script descriptions, you can refer to [OVERVIEW.md](./OVERVIEW.md).

## Usage

To set up the guest account properly, follow this order:

1. **Create Guest Account**: Choose and execute either `create-guest-account.sh` or `create-guest-account-alternative.sh` based on your system requirements. Ensure you run only one of these scripts to set up the guest account with the appropriate method.

2. **Install Systemwide Software from Admin Account**: As an administrator, install all necessary software and configurations systemwide from your account.

3. **Login to Guest-Template Account for Software Preferences**: Log in to the 'guest-template' account to modify preferences or configurations in each systemwide installed software to tailor them for the guest account.

4. **Update Guest SquashFS**: Run `update-guest-squashfs.sh` to update content for the guest account using SquashFS generated from the modified preferences and software configurations in the 'guest-template' account.

5. **Manage Guestacc Downloads Directory**: Scripts have been provided to manage the Downloads directory for 'guestacc' on login and logout.

Please use these scripts responsibly and ensure the necessary steps are followed in the specified order to properly configure the guest account with the desired preferences and software configurations.

## Scripts and Descriptions

| Script                           | Description                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------|
| `create-guest-account.sh`        | Automates the creation of the guest account with overlay filesystem using `pam_mount`.       |
| `update-guest-squashfs.sh`       | Updates content for the guest account using SquashFS generated from 'guest-template'.        |
| `create-guest-template-account.sh` | Automates the creation of a guest template account to establish systemwide preferences.      |
| `create-guest-account-alternative.sh` | Alternative script for creating the guest account directly without `pam_mount`.             |
| `guestacc_downloads_management.sh` | Manages Downloads directory actions for the 'guestacc' account on login and logout using PAM.|

**Important Note:** Users should carefully choose and execute only one of the two provided scripts: `create-guest-account.sh` or `create-guest-account-alternative.sh` based on their system requirements.

## Contributing

Contributions are welcome. Feel free to fork this repository, make modifications, and create a pull request.

## Issues

If you encounter any issues or have suggestions for improvements, please [open an issue](./issues).

## Disclaimer

Please use these scripts responsibly. Ensure proper understanding of their functionality and implications before use.

## License

This project is licensed under the [GNU General Public License v2.0](./LICENSE.md). You are free to modify and distribute the scripts under the terms of this license.
