# TP

### 1/ 
la commande ipconfig /all affiche :  
    dans l'interface wifi : Carte réseau sans fil Wi-Fi  
                            48-68-4A-B3-70-0E  
                            192.168.1.58  
    dans l'interface ethernet : "Carte Ethernet Ethernet"  
                                08-8F-C3-4F-D8-97  
                                ne possède pas d'adresse ip  

### 2/
le ipconfig /all affiche également ma passerelle , que se soit l'ip v4 ou même l'ip v6 qui sont :   -fe80::6eba:b8ff:fe9b:140%4 (v6)  
-192.168.1.1 (v4)  

### 3/
avec le "arp -a" nous avons une liste d'adresse ip avec leurs adresses mac correspondantes (et leurs type , dynamique ou statique ) , ainsi notre passerelle reseau (192.168.1.1) possède l'adresse mac :    6c-ba-b8-9b-01-40  

### 4/
grace au panneau de configuration nous trouvons que :  
l'adresse IP = 192.168.1.58  
l'adresse MAC = 48-68-4A-B3-70-0E  
la gateway = 192.168.1.1  

### 5/
Ma nouvelle adresse ip est désormais : 192.168.1.124 (panneau de config ->reseau et internet -> centre et partage -> ma wifi -> propriété -> protocole ip V4 -> adresse IP suivante)  
### 6/
si nous utilisons une adresse ip deja utilisée nous n'aurons plus accès a internet étant donné que ce sera l'autre utilisateur (qui avait cette ip avant nous) qui recevra les packets liés a la connexion internet  

## II 
### 1/
ip changé de 192.168.1.58 a 10.0.2.124  
verifié donc un ipconfig /all  

### 2/

ping 10.10.10.24  
Envoi d’une requête 'Ping'  10.0.2.124 avec 32 octets de données :  
Réponse de 10.0.2.124 : octets=32 temps<1ms TTL=128  
Réponse de 10.0.2.124 : octets=32 temps<1ms TTL=128  
Réponse de 10.0.2.124 : octets=32 temps<1ms TTL=128  
Réponse de 10.0.2.124 : octets=32 temps<1ms TTL=128  

### 3/
l'adresse MAC du correspondant est donc 6c-ba-b8-9b-01-40 grâce a un arp -a  

### 4/ 
connexion entre deux machines par carte réseau wifi :  
PS C:\netcat-win32-1.11\netcat-1.11> .\nc.exe 10.33.48.37 8833  

### 5/
Envoi d’une requête 'Ping'  1.1.1.1 avec 32 octets de données :  
Réponse de 1.1.1.1 : octets=32 temps=4 ms TTL=64  
Réponse de 1.1.1.1 : octets=32 temps=3 ms TTL=64  
Réponse de 1.1.1.1 : octets=32 temps=4 ms TTL=64  
Réponse de 1.1.1.1 : octets=32 temps=3 ms TTL=64  

### III 1/
ipconfig /all  
ip wifi d'ynov : 10.33.70.246  
expiration : samedi 21 octobre 2023 09:00:41  

### 2/
8.8.8.8 est l'ip de google  

### 3/
adresses d'ynov :  2606:4700:20::ac43:4ae2  
          2606:4700:20::681a:ae9  
          2606:4700:20::681a:be9  
          104.26.11.233  
          172.67.74.226  
          104.26.10.233  
          
### 4/
142.250.179.110 est l'ip a qui nous effectuons les requetes (pour le nslookup de google.com)  
le reverse lookup prend une ip en compte et nous renvoie le site associé , litteralement l'inverse du lookup qui renvoie l'ip a partir du nom de domaine  
