#!/bin/bash
CURRFLD=$PWD
apt-get update -y && apt-get dist-upgrade -y

if [ ! -d "/root/.ssh" ]; then
    mkdir /root/.ssh
fi

if [[ "$(stat -L -c '%a' /root/.ssh)" != "700" ]]; then
    chmod 700 /root/.ssh
fi

if [ ! -f "/root/.ssh/id_rsa"]
    ssh-keygen -f /root/.ssh/id_rsa -N ''
    cat /root/.ssh/id_rsa.pub
    while read -r -p "please add the key to github and confirm (y/n)? " response && ([ "$response" != "y" ] && [ "$response" != "Y" ])
    do
        echo "you need to confirm!"
    done
fi

if [[ "$(stat -L -c '%a' /root/.ssh/id_rsa)" != "600" ]]; then
    chmod 600 /root/.ssh/id_rsa
fi

if [[ "$(stat -L -c '%a' /root/.ssh/id_rsa.pub)" != "644" ]]; then
    chmod 644 /root/.ssh/id_rsa.pub
fi

apt-get install git -y

if [ ! -d "/root/Proxmox-01.lan2play.local" ]; then
    git clone git@github.com:Lan2Play/Proxmox-01.lan2play.local.git /root/Proxmox-01.lan2play.local
fi

cd /root/Proxmox-01.lan2play.local; git pull; cd $CURRFLD

if [ ! -f "/root/Proxmox-01.lan2play.local/firstbootstrapped" ]; then
    touch /root/Proxmox-01.lan2play.local/firstbootstrapped
    /root/Proxmox-01.lan2play.local/addsecondhd.sh
fi

/root/Proxmox-01.lan2play.local/installserver.sh 