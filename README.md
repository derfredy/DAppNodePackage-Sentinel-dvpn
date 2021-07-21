
# Sentinel DVPN

![image](https://user-images.githubusercontent.com/23276270/126508276-6d425923-5a06-435e-addb-8e5d16a550d6.png)

This is a DAppNode Package that deploys a Sentinel DVPN exit node. It will allow you to share your bandwith and earn [DVPN](https://www.coingecko.com/es/monedas/sentinel) tokens.

Official project repositories are located here:
[Sentinel Github](https://github.com/sentinel-official)

## Warning

This is a special DAppNode Package. It needs some apt packages to be installed on the host machine before you can use this software.
Modifying your host is not recommended if you have not basic "command line skills". Please, consider the security risks that this implies before proceeding.

DAppNode host server is currently a Debian Buster based Operating System. We will need to install "wireguard" in order to use this Sentinel DVPN package.

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
```
Last command should show this output:
```bash
wireguard             225280  0
ip6_udp_tunnel         16384  1 wireguard
udp_tunnel             16384  1 wireguard
```

Once the wireguard package and modules are installed you can proceed with the instalation of Sentine DVPN as usually.

## Ports

If you are behind a restrictive firewall, please forward the following ports to your DAppNode LAN IP.

Port | Protocol
--- | ---
8585 | tcp
19192 | udp

## Install

Connect to your DAppNode and then you can use this direct link to install it:                                                                                                

[Install Sentinel DVPN node Package](http://my.dappnode/#/installer/%2Fipfs%2FQmSsLaT3d5HjpbtKJ58grmM7DsWpPf2JRw13P2Xx1k9P2W)

Or paste this IPFS hash into your DAppNode search bar:

/ipfs/QmSsLaT3d5HjpbtKJ58grmM7DsWpPf2JRw13P2Xx1k9P2W
