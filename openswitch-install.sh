# Install virtualization

yum install -y @virtualization openvswitch ovsdbmonitor
yum update -y libtasn1
usermod -a -G kvm geoff

# Set up os media dir
#echo "/home/joe/Systems/os_media /opt/qemu-kvm/os_media" >> /etc/fstab
#chown -R root:qemu /opt/qemu-kvm/os_media

# Configure openvswitch

# this will get rid of virbr0 / NAT
virsh net-destroy default
virsh net-undefine default
systemctl stop NetworkManager
systemctl disable NetworkManager

# turn on openvswitch
systemctl enable openvswitch
systemctl start openvswitch
ovs-vsctl add-br ovsbr0

# configure the open vswitch bridge
echo "DEVICE=ovsbr0
DEVICETYPE=ovs
HOTPLUG=no
ONBOOT=yes
OVSBOOTPROTO=DHCP
OVSDHCPINTERFACES=p10p1
TYPE=OVSBridge" > /etc/sysconfig/network-scripts/ifcfg-ovsbr0

# Configure the vswitch port for the host to talk on (moved IP of p10p1 to this iface)
echo "DEVICE=mgmt0
BOOTPROTO=static
IPADDR=192.168.1.144
GATEWAY=192.168.1.1
NETMASK=255.255.255.0
ONBOOT=yes
DNS1=192.168.1.1
DEVICETYPE=ovs
TYPE=OVSIntPort
OVS_BRIDGE=ovsbr0" > /etc/sysconfig/network-scripts/ifcfg-mgmt0

# Configure the physical interface through which the ovs bridge will communicate

echo "DEVICE=ovsbr0
DEVICETYPE=ovs
HOTPLUG=no
ONBOOT=yes
OVSBOOTPROTO=DHCP
OVSDHCPINTERFACES=p10p1
TYPE=OVSBridge" > /etc/sysconfig/network-scripts/ifcfg-p10p1

# bounce the network service
# just covering all the bases here in case i need to re-run this later to fix mistakes or revert to known good config
systemctl enable network.service
systemctl restart network.service

