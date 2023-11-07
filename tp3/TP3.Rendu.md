## I.
### 1/
pour Marcel :  
route temporaire :  
sudo ip route add 10.3.1.0/24 via 10.3.2.254 dev enp0s3  

route definitive (dans un fichier route-enp0s3):  
 10.3.1.0/24 via 10.3.2.254 dev enp0s3  

pour John :  
sudo ip route add 10.3.2.0/24 dev enp0s3 via 10.3.1.254  

route definitive (dans un fichier route-enp0s3):  
10.3.2.0/24 via 10.3.1.254 dev enp0s3  

résultat :  
64 bytes from 10.3.1.12: icmp_seq=2 ttl=64 time=1.24 ms  
64 bytes from 10.3.1.11: icmp_seq=2 ttl=64 time=1.29 ms  

## II.
### 1/
| ordre | type trame  | IP source | MAC source                | IP destination | MAC destination           |  
| ----- | ----------- | --------- | ------------------------- | -------------- | ------------------------- |  
| 1     | Requête ARP | x         | marcel `08:00:27:8c:6b:a7`| x              |Broadcast `FF:FF:FF:FF:FF` |  
| 2     | Réponse ARP | x         | routeur`08:00:27:26:a5:a7`| x              | marcel `08:00:27:8c:6b:a7`|  
| ...   | ...         | ...       | ...                       |                |                           |  
| 3     |Ping         | 10.3.1.11 | john   `08:00:27:f9:6e:c7`|  10.3.2.12     |routeur `08:00:27:fb:9b:45`|  
| 4     |Pong         | 10.3.2.12 | marcel `08:00:27:8c:6b:a7`|  10.3.1.11     |routeur `08:00:27:fb:9b:45`|  

## III.
### 1/ 
preuve que le routeur est bien connecter :  
ping 8.8.8.8  
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.  
64 bytes from 8.8.8.8: icmp_seq=1 ttl=116 time=19.3 ms  
64 bytes from 8.8.8.8: icmp_seq=2 ttl=116 time=18.4 ms  
### 2/
de John :  
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.  
64 bytes from 8.8.8.8: icmp_seq=1 ttl=115 time=21.9 ms  
64 bytes from 8.8.8.8: icmp_seq=2 ttl=115 time=21.9 ms  

De Marcel :  
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.  
64 bytes from 8.8.8.8: icmp_seq=1 ttl=115 time=23.0 ms  
64 bytes from 8.8.8.8: icmp_seq=2 ttl=115 time=23.7 ms  

De John :  
PING ruenu.com (104.21.234.84) 56(84) bytes of data.  
64 bytes from 104.21.234.84 (104.21.234.84): icmp_seq=1 ttl=54 time=34.2 ms  
64 bytes from 104.21.234.84 (104.21.234.84): icmp_seq=2 ttl=54 time=22.4 ms  

De Marcel :  
PING displate.com (104.18.23.110) 56(84) bytes of data.  
64 bytes from 104.18.23.110 (104.18.23.110): icmp_seq=1 ttl=54 time=20.6 ms  
64 bytes from 104.18.23.110 (104.18.23.110): icmp_seq=2 ttl=54 time=29.4 ms  
(on ajoute DNS1=1.1.1.1 dans /etc/sysconfig/network-scripts/ifcfg-enp0s3 chez les deux)  

| ordre | type trame | IP source            | MAC source                | IP destination | MAC destination |     |
| ----- | ---------- | -------------------- | ------------------------- | -------------- | --------------- | --- |
| 1     | ping       | `marcel 10.3.2.12` | `marcel 08:00:27:8c:6b:a7`| `10.3.1.11`   | `08:00:27:fb:9b:45` |     |
| 2     | pong       |`John 10.3.1.11` | `John 08:00:27:f9:6e:c7`        | `10.3.2.12`   | `08:00:27:26:a5:a7`   | ... |
