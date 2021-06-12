#!/bin/bash

set -e -x

# check if root first
if [ "$EUID" -ne 0 ]; then
    echo 'Insufficient permissions. Are you running as root?'
    exit 1
fi

source "./ubuntu-2021-config.env"


# ============================================================================

add-apt-repository multiverse
apt update
apt upgrade

apt install -y "${ALWAYS_INSTALL[@]}"

# Set zsh
#apt install zsh
#ZSH_SUCC=$?
#if [[ "$ZSH_SUCC" == 0 ]]; then
#    chsh -s /bin/zsh
#    runuser -l $U -c $(chsh -s /bin/zsh)
#fi

# ---------------------------------------------------------------------

if [[ ! -z "$INSTALL_GENERAL_DEV" ]]; then
    apt install -y "${GENERAL_DEV[@]}"
fi

if [[ ! -z "$INSTALL_CPP_CLANG_DEV" ]]; then
    apt install -y "${CPP_CLANG_DEV[@]}"
fi

if [[ ! -z "$INSTALL_PYTHON_APT_DEV" ]]; then
    apt install -y "${PYTHON_APT_DEV[@]}"
fi

if [[ ! -z "$INSTALL_HASKELL_DEV" ]]; then
    sudo -H -u "${_USER_NAME}" bash -c \
        'curl --proto "=https" --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh'
fi

if [[ ! -z "$INSTALL_RUST_DEV" ]]; then
    sudo -H -u "${_USER_NAME}" bash -c \
        'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh'
fi

# ---------------------------------------------------------------------

if [[ ! -z "$INSTALL_DESKTOP_APPS" ]]; then
    apt install -y "${DESKTOP_APPS[@]}"
    curl -o '/tmp/discord.deb' -L 'https://discord.com/api/download?platform=linux&format=deb'
    apt install -y '/tmp/discord.deb'
    rm '/tmp/discord.deb'
    
    if [[ ! -z "$INSTALL_STEAM_APT" ]]; then
        apt install -y steam
    fi

    if [[ ! -z "$INSTALL_GNOME_TWEAKS" ]]; then
        apt install -y gnome-tweaks
    fi

    if [[ ! -z "$INSTALL_CREATIVE_APPS" ]]; then
        apt install -y "${CREATIVE_APPS[@]}"
    fi
fi

if [[ ! -z "$INSTALL_LIBRE_OFFICE" ]]; then
    apt install -y libreoffice
fi

echo '!!! Make sure to edit your .zshrc .vimrc .Xresources !!!'
