#!/bin/bash
# this script controls vm states

ls /srv/virtualbox/
echo -n "Enter the name of your VM to change state: " 
read VMNAME

echo "1. Pause - this puts the machine on hold, w/o permanently changing its state."
echo "2. Resume - it undoes a pause"
echo "3. Reset - like pressing the reset button on a real computer"
echo "4. Poweroff - like pulling the power cable on a real computer, data could be lost"
echo "5. Savestate - saves the current state of the VM to disk and then stops the VM."
echo "6. ACPIPowerButton - performs a computer shutdown, like power button pressed on a real computer"
echo "7. PowerOn - PowerOn the VM"
echo "8. EXIT"
echo "100. Unregister and delete VM"
echo ""
echo -n "Enter the number of your selection: "
read NUMBER

#echo "The number selected is: $NUMBER"
echo "The VM name: $VMNAME and the number selected: $NUMBER"

case $NUMBER in
    1)
        sudo vboxmanage controlvm $VMNAME pause
        ;;

    2)
        sudo vboxmanage controlvm $VMNAME resume
        ;;
     
    3)
        sudo vboxmanage controlvm $VMNAME reset
        ;;

    4)
        sudo vboxmanage controlvm $VMNAME poweroff
        ;;
    5)
        sudo vboxmanage controlvm $VMNAME savestate
        ;;
    6)
        sudo vboxmanage controlvm $VMNAME acpipowerbutton
        ;;
    7)
        sudo vboxmanage startvm $VMNAME --type headless
        ;;
    100)
        sudo vboxmanage unregistervm $VMNAME --delete
        ;;
    *)
        echo "EXIT"
        ;;
esac
