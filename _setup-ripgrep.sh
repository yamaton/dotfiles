


if [ ! -x "$(command -v rg)" ]; then
    if [ "$(uname -m)" == "x86_64" ]; then
        wget https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
        sudo apt install ./ripgrep_0.10.0_amd64.deb
    fi
    if [ "$(uname -m)" == "armv7l" ]; then
        wget https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-arm-unknown-linux-gnueabihf.tar.gz
        tar xzf ./ripgrep-0.10.0-arm-unknown-linux-gnueabihf.tar.gz
        cp ripgrep-0.10.0-arm-unknown-linux-gnueabihf/rg ~/bin
    fi
fi
