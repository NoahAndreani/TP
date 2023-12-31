## I.
### 1/
ipconfig /all -> IP du serveur DHCP :  
```
Serveur DHCP . . . . . . . . . . . . . : 10.33.79.254  
Bail obtenu. . . . . . . . . . . . . . : vendredi 27 octobre 2023 13:23:38  
Bail expirant. . . . . . . . . . . . . : samedi 28 octobre 2023 09:27:52  
```

### 2/
Pour refaire le protocole DHCP , il faut se déconnecter du réseau en changeant notre adresse ip manuellement , puis quand on se reconnecte automatiquement (en utilisant le DHCP pour avoir une ip) , le protocole se fait tout seul.  
(voir DHCP-TP4)

### 3/
C'est la tram "Offer" qui propose des informations.

## II.
### 3/
#### 1/

Depuis DHCP : 
``` 
[noah@localhost network-scripts] ping amazon.com  
PING amazon.com (54.239.28.85) 56(84) bytes of data.  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=1 ttl=233 time=88.5 ms  
```

Depuis Node2 vers nom de domaine : 
``` 
ping amazon.com  
PING amazon.com (54.239.28.85) 56(84) bytes of data.  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=1 ttl=233 time=93.8 ms  
64 bytes from 54.239.28.85 (54.239.28.85): icmp_seq=2 ttl=233 time=92.9 ms 
``` 

TraceRoute depuis Node2 :  
```
traceroute onepiece-boutique.fr  
traceroute to onepiece-boutique.fr (194.233.66.98), 30 hops max, 60 byte packets  
 1  _gateway (10.4.1.254)  0.316 ms  0.277 ms  0.264 ms  
 2  10.0.3.2 (10.0.3.2)  0.565 ms  0.386 ms  0.421 ms  
 3  10.0.3.2 (10.0.3.2)  5.026 ms  8.228 ms  8.199 ms 
 ``` 

### 4/

Pour monter le Serveur DHCP nous avons du utilisé les commandes suivantes : 
``` 
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
```

DHCP actif :
```
systemctl status dhcpd  
● dhcpd.service - DHCPv4 Server Daemon  
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service;   enabled; preset: disabled)  
    Active: active (running) since Thu 2023-11-02 15:03:06 CET; 6 days ago  
```    

Resultat du cat : 
```
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
```

### 5/
#### 1/
nmcli con show enp0s3 donne :
```  
DHCP4.OPTION[1]:                        broadcast_address = 10.4.1.255  
DHCP4.OPTION[2]:                        dhcp_client_identifier = 01:08:00:27:08:80:1d  
DHCP4.OPTION[3]:                        dhcp_lease_time = 21600  
DHCP4.OPTION[4]:                        dhcp_server_identifier = 10.4.1.253  
DHCP4.OPTION[5]:                        domain_name = srv.world  
DHCP4.OPTION[6]:                        domain_name_servers = 8.8.8.8  
DHCP4.OPTION[7]:                        expiry = 1699640882  
DHCP4.OPTION[8]:                        ip_address = 10.4.1.139  
DHCP4.OPTION[9]:                        requested_broadcast_address = 1  
DHCP4.OPTION[10]:                       requested_domain_name = 1  
DHCP4.OPTION[11]:                       requested_domain_name_servers = 1  
DHCP4.OPTION[12]:                       requested_domain_search = 1  
DHCP4.OPTION[13]:                       requested_host_name = 1  
DHCP4.OPTION[14]:                       requested_interface_mtu = 1  
DHCP4.OPTION[15]:                       requested_ms_classless_static_routes = 1  
DHCP4.OPTION[16]:                       requested_nis_domain = 1  
DHCP4.OPTION[17]:                       requested_nis_servers = 1  
DHCP4.OPTION[18]:                       requested_ntp_servers = 1  
DHCP4.OPTION[19]:                       requested_rfc3442_classless_static_routes = 1  
DHCP4.OPTION[20]:                       requested_root_path = 1  
DHCP4.OPTION[21]:                       requested_routers = 1  
DHCP4.OPTION[22]:                       requested_static_routes = 1  
DHCP4.OPTION[23]:                       requested_subnet_mask = 1  
DHCP4.OPTION[24]:                       requested_time_offset = 1  
DHCP4.OPTION[25]:                       requested_wpad = 1  
DHCP4.OPTION[26]:                       routers = 10.4.1.254  
DHCP4.OPTION[27]:                       subnet_mask = 255.255.255.0  
```

l'expiration est donc le  Friday, November 10, 2023 7:28:02 PM GMT+01:00

Ping node1 -> routeur : 
``` 
PING 10.4.1.254 (10.4.1.254) 56(84) bytes of data.  
64 bytes from 10.4.1.254: icmp_seq=1 ttl=64 time=0.694 ms  
64 bytes from 10.4.1.254: icmp_seq=2 ttl=64 time=0.362 ms  
```

Ping node1 -> node2 :  
```
PING 10.4.1.12 (10.4.1.12) 56(84) bytes of data.  
64 bytes from 10.4.1.12: icmp_seq=1 ttl=64 time=0.807 ms  
64 bytes from 10.4.1.12: icmp_seq=2 ttl=64 time=0.752 ms  
```

#### 2/

infos sur node1 depuis DHCP server :  
```
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
```

### 6/
#### 1/

voici donc la configuration du dhcp :  

```
[noah@DHCPTP4 ~]$ sudo cat /etc/dhcp/dhcpd.conf  
option domain-name     "srv.world";  
option domain-name-servers 8.8.8.8;  
default-lease-time 21600;  
max-lease-time 21600;  
authoritative;  
subnet 10.4.1.0 netmask 255.255.255.0 {  
range dynamic-bootp 10.4.1.137 10.4.1.237;  
option broadcast-address 10.4.1.255;  
option routers 10.4.1.254;  
}  
```
#### 2/

voici donc le DNS ajouté à node1 de base :
```  
sudo cat /etc/resolv.conf  
Generated by NetworkManager  
search srv.world  
nameserver 8.8.8.8  
```
La route a également été ajoutée :   
```
ip r s  
default via 10.4.1.254 dev enp0s3 proto dhcp src 10.4.1.139 metric 100  
```

et sa durée est bien de 6 heures : 
```
lease 10.4.1.139 {  
  starts 4 2023/11/09 23:59:14;  
  ends 5 2023/11/10 05:59:14;  
  tstp 5 2023/11/10 05:59:14;  
  cltt 4 2023/11/09 23:59:14;  
  binding state free;  >4>3
  hardware ethernet 08:00:27:08:80:1d;  
  uid "\001\010\000'\010\200\035";  
}  
```
Il possède un accès a internet :  
```
PING pornhub.com (66.254.114.41) 56(84) bytes of data.  
64 bytes from reflectededge.reflected.net (66.254.114.41): icmp_seq=1 ttl=54 time=18.6 ms  
64 bytes from reflectededge.reflected.net (66.254.114.41): icmp_seq=2 ttl=54 time=21.3 ms  
64 bytes from reflectededge.reflected.net (66.254.114.41): icmp_seq=3 ttl=54 time=20.6 ms  
```
#### 3/

voir fichier joint (tp4_dhcp_server.pcap)