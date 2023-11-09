## I.
### 1/
ipconfig /all -> IP du serveur DHCP :  
Serveur DHCP . . . . . . . . . . . . . : 10.33.79.254  
Bail obtenu. . . . . . . . . . . . . . : vendredi 27 octobre 2023 13:23:38  
Bail expirant. . . . . . . . . . . . . : samedi 28 octobre 2023 09:27:52  

### 2/
Pour refaire le protocole DHCP , il faut se déconnecter du réseau en changeant notre adresse ip manuellement , puis quand on se reconnecte automatiquement (en utilisant le DHCP pour avoir une ip) , le protocole se fait tout seul.  
(voir DHCP-TP4)

### 3/
C'est la tram "Offer" qui propose des informations.

## II.
### 3/
#### 1/

Depuis DHCP :  
[noah@localhost network-scripts] ping amazon.com  
PING amazon.com (54.239.28.85) 56(84) bytes of data.  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=1 ttl=233 time=88.5 ms  

Depuis Node2 vers nom de domaine :  
ping amazon.com  
PING amazon.com (54.239.28.85) 56(84) bytes of data.  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=1 ttl=233 time=93.8 ms  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=2 ttl=233 time=92.9 ms  

TraceRoute depuis Node2 :  
traceroute onepiece-boutique.fr  
traceroute to onepiece-boutique.fr (194.233.66.98), 30 hops max, 60 byte packets  
 1  _gateway (10.4.1.254)  0.316 ms  0.277 ms  0.264 ms  
 2  10.0.3.2 (10.0.3.2)  0.565 ms  0.386 ms  0.421 ms  
 3  10.0.3.2 (10.0.3.2)  5.026 ms  8.228 ms  8.199 ms  

### 4/

Pour monter le Serveur DHCP nous avons du utilisé les commandes suivantes :  
-sudo dnf -y install dhcp-server  (on installe le DHCP)  
-sudo nano /etc/dhcp/dhcpd.conf (pour pouvoir configurer un fichier pour configurer le DHCP)  
-systemctl enable --now dhcpd (une fois parametrer on l'active)  
-firewall-cmd --add-service=dhcp  
-firewall-cmd --runtime-to-permanent  (on configure le firewall en pour que le DHCP marche)  
-sudo nano /etc/sysconfig/network-scripts/ifcfg-enp0s3  
(on active le DHCP de façon définitive dans le dossier ci-dessus en y entrant les lignes suivantes :  
DEVICE=enp0s8  

BOOTPROTO=dhcp  
ONBOOT=yes)  

-sudo nmcli con reload  
-sudo nmcli con up "System enp0s8"  
-sudo systemctl restart NetworkManager  
(ces 3 commandes servent a restart notre Network manager pour que le DHCP s'active (pour éviter d'avoir a redemarrer la machine))  

DHCP actif :

systemctl status dhcpd  
● dhcpd.service - DHCPv4 Server Daemon  
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service;   enabled; preset: disabled)  
    Active: active (running) since Thu 2023-11-02 15:03:06 CET; 6 days ago  

Resultat du cat : 
sudo cat /etc/dhcp/dhcpd.conf  
option domain-name     "srv.world";  
option domain-name-servers     dlp.srv.world;  
default-lease-time 600;  
max-lease-time 7200;  
authoritative;  
subnet 10.4.1.0 netmask 255.255.255.0 {  
range dynamic-bootp 10.4.1.137 10.4.1.237;  
option broadcast-address 10.4.1.255;  
option routers 10.4.1.254;  
}  

### 5/

l'ip a bien été changer dynamiquement comme visible ici :  
Nov 08 23:17:36 DHCPTP4 dhcpd[11461]: DHCPACK on 10.4.1.138 to 08:00:27:08:80:1d via enp0s3  
Nov 08 23:28:54 DHCPTP4 dhcpd[11461]: DHCPDISCOVER from 08:00:27:08:80:1d via enp0s3  
Nov 08 23:28:54 DHCPTP4 dhcpd[11461]: ICMP Echo reply while lease 10.4.1.138 valid.  
Nov 08 23:28:54 DHCPTP4 dhcpd[11461]: Abandoning IP address 10.4.1.138: pinged before offer  
Nov 08 23:28:56 DHCPTP4 dhcpd[11461]: DHCPDISCOVER from 08:00:27:08:80:1d via enp0s3  
Nov 08 23:28:57 DHCPTP4 dhcpd[11461]: DHCPOFFER on 10.4.1.139 to 08:00:27:08:80:1d via enp0s3  
Nov 08 23:28:57 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.139 (10.4.1.253) from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.139.  
Nov 08 23:29:00 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.139 (10.4.1.253) from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.139.  
Nov 08 23:29:05 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.139 (10.4.1.253) from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.139.  
Nov 08 23:29:13 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.139 (10.4.1.253) from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.139.  
Nov 08 23:29:29 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.139 (10.4.1.253) from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.139.  
Nov 08 23:29:39 DHCPTP4 dhcpd[11461]: DHCPREQUEST for 10.4.1.138 from 08:00:27:08:80:1d via enp0s3: unknown lease 10.4.1.138.  
Nov 08 23:29:41 DHCPTP4 dhcpd[11461]: DHCPDISCOVER from 08:00:27:08:80:1d via enp0s3  
Nov 08 23:29:41 DHCPTP4 dhcpd[11461]: DHCPOFFER on 10.4.1.139 to 08:00:27:08:80:1d via enp0s3  
(on peut voir que l'ip change car celle finissant par 138 n'était pas attribuable)  

Creation :  1699537322 (soit : Thursday, November 9, 2023 2:42:02 PM GMT+01:00)  
Expiration : 1699537921 (soit :Thursday, November 9, 2023 2:52:01 PM GMT+01:00)  
IP du DHCP :  dhcp_server_identifier = 10.4.1.253  

Ping node1 -> routeur :  
PING 10.4.1.254 (10.4.1.254) 56(84) bytes of data.  
64 bytes from 10.4.1.254: icmp_seq=1 ttl=64 time=0.694 ms  
64 bytes from 10.4.1.254: icmp_seq=2 ttl=64 time=0.362 ms  

Ping node1 -> node2 :  
PING 10.4.1.12 (10.4.1.12) 56(84) bytes of data.  
64 bytes from 10.4.1.12: icmp_seq=1 ttl=64 time=0.807 ms  
64 bytes from 10.4.1.12: icmp_seq=2 ttl=64 time=0.752 ms  

infos sur node1 depuis DHCP server :  
lease 10.4.1.139 {  
  starts 4 2023/11/09 13:35:41;  
  ends 4 2023/11/09 13:45:41;  
  tstp 4 2023/11/09 13:45:41;  
  cltt 4 2023/11/09 13:35:41;  
  binding state active;  
  next binding state free;  
  rewind binding state free;  
  hardware ethernet 08:00:27:08:80:1d;  
  uid "\001\010\000'\010\200\035";  
}  