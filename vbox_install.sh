#!/bin/bash

NAME=$1
PORT=${2:-33890}
#MEM=${2:-1024}
#HDD=${3:-50240}

# Add the ISOs names to be created.
# To add .ova/ovf use the vbox_install_ova.sh script.
# For vdi images use the vbox_install_vdi.sh script.
# Add the new ISO to the variable list below and comment out the others.

#ISO="Win10_21H1_English_x64.iso"
#ISO="ubuntu-22.04-desktop-amd64.iso"
#ISO="ubuntu-20.04.3-live-server-amd64.iso"
#ISO="ubuntu-22.04.iso"
#ISO="kali-linux-2022.2-installer-amd64.iso"
#ISO="ubuntu-20.04.4-desktop-amd64.iso"
#ISO="kali-linux-2022.2-installer-amd64.iso"
#ISO="kali-linux-2022.1-installer-amd64.iso"
#ISO="kali-linux-2021.4a-installer-amd64.iso"
#ISO="kali-linux-2020.4-installer-amd64.iso"
#ISO="kali-linux-2019.4-amd64.iso"
#ISO="kali-linux-2018.4-amd64.iso"
#ISO="CentOS-7-x86_64-Everything-1804.iso"
ISO="CentOS-7-x86_64-Everything-1708.iso"
#    CentOS-7-x86_64-Everything-1708.iso
#    --ostype Debian_64 \
#ISO="CentOS-7-x86_64-DVD-1708.iso"

sudo mkdir -p /srv/virtualbox\

sudo vboxmanage createvm \
    --ostype "RedHat_64" \
    --basefolder "/srv/virtualbox" \
    --register \
    --name "$NAME"

sudo vboxmanage modifyvm $NAME \
    --memory 4024 \
    --nic1 bridged --bridgeadapter1 `ifconfig | awk -F: '/^eno/ { print $1 }'` \
    --vrde on --vrdeport $PORT \
    --cpus 4
#    --nic1 nat \

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
#####sudo iptables -A INPUT -p tcp --dport 33890 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport $PORT -j ACCEPT

sudo vboxmanage startvm $NAME --type headless



#####this is for resizing
###sudo vboxmanage controlvm vmname setvideomodehint 1027 600 32
# --nic1 nat will just find whatever path to the internet.
# for the bridgeadapter1 the net connections may need to be modified to look for en0 or something different, my system uses eno
