#!/bin/bash

set -e -x

# check if root first
if [[ "$EUID" -ne 0 ]]; then
    echo 'Insufficient permissions. Are you running as root?'
    exit 1
fi

source './ubuntu-2021-config.env'

function curl_deb {
    url="$1"
    curl -fLo '/tmp/new_pkg.deb' "$url"
    apt install -y '/tmp/new_pkg.deb'
    rm '/tmp/new_pkg.deb'
}

# ============================================================================

add-apt-repository multiverse
apt update
apt upgrade -y

apt install -y "${ALWAYS_INSTALL[@]}"

# Set zsh
#apt install zsh
#ZSH_SUCC=$?
#if [[ "$ZSH_SUCC" == 0 ]]; then
#    chsh -s /bin/zsh
#    runuser -l $U -c $(chsh -s /bin/zsh)
#fi

user_shell='/bin/bash'

# ---------------------------------------------------------------------

if [[ ! -z "$INSTALL_GENERAL_DEV" ]]; then
    apt install -y "${GENERAL_DEV[@]}"

    if [[ ! -z "$INSTALL_PLUG_NEOVIM" ]]; then
        sudo -H -u "${_user_name}" \
            sh -c \
            'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi
fi

if [[ ! -z "$INSTALL_MESA_UTLS" ]]; then
    apt install -y "${MESA_UTILS[@]}"
fi

if [[ ! -z "$INSTALL_CPP_CLANG_DEV" ]]; then
    apt install -y "${CPP_CLANG_DEV[@]}"
fi

if [[ ! -z "$INSTALL_PYTHON_APT_DEV" ]]; then
    apt install -y "${PYTHON_APT_DEV[@]}"
fi

if [[ ! -z "$INSTALL_HASKELL_DEV" ]]; then
    # These are necessary to install before ghcup.
    apt install -y \
        libffi-dev \
        libffi7 \
        libgmp10 \
        libncurses-dev \
        libncurses5 \
        libtinfo5
    sudo -H -u "${_user_name}" "${user_shell}" -c \
        'curl --proto "=https" --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh'
fi

if [[ ! -z "$INSTALL_RUST_DEV" ]]; then
    sudo -H -u "${_user_name}" "${user_shell}" -c \
        'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh'
fi

# ---------------------------------------------------------------------

if [[ ! -z "$INSTALL_DESKTOP_APPS" ]]; then
    apt install -y "${DESKTOP_APPS[@]}"
    curl_deb 'https://discord.com/api/download?platform=linux&format=deb'
    
    if [[ ! -z "$INSTALL_STEAM_APT" ]]; then
        apt install -y steam
    fi

    if [[ ! -z "$INSTALL_GNOME_TWEAKS" ]]; then
        apt install -y gnome-tweaks
    fi

    if [[ ! -z "$INSTALL_CREATIVE_APPS" ]]; then
        curl_deb 'https://github.com/DIGImend/digimend-kernel-drivers/releases/download/v10/digimend-dkms_10_all.deb'
        apt install -y "${CREATIVE_APPS[@]}"
    fi
fi

if [[ ! -z "$INSTALL_LIBRE_OFFICE" ]]; then
    apt install -y libreoffice
fi

echo '!!! Make sure to edit your .zshrc .vimrc .Xresources !!!'
