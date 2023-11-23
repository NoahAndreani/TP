## I.
### 1/

Youtube :   
Ip : 162.159.133.234  
Port pour se co : 443  
Port local : 54299  

Xnxx :  
IP : 143.244.56.12  
Port pour se co : 443  
Port local : 54806  

Twitch :  
IP : 99.181.69.223  
Port pour se co : 443   
Port local : 54666  

Discord :  
IP : 66.22.197.93  
Port pour se co : 54780  
Port local :50021  

Daylimotion :  
IP : 23.72.250.24  
Port pour se co : 443  
Port local : 54883  

### 2/

Youtube :  
TCP    10.33.70.246:54967     162.159.133.234:443    ESTABLISHED  

Xnxx : 
 TCP    10.33.70.246:55121     143.244.56.6:443       ESTABLISHED  

Twitch :  
TCP    10.33.70.246:55176     52.223.193.144:443     ESTABLISHED  

Discord :  
TCP    10.33.70.246:55207     3.93.209.225:443       ESTABLISHED  

Daylimotion :  
 TCP    10.33.70.246:55257     188.65.126.39:443      ESTABLISHED

 ## II.
 ### 1/

connexion SSH depuis mon pc : TCP    127.0.0.1:62266        Noah:62267             ESTABLISHED
connexion SSH depuis ma vm : ESTAB        0             0                        10.5.1.11:ssh                    10.5.1.1:63961

### 2/
🌞 Prouvez que


node1.tp5.b1 a un accès internet

node1.tp5.b1 peut résoudre des noms de domaine publics (comme www.ynov.com) :  


[noah@node1 network-scripts]$ ping www.ynov.com
PING www.ynov.com (104.26.11.233) 56(84) bytes of data.
64 bytes from 104.26.11.233 (104.26.11.233): icmp_seq=1 ttl=55 time=21.8 ms
64 bytes from 104.26.11.233 (104.26.11.233): icmp_seq=2 ttl=55 time=20.1 ms
64 bytes from 104.26.11.233 (104.26.11.233): icmp_seq=3 ttl=55 time=20.0 ms
^C
--- www.ynov.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 20.025/20.658/21.827/0.827 ms
[noah@node1 network-scripts]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=115 time=14.6 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=115 time=13.8 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 13.780/14.211/14.643/0.431 ms
[noah@node1 network-scripts]$

### 3/
🌞 Installez le paquet nginx

Installed:
  nginx-1:1.20.1-14.el9_2.1.x86_64

🌞 Démarrer le serveur web !
  ● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; pres>
     Active: active (running) since Fri 2023-11-17 16:24:16 CET; 8s ago

🌞 Ouvrir le port firewall
[noah@web ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success

🌞 Visualiser le port en écoute
[noah@web ~]$ sudo ss -alnpt
State    Recv-Q   Send-Q      Local Address:Port       Peer Address:Port   Process
LISTEN   0        511               0.0.0.0:80              0.0.0.0:*       users:(("nginx",pid=1331,fd=6),("nginx",pid=1330,fd=6))
LISTEN   0        128               0.0.0.0:22              0.0.0.0:*       users:(("sshd",pid=687,fd=3))
LISTEN   0        511                  [::]:80                 [::]:*       users:(("nginx",pid=1331,fd=7),("nginx",pid=1330,fd=7))
LISTEN   0        128                  [::]:22                 [::]:*       users:(("sshd",pid=687,fd=4))