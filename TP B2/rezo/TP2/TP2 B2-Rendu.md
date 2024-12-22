# 1.
☀️ Sur node1.lan1.tp2

```
[noah@node1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:42:be:e3 brd ff:ff:ff:ff:ff:ff
    inet 10.1.1.11/24 brd 10.1.1.255 scope global noprefixroute enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe42:bee3/64 scope link
       valid_lft forever preferred_lft forever
```
```
[noah@node1 ~]$ ip route show
10.1.1.0/24 dev enp0s3 proto kernel scope link src 10.1.1.11 metric 100
10.1.2.11 via 10.1.1.254 dev enp0s3 proto static metric 100
10.1.2.12 via 10.1.1.254 dev enp0s3 proto static metric 100

[noah@node1 ~]$ ping 10.1.2.12
PING 10.1.2.12 (10.1.2.12) 56(84) bytes of data.
64 bytes from 10.1.2.12: icmp_seq=1 ttl=63 time=1.60 ms
64 bytes from 10.1.2.12: icmp_seq=2 ttl=63 time=3.82 ms
64 bytes from 10.1.2.12: icmp_seq=3 ttl=63 time=3.85 ms
^C
--- 10.1.2.12 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2006ms
rtt min/avg/max/mdev = 1.599/3.091/3.853/1.055 ms
```

```
[noah@node1 ~]$ traceroute 10.1.2.12
traceroute to 10.1.2.12 (10.1.2.12), 30 hops max, 60 byte packets
 1  10.1.1.254 (10.1.1.254)  4.951 ms  4.719 ms  3.781 ms
 2  10.1.2.12 (10.1.2.12)  3.362 ms !X  3.166 ms !X  2.896 ms !X
```
# 2.

☀️ Sur router.tp2

```
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=113 time=21.7 ms
^C
--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 21.737/21.737/21.737/0.000 ms

[noah@router ~]$ ping jouetclub.com
PING jouetclub.com (217.70.184.55) 56(84) bytes of data.
64 bytes from webredir.gandi.net (217.70.184.55): icmp_seq=1 ttl=54 time=12.6 ms
64 bytes from webredir.gandi.net (217.70.184.55): icmp_seq=2 ttl=54 time=12.7 ms
64 bytes from webredir.gandi.net (217.70.184.55): icmp_seq=3 ttl=54 time=13.0 ms
^C
--- jouetclub.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 12.564/12.760/12.996/0.178 ms
```

☀️ Accès internet LAN1 et LAN2

```
[noah@node2 ~]$ sudo cat /etc/sysconfig/network-scripts/route-enp0s3
default via 10.1.1.254 dev enp0s3

[noah@node2 ~]$ sudo cat /etc/resolv.conf
# Generated by NetworkManager
nameserver 8.8.8.8
nameserver 1.1.1.1

[noah@node2 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=112 time=22.9 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=112 time=24.2 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1003ms
rtt min/avg/max/mdev = 22.912/23.532/24.153/0.620 ms

[noah@node2 ~]$ ping www.haribo.com
PING a1914.dscr.akamai.net (23.72.250.137) 56(84) bytes of data.
64 bytes from a23-72-250-137.deploy.static.akamaitechnologies.com (23.72.250.137): icmp_seq=1 ttl=53 time=15.4 ms
64 bytes from a23-72-250-137.deploy.static.akamaitechnologies.com (23.72.250.137): icmp_seq=2 ttl=53 time=15.9 ms
64 bytes from a23-72-250-137.deploy.static.akamaitechnologies.com (23.72.250.137): icmp_seq=3 ttl=53 time=14.8 ms
^C
--- a1914.dscr.akamai.net ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2006ms
rtt min/avg/max/mdev = 14.822/15.373/15.894/0.438 ms
```

# 3.
☀️ Sur web.lan2.tp2
```
[noah@web /]$ sudo ss -tuln | grep :80
tcp   LISTEN 0      511          0.0.0.0:80        0.0.0.0:*
tcp   LISTEN 0      511             [::]:80           [::]:*
[noah@web /]$ sudo ss -tulnp | grep :80
tcp   LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=1471,fd=6),("nginx",pid=1470,fd=6))
tcp   LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=1471,fd=7),("nginx",pid=1470,fd=7))

[noah@web /]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3
  sources:
  services: cockpit dhcpv6-client ssh
  ports: 80/tcp
```

☀️ Sur node1.lan1.tp2

```
[noah@node1 ~]$ sudo cat /etc/hosts
10.1.2.12 site_nul.tp2


[noah@node1 ~]$ curl http://site_nul.tp2
tessstttt
```

