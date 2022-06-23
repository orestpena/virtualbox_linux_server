#!/bin/bash\
# initialize the virtualbox setup. May need to update for newer versions.

sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -\
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" \\\
    | sudo tee /etc/apt/sources.list.d/virtualbox.list\
sudo apt update\
sudo apt-get install --yes virtualbox-6.1\
sudo systemctl status vboxdrv\

sudo usermod -aG vboxusers $USER\

VBOXVER=`vboxmanage -v | cut -dr -f1`\
wget -P /tmp \\\
    https://download.virtualbox.org/virtualbox/$VBOXVER/Oracle_VM_VirtualBox_Extension_Pack-$VBOXVER.vbox-extpack\
sudo vboxmanage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack-$VBOXVER.vbox-extpack\

