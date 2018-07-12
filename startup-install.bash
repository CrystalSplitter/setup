#!/bin/bash

# check if root first
if [ "$EUID" -ne 0 ]; then
    echo 'Insufficient permissions. Are you running as root?'
    exit 1
fi

# Setup non-free sources
cp "$SOURCE_LIST_LOC" '/tmp/sources.list'
sed '{s/main$/main non-free/}' '/tmp/sources.list' > "$SOURCE_LIST_LOC"
rm '/tmp/sources.list'

# ============================================================================

apt install sudo
printf 'Running visudo... [press enter to continue]'
read tmp_
visudo

printf 'Primary non-root username?> '
read U
printf 'Reconfigure locale? [y/n]> '
read LOCALE_CONFIG
printf 'Install Java-related packages? [y/n]> '
read JAV_CONFIG
printf 'Install desktop applications? [y/n]> '
read DESKTOP_CONFIG

echo 'BEGINNING INSTALL ==================================================='

# Update the apt repository
apt update
apt upgrade

yes | apt install build-essential cmake firmware-linux-nonfree

if [[ "$LOCALE_CONFIG" == 'y' ]]; then
    echo 'Running dpkg-reconfigure to alter the locale...'
    dpkg-reconfigure locales
fi

# Set zsh
apt install zsh
ZSH_SUCC=$?
if [[ "$ZSH_SUCC" == 0 ]]; then
    chsh -s /bin/zsh
    runuser -l $U -c $(chsh -s /bin/zsh)
fi

apt install -y vim curl tmux
apt install -y ffmpeg git python-pip python3-pip fail2ban

if [[ "$JAV_CONFIG" == 'y' ]]; then
    yes | apt install openjdk-8-jre maven
fi

if [[ "$DESKTOP_CONFIG" == 'y' ]]; then
    echo 'Installing desktop applictaions... '
    apt install -y audacity inkscape vlc texmaker krita steam snapd
fi

echo '!!! Make sure to edit your .zshrc .vimrc .Xresources !!!'

# Run the arbitrary installation files
