#!/bin/bash
CURRFLD=$PWD
apt-get update -y && apt-get dist-upgrade -y

if [ ! -d "~/.ssh" ]; then
    mkdir ~/.ssh
fi

if [[ $(stat -L -c "%a" ~/.ssh) != "700"]]; then
    chmod 777 ~/.ssh
fi

if [ ! -f "~/.ssh/id_rsa"]
    ssh-keygen -f ~/.ssh/id_rsa -N ''
    cat ~/.ssh/id_rsa.pub
    while read -r -p "please add the key to github and confirm (y/n)? " response && ([ "$response" != "y" ] && [ "$response" != "Y" ])
    do
        echo "you need to confirm!"
    done
fi

if [[ $(stat -L -c "%a" ~/.ssh/id_rsa) != "600"]]; then
    chmod 600 ~/.ssh/id_rsa
fi

if [[ $(stat -L -c "%a" ~/.ssh/id_rsa.pub) != "644"]]; then
    chmod 644 ~/.ssh/id_rsa.pub
fi

apt-get install git

if [ ! -d "~/Proxmox-01.lan2play.local" ]; then
    git clone git@github.com:Lan2Play/Proxmox-01.lan2play.local.git ~/Proxmox-01.lan2play.local
fi

cd ~/Proxmox-01.lan2play.local; git pull; cd $CURRFLD

if [ ! -f "~/Proxmox-01.lan2play.local/firstbootstrapped"]
    touch ~/Proxmox-01.lan2play.local/firstbootstrapped
    ~/Proxmox-01.lan2play.local/addsecondhd.sh
fi

~/Proxmox-01.lan2play.local/installserver.sh 