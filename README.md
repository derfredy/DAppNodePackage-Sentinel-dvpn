
# Sentinel DVPN

## Warning

This is a special DAppNode Package. It needs some apt packages to be installed in the host before you can use this software.
Modifying your host is not recommended if you have not "command line skills". Please, consider the security risks that this implies before proceeding.

DAppNode host server is currently a Debian buster based Operating System. We will need to install "wireguard" in the host OS in order to use this Sentinel DVPN package.

This is the command sequency to install wireguard in your DAppNode host machine:


```bash
sudo -s
sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"
apt update
apt install linux-image-amd64 linux-headers-amd64
reboot
apt install wireguard
modprobe wireguard
lsmod | grep wireguard

wireguard             225280  0
ip6_udp_tunnel         16384  1 wireguard
udp_tunnel             16384  1 wireguard
```

Once the wireguard package and modules are installed you can proceed with the instalation of Sentine DVPN as usually.

If you are behind a restrictive firewall, please forward tcp/8585 and udp/19192 ports to your DAppNode LAN IP.

