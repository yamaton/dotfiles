#!/usr/bin/env bash

readonly NAME=neovim
readonly CMD=nvim

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
readonly REPO_DIR="${HOME}/confs"
readonly BIN_DIR="${HOME}/.local/bin/"
readonly CONFIG_DIR="${HOME}/.config/$CMD"

# VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"

url="https://api.github.com/repos/neovim/neovim/releases"
VERSION="$(curl --silent ${url} | jq '.[0].name' | tr -d \" | cut -d ' ' -f 2 | cut -c 2-)"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f2 | cut -c 2-)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi


if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v nvim)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
    elif [[ "$(uname -m)" == "x86_64" ]] && [[ "$(uname -s)" == "Linux" ]]; then
        readonly URI="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"

        mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
        wget -N "$URI"
        chmod +x ./nvim.appimage
        sudo apt install -y fuse
        sudo ln -sf "${BIN_DIR}/nvim.appimage" /usr/local/bin/nvim

        mkdir -p ~/.local/share/man/man1
        readonly MANURL="https://raw.githubusercontent.com/neovim/neovim/nightly/man/nvim.1"
        wget --output-document ~/.local/share/man/man1/nvim.1 -N "$MANURL"
        mandb ~/.local/share/man

    elif [[ "$(uname -m)" != "x86_64" ]] && [[ -x "$(command -v apt)" ]]; then
        sudo apt install --no-install-recommends -y neovim
    fi

    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p "$CONFIG_DIR"
    [[ -f "$CONFIG_DIR/init.vim" ]] && mv -f "$CONFIG_DIR"/init.vim "$CONFIG_DIR"/init.vim.backup
    ln -sf "$BASEDIR"/.config/nvim/init.vim "$CONFIG_DIR"

    # call :PlugInstall from the shell
    nvim --headless +PlugInstall +qa

    [[ -f "$HOME/.vimrc" ]] && mv -f "$HOME/.vimrc" "$HOME/.vimrc.backup"
    ln -sf "$BASEDIR"/.vimrc ~/.vimrc
fi
