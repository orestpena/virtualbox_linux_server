#!/bin/bash
# this script is used to import ovf/ova operating systems.
# using vbox imports
NAME=$1
OVF="kali-linux-2022.2-virtualbox-amd64.ova"

VBoxManage import $OVF --vsys 0 --vmname $NAME --description $NAME --eula accept --basefolder /srv/virtualbox --settingsfile /srv/virtualbox/$NAME # --cpus 2 --memory 20240 --vmname $NAME --ostype Debian_64 --settingsfile /srv/virtualbox/Kali-Linux-2022.2-virtualbox-amd64.vbox --basefolder /srv/virtualbox
#VBoxManage import $OVF "--vsys 0 --description $NAME --eula accept --cpus 2 --memory 2024 --unit 14 --ignore --unit 15 --ignore --unit 17 --ignore --unit 18 --ignore --unit 19 --ignore --unit 20 --ignore --vmname $NAME"

# 
# https://forums.virtualbox.org/viewtopic.php?f=7&t=60681
#
#--ostype Debian_64
#--vmname $NAME
#--group 7
#--settingsfile /home/orestpena/srv/vbox/$NAME
#--basefolder /home/orestpena/srv/vbox
#--description kali
#--eula accept
#--cpus 2
#--memory 2024
#--unit 14 --ignore
#--unit 15 --ignore
#--unit 17 --ignore
#--unit 18 --ignore
#--unit 19 --ignore
#--unit 20 --ignore


# VBoxManage import kali-linux-2022.2-virtualbox-amd64.ova --vsys 0 --description kali --eula accept --vmname kali --group 7 --cpus 2 --memory 20240 --unit 14 --ignore --unit 15 --ignore --unit 17 --ignore --unit 18 --ignore --unit 19 --ignore --unit 20 --ignore --ostype Debian_64 --settingsfile /srv/virtualbox/Kali-Linux-2022.2-virtualbox-amd64/Kali-Linux-2022.2-virtualbox-amd64.vbox --basefolder /srv/virtualbox/
