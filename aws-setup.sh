cd ~/confs
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/olivierverdier/zsh-git-prompt.git
cp mysetting/.zshrc ~
cp mysetting/.tmux.conf ~
cp mysetting/.emacs ~
sudo apt update
sudo apt install -y zsh
sudo apt install -y tmux emacs-nox htop
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

