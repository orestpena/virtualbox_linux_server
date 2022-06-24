#!/bin/bash
# This script is for VDI images. Just add the vdi images path and when running the script provide a vmname

NAME=$1
#MEM=$2 #:-1024}
#HDD=$3 #:-50240}
# Add the ISOs names to be created.
# To add .ova use the vbox_install_ova script.
#VDI="Kali2022.1.vdi"
#VDI="Kali2022.1.vdi"
#VDI="OpenSuse15.3.vdi"
#VDI="CentOS7-1804.vdi"

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
    --medium $VDI

##############\
sudo iptables -A INPUT -p tcp --dport 33890 -j ACCEPT

sudo vboxmanage startvm $NAME --type headless

