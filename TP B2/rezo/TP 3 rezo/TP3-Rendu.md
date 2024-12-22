🌞 Commençons simple

```
PC1> ping 10.3.1.2

84 bytes from 10.3.1.2 icmp_seq=1 ttl=64 time=0.572 ms
84 bytes from 10.3.1.2 icmp_seq=2 ttl=64 time=0.973 ms
^C
PC1> show ip

NAME        : PC1[1]
IP/MASK     : 10.3.1.1/24

IOU6#show mac address-table
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
   1    0050.7966.6800    DYNAMIC     Et0/0
   1    0050.7966.6801    DYNAMIC     Et0/1
Total Mac Addresses for this criterion: 2
```
🌞 Adressage

```
PC1> sh ip

NAME        : PC1[1]
IP/MASK     : 10.3.1.1/24

PC2> sh ip

NAME        : PC2[1]
IP/MASK     : 10.3.1.2/24

PC3> sh ip

NAME        : PC3[1]
IP/MASK     : 10.3.1.3/24
```
🌞 Vérif (jai fais la vlan trop vite mybad)

```
PC2> ping 10.3.1.1

84 bytes from 10.3.1.1 icmp_seq=1 ttl=64 time=5.838 ms
84 bytes from 10.3.1.1 icmp_seq=2 ttl=64 time=2.644 ms

PC3> ping 10.3.1.1

host (10.3.1.1) not reachable

PC3> ping 10.3.1.2

host (10.3.1.2) not reachable
```

# III

🌞 VM dhcp.tp3.b2
```
PC4> dhcp
DDORA
PC5> dhcp
DDD
Can't find dhcp server

[noah@node1 ~]$ sudo cat /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 10.3.1.0 netmask 255.255.255.0 {
    range dynamic-bootp 10.3.1.100 10.3.1.200;
    option broadcast-address 10.3.1.255;
}
```