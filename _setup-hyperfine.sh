#!/usr/bin/env bash

readonly CMD=hyperfine

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        case "$(uname -m)" in
            "x86_64") readonly FILE="hyperfine-v${VERSION}-x86_64-unknown-linux-musl.tar.gz" ;;
            "armv7l") readonly FILE="hyperfine-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz" ;;
            "aarch64") readonly FILE="hyperfine-v${VERSION}-aarch64-unknown-linux-gnu.tar.gz" ;;
        esac
        readonly URL="https://github.com/sharkdp/hyperfine/releases/download/v${VERSION}/${FILE}"
        wget -N "$URL"
        tar -xvf "$FILE"
        DIR="${FILE%.*.*}"
        (
            cd "$DIR" || exit
            mkdircp autocomplete/"${CMD}.bash" ~/.bash_completion.d/
            mkdircp autocomplete/"_${CMD}" ~/.zfunc
            mkdircp autocomplete/"${CMD}.fish" ~/.config/fish/completions/
            mkdircp "${CMD}" ~/.local/bin/
            mkdircp "${CMD}.1" ~/.local/share/man/man1/
        )
        mandb ~/.local/share/man/
        rm -rf "$DIR" "$FILE"
    fi
fi
