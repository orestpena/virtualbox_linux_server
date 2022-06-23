# virtualbox_linux_server

This repo sets up a headless virtualbox system on a server

vbox_intial.sh - Will pull vbox 6.1, if you would like a newer version it needs to be updated.

vbox_install.sh = Will create the vbox, but the ISO must be downloaded first and the name must be added to the ISO script.
    * Some ISOs require more memory than others, so you may need to up it.

vbox_vm_states.sh - can be used after the VM has been created. It can handle all of the power feature options.

To connect to your VM use a remote desktop viewer to the server.
