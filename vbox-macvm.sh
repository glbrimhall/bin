#!/bin/sh
VM=macElCapitan-10.11
vboxmanage modifyvm "$VM" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
vboxmanage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
vboxmanage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
vboxmanage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
vboxmanage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
vboxmanage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

