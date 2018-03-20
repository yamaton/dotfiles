# configurations are in ~/confs
[ ! -d ~/confs ] &&  mkdir ~/confs
cd ~/confs

# update the system
sudo apt update && sudo apt full-upgrade

# git
sudo apt install -y git

# zsh
sudo apt install -y zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/olivierverdier/zsh-git-prompt.git
cp mysetting/.zshrc ~
chsh -s $(which zsh)

# tmux and emacs setting
cp mysetting/.tmux.conf ~
cp mysetting/.emacs ~

# misc software
sudo apt install -y make cmake tmux emacs-nox htop ranger autojump meld

# tldr
sudo apt install libzip-dev libcurl4-openssl-dev  # tldr needs them
cd ~/confs
git clone https://github.com/tldr-pages/tldr-cpp-client.git tldr-c-client
cd tldr-c-client
./deps.sh
make
sudo make install
mv ~/confs/tldr-c-client/autocomplete/complete.zsh ~/.tldr.complete
echo "source ~/.tldr.complete" >> ~/.zshrc

# ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
sudo dpkg -i ripgrep_0.8.1_amd64.deb

