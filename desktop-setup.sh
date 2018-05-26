# nvim
## add appimage version once it works
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt -y install code
cp vscode/settings.json ~/.config/Code/User/settings.json

# misc software
sudo apt install -y meld

# edit /etc/apt/sources.list and add contrib
# sudo apt install -y fonts-firacode