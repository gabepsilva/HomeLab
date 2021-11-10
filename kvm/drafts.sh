network:
  renderer: networkd
  ethernets:
    enp2s0:
      dhcp4: no
      dhcp6: no
  version: 2

  bridges:
    br0:
      interfaces: [enp2s0]
      addresses: [192.168.50.172/24]
      gateway4: 192.168.50.1
      mtu: 1500
      nameservers:
        addresses: [192.168.50.4, 192.168.50.1]
      parameters:
        stp: true
        forward-delay: 4