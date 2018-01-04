[ ! -d ~/confs ] &&  mkdir ~/confs
cd ~/confs
sudo apt install -y git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/olivierverdier/zsh-git-prompt.git
cp mysetting/.zshrc ~
cp mysetting/.tmux.conf ~
cp mysetting/.emacs ~
sudo apt update && sudo apt full-upgrade
sudo apt install -y zsh
chsh -s $(which zsh)
sudo apt install -y tmux emacs-nox htop ranger

# autojump
sudo apt install autojump
echo ". /usr/local/etc/profile.d/autojump.sh" >> ~/.zshrc

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
mkdir -p ~/bin/ripgrep
cd ~/bin
wget https://github.com/BurntSushi/ripgrep/releases/download/0.7.1/ripgrep-0.7.1-i686-unknown-linux-musl.tar.gz
tar xzf ripgrep-0.7.1-i686-unknown-linux-musl.tar.gz -C ripgrep
echo "export PATH=${PATH}:~/bin/ripgrep" >> ~/.zshenv
