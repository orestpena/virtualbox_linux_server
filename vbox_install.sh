#!/bin/bash

NAME=$1
#MEM=$2 #:-1024}
#HDD=$3 #:-50240}

# Add the ISOs names to be created.
# To add .ova/ovf use the vbox_install_ova.sh script.
# For vdi images use the vbox_install_vdi.sh script.
# Add the new ISO to the variable list below and comment out the others.

#ISO="Win10_21H1_English_x64.iso"
#ISO="ubuntu-20.04.3-desktop-amd64.iso"
#ISO="ubuntu-20.04.3-live-server-amd64.iso"
#ISO="ubuntu-22.04.iso"
ISO="kali-linux-2022.2-installer-amd64.iso"

sudo mkdir -p /srv/virtualbox\

sudo vboxmanage createvm \
    --ostype Debian_64 \
    --basefolder "/srv/virtualbox" \
    --register \
    --name "$NAME"

sudo vboxmanage modifyvm $NAME \
    --memory 4024 \
    --nic1 nat \
    --vrde on --vrdeport 33890 \
    --cpus 4

sudo vboxmanage createhd \
    --filename "/srv/virtualbox/$NAME/$NAME.vdi" \
    --format VDI --size 40240 

sudo vboxmanage storagectl $NAME \
    --name "SATA" \
    --add sata

sudo vboxmanage storageattach $NAME \
    --storagectl SATA --port 0 --type hdd \
    --medium "/srv/virtualbox/$NAME/$NAME.vdi" \

sudo vboxmanage storageattach $NAME \
    --storagectl SATA --port 15 --type dvddrive \
    --medium ~/Downloads/$ISO


##############\
sudo iptables -A INPUT -p tcp --dport 33890 -j ACCEPT

sudo vboxmanage startvm $NAME --type headless

