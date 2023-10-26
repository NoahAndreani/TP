64 bytes from 10.3.1.12: icmp_seq=2 ttl=64 time=1.24 ms  
64 bytes from 10.3.1.11: icmp_seq=2 ttl=64 time=1.29 ms  

la commande ip n s pour voir la MAC (et d'autres infos) depuis john après avoir ping marcel qui donne :
-10.3.1.12 dev enp0s3 lladdr 08:00:27:8c:6b:a7 REACHABLE 

Depuis Marcel avec ip a : 08:00:27:8c:6b:a7

(depuis john)route temporaire :  
sudo ip route add 10.3.2.0/24 dev enp0s3 via 10.3.1.254  
route definitive (dans un fichier route-enp0s3):  
 10.3.2.0/24 via 10.3.1.254 dev enp0s3 

Le routeur a maintenant accès aux deux machines (john et marcel) , john a accès au "routeur" et marcel également
| ordre | type trame  | IP source | MAC source                | IP destination | MAC destination         |  
| ----- | ----------- | --------- | ------------------------- | -------------- |-------------------------|  
| 1     | Requête ARP | x         | `marcel` `AA:BB:CC:DD:EE` | x              |Broadcast`FF:FF:FF:FF:FF`|  
| 2     | Réponse ARP | x         | ?                         | x              |`marcel` `AA:BB:CC:DD:EE`|  
| ...   | ...         | ...       | ...                       |                |                         |  
| ?     |Ping         | ?         | ?                         | ?              | ?                       |  
| ?     |Pong         | ?         | ?                         | ?              | ?                       |  

 