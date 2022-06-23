#!/bin/bash

NAME=$1
#MEM=$2 #:-1024}
#HDD=$3 #:-50240}
# Add the ISOs names to be created.
# To add .ova use the vbox_install_ova script.
ISO="Win10_21H1_English_x64.iso"
#ISO="ubuntu-20.04.3-desktop-amd64.iso"
#ISO="CentOS.vdi"
#ISO="kali-linux-2022.2-virtualbox-amd64.ova"

sudo mkdir -p /srv/virtualbox\

sudo vboxmanage createvm \
    --ostype Ubuntu_64 \
    --basefolder "/srv/virtualbox" \
    --register \
    --name "$NAME"

sudo vboxmanage modifyvm $NAME \
    --memory 1024 \
    --nic1 nat \
    --vrde on --vrdeport 33890

sudo vboxmanage createhd \
    --filename "/srv/virtualbox/$NAME/$NAME.vdi" \
    --format VDI --size 20240 

sudo vboxmanage storagectl $NAME \
    --name "SATA" \
    --add sata

sudo vboxmanage storageattach $NAME \
    --storagectl SATA --port 0 --type hdd \
    --medium "/srv/virtualbox/$NAME/$NAME.vdi" \

sudo vboxmanage storageattach $NAME \
    --storagectl SATA --port 15 --type dvddrive \
    --medium /tmp/$ISO


##############\
sudo iptables -A INPUT -p tcp --dport 33890 -j ACCEPT

sudo vboxmanage startvm $NAME --type headless

