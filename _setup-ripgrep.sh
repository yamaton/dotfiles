if [ ! -x "$(command -v rg)" ]; then
    wget https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
    sudo apt install ./ripgrep_0.9.0_amd64.deb
fi
