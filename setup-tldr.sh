# * Usage
# Run `./setup-dldr.sh <target-dir>`
# Then it will clone tlcr-cpp-client under <target-dir> and install it.
#
CONFDIR="$1"
sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
cd "${CONFDIR}"
git clone https://github.com/tldr-pages/tldr-cpp-client.git tldr-cpp-client
cd tldr-cpp-client
./deps.sh
make
sudo make install
mv "${CONFDIR}"/tldr-cpp-client/autocomplete/complete.zsh ~/.tldr.complete
echo "source ~/.tldr.complete" >> ~/.zshrc