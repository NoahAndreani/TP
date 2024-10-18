# 1

🌞 Adressage

```
PC1> ip 10.1.10.1
Checking for duplicate address...
PC1 : 10.1.10.1 255.255.255.0

PC2> ip 10.1.10.2
Checking for duplicate address...
PC2 : 10.1.10.2 255.255.255.0

adm1> ip 10.1.20.1
Checking for duplicate address...
adm1 : 10.1.20.1 255.255.255.0

```
🌞 Configuration des VLANs

```
10   vlan10                           active    Et0/1, Et0/2
20   vlan20                           active    Et1/0
30   vlan30                           active    Et1/1
```


🌞 Config du routeur

```
R1#show ip interface brief
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES unset  up                    up  
FastEthernet0/0.10         10.1.10.254     YES manual up                    up  
FastEthernet0/0.20         10.1.20.254     YES manual up                    up  
FastEthernet0/0.30         10.1.30.254     YES manual up                    up  
```
🌞 Vérif
```
[noah@web1 ~]$ ping 10.1.30.254
PING 10.1.30.254 (10.1.30.254) 56(84) bytes of data.
64 bytes from 10.1.30.254: icmp_seq=1 ttl=255 time=10.7 ms
64 bytes from 10.1.30.254: icmp_seq=2 ttl=255 time=10.0 ms

PC1> ping 10.1.10.254

84 bytes from 10.1.10.254 icmp_seq=1 ttl=255 time=10.328 ms
84 bytes from 10.1.10.254 icmp_seq=2 ttl=255 time=8.126 ms

PC2> ping 10.1.10.254

84 bytes from 10.1.10.254 icmp_seq=1 ttl=255 time=7.935 ms
84 bytes from 10.1.10.254 icmp_seq=2 ttl=255 time=2.807 ms

adm1> ping 10.1.20.254

84 bytes from 10.1.20.254 icmp_seq=1 ttl=255 time=10.364 ms
84 bytes from 10.1.20.254 icmp_seq=2 ttl=255 time=11.590 ms
```

Testez des ping entre les réseaux
```
PC1> ping 10.1.20.1

84 bytes from 10.1.20.1 icmp_seq=1 ttl=63 time=20.174 ms
84 bytes from 10.1.20.1 icmp_seq=2 ttl=63 time=14.714 ms

[noah@web1 ~]$ ping 10.1.10.1
PING 10.1.10.1 (10.1.10.1) 56(84) bytes of data.
64 bytes from 10.1.10.1: icmp_seq=1 ttl=63 time=17.5 ms
64 bytes from 10.1.10.1: icmp_seq=2 ttl=63 time=16.9 ms

PC2> ping 10.1.30.1

84 bytes from 10.1.30.1 icmp_seq=1 ttl=63 time=21.080 ms
84 bytes from 10.1.30.1 icmp_seq=2 ttl=63 time=17.174 ms
84 bytes from 10.1.30.1 icmp_seq=3 ttl=63 time=13.771 ms
```

# 2
🌞 Ajoutez le noeud Cloud à la topo

```
R1#ping 1.1.1.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 1.1.1.1, timeout is 2 seconds:
.!!!!
Success rate is 80 percent (4/5), round-trip min/avg/max = 48/58/64 ms
```

🌞 Test
```
DNS         : 1.1.1.1

PC1> ping nra.org
nra.org resolved to 172.64.151.61

84 bytes from 172.64.151.61 icmp_seq=1 ttl=53 time=31.305 ms
84 bytes from 172.64.151.61 icmp_seq=2 ttl=53 time=32.488 ms
```

# 3
🌞  Vous devez me rendre le show running-config de tous les équipements

SwitchRouter.md

🌞  Vérification

```
PC5> ip dhcp
DDORA IP 10.1.10.32/24 GW 10.1.10.254

PC5> ping 1.1.1.1

84 bytes from 1.1.1.1 icmp_seq=1 ttl=53 time=32.270 ms
84 bytes from 1.1.1.1 icmp_seq=2 ttl=53 time=37.801 ms

PC5> ping google.com
google.com resolved to 142.251.37.174

84 bytes from 142.251.37.174 icmp_seq=1 ttl=111 time=29.707 ms
84 bytes from 142.251.37.174 icmp_seq=2 ttl=111 time=30.353 ms

```