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
