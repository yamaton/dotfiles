# nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt -y install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp init.vim ~/.config/nvim/init.vim

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt -y install code

# misc software
sudo apt install -y vlc gnome-tweak-tool filezilla meld cntlm caffeine exfat-fuse exfat-utils
sudo add-apt-repository universe
sudo apt install -y fonts-firacode


