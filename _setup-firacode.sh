# Edit /etc/apt/sources.list
os_str=$(lsb_release -i -s)
echo $os_str

if [ "$os_str" == "Debian" ]
then
    sudo cat << 'EOF' > /etc/apt/sources.list
deb http://deb.debian.org/debian stretch main contrib non-free
deb-src http://deb.debian.org/debian stretch main contrib non-free

deb http://deb.debian.org/debian stretch-updates main contrib non-free
deb-src http://deb.debian.org/debian stretch-updates main contrib non-free

deb http://security.debian.org/debian-security/ stretch/updates main contrib non-free
deb-src http://security.debian.org/debian-security/ stretch/updates main contrib non-free
EOF
elif [ "$os_str" == "Ubuntu" ]
    sudo add-apt-repository universe
fi

sudo apt install -y fonts-firacode
