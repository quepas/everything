#!/bin/sh
# Some Ubuntu releases are out of support like Ubuntu 23.04 (as of 2025-02-28).
# This means that running `sudo apt update` fails as these APT sources don't exist anymore:
#   * `archive.ubuntu.com`
#   * `security.ubuntu.com`
# The solution is to change these links to: `old-releases.ubuntu.com` which is still maintained!
#
# Credit @fossfreedom: https://askubuntu.com/a/91821/894912
#
sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade

# Optionally, at this point, you can update your distro to a supported version!
# sudo apt-get update
# sudo apt-get install ubuntu-release-upgrader-core
# sudo do-release-upgrade
