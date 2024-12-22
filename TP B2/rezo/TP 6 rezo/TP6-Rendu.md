🌞 Configurer STP sur les 3 switches

```
IOU3#sh sp
Interface           Role Sts Cost      Prio.Nbr Type
------------------- ---- --- --------- -------- --------------------------------
Et0/0               Altn BLK 100       128.1    P2p
```

🌞 Altérer le spanning-tree en désactivant un port
```
IOU1#conf t
IOU1(config)#int ethernet0/0
IOU1(config-if)#shutdown


IOU3#sh sp

Interface           Role Sts Cost      Prio.Nbr Type
------------------- ---- --- --------- -------- --------------------------------
Et0/0               Desg FWD 100       128.1    P2p

```
🌞 Altérer le spanning-tree en modifiant le coût d'un lien

```
spanning-tree vlan 1 cost 1000
```
# II. OSPF
🌞 Montez la topologie

[ Router 1](/TP%20B2/TP%206%20rezo/Router1.md)

[ Router 2](/TP%20B2/TP%206%20rezo/Router2.md)

[ Router 3](/TP%20B2/TP%206%20rezo/Router3.md)

[ Router 4](/TP%20B2/TP%206%20rezo/Router4.md)

[ Router 5](/TP%20B2/TP%206%20rezo/Router5.md)

🌞 Configurer OSPF sur tous les routeurs

[ Router 1 OSPF](/TP%20B2/TP%206%20rezo/Router1OSPF.md)

[ Router 2 OSPF](/TP%20B2/TP%206%20rezo/Router2OSPF.md)

[ Router 3 OSPF](/TP%20B2/TP%206%20rezo/Router3OSPF.md)

[ Router 4 OSPF](/TP%20B2/TP%206%20rezo/Router4OSPF.md)

[ Router 5 OSPF](/TP%20B2/TP%206%20rezo/Router5OSPF.md)
```
R5(config-router)#default-information originate always 
```

🌞 Test

```
PC2> ping 1.1.1.1

84 bytes from 1.1.1.1 icmp_seq=1 ttl=49 time=61.443 ms
84 bytes from 1.1.1.1 icmp_seq=2 ttl=49 time=76.553 ms

PC2> ping 10.6.3.11

84 bytes from 10.6.3.11 icmp_seq=1 ttl=62 time=51.155 ms
84 bytes from 10.6.3.11 icmp_seq=2 ttl=62 time=29.597 ms

PC1> ping 10.6.3.11

84 bytes from 10.6.3.11 icmp_seq=1 ttl=62 time=30.484 ms
84 bytes from 10.6.3.11 icmp_seq=2 ttl=62 time=23.646 ms

PC1> ping 10.6.52.1

84 bytes from 10.6.52.1 icmp_seq=1 ttl=252 time=35.573 ms
84 bytes from 10.6.52.1 icmp_seq=2 ttl=252 time=67.488 ms

R5#ping 10.6.13.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.6.13.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 20/44/76 ms

```


# III. DHCP relay
🌞 Configurer un serveur DHCP sur dhcp.tp6.b1

```
[noah@dhcp1 ~]$ sudo cat /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 10.6.3.0 netmask 255.255.255.0 {
    range 10.6.3.100 10.6.3.200;
    option broadcast-address 10.6.3.255;
    option routers 10.6.3.254;
    option domain-name-servers 1.1.1.1;
}

subnet 10.6.1.0 netmask 255.255.255.0 {
    range 10.6.1.100 10.6.1.200;
    option broadcast-address 10.6.1.255;
    option routers 10.6.1.254;
    option domain-name-servers 1.1.1.1;
}

[noah@dhcp1 ~]$ systemctl status dhcpd
● dhcpd.service - DHCPv4 Server Daemon
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; preset: disabled)
     Active: active (running) since Thu 2024-10-31 17:23:01 CET; 2min 40s ago
       Docs: man:dhcpd(8)
             man:dhcpd.conf(5)
   Main PID: 1314 (dhcpd)
     Status: "Dispatching packets..."
      Tasks: 1 (limit: 4666)
     Memory: 4.6M
        CPU: 7ms
     CGroup: /system.slice/dhcpd.service
             └─1314 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid
```

🌞 Configurer un DHCP relay sur la passerelle de John

```
Oct 31 17:48:02 dhcp1.clients.tp4 dhcpd[737]: DHCPDISCOVER from 00:50:79:66:68:04 (PC2) via enp0s3
Oct 31 17:48:02 dhcp1.clients.tp4 dhcpd[737]: DHCPOFFER on 10.6.1.100 to 00:50:79:66:68:04 (PC2) via enp0s3

Oct 31 17:47:57 dhcp1.clients.tp4 dhcpd[737]: DHCPDISCOVER from 00:50:79:66:68:06 (PC3) via 10.6.3.254
Oct 31 17:47:57 dhcp1.clients.tp4 dhcpd[737]: DHCPOFFER on 10.6.3.100 to 00:50:79:66:68:06 (PC3) via 10.6.3.254
```