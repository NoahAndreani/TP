# TP2-Reseau
## I
### 1/

ips choisis : 10.10.10.33/30 et 10.10.10.34/30  
Reseau : 10.10.10.32  
broadcast : 10.10.10.35  
commandes utilisées : New-NetIPAddress –InterfaceIndex 22 –IPAddress 10.10.10.33 –PrefixLength 30
et New-NetIPAddress –InterfaceIndex 11 –IPAddress 10.10.10.34 –PrefixLength 30  

### 2/

PS C:\WINDOWS\system32> ping 10.10.10.34  

Envoi d’une requête 'Ping'  10.10.10.34 avec 32 octets de données :  
Réponse de 10.10.10.34 : octets=32 temps=6 ms TTL=128  
Réponse de 10.10.10.34 : octets=32 temps=1 ms TTL=128  
Réponse de 10.10.10.34 : octets=32 temps=1 ms TTL=128  
Réponse de 10.10.10.34 : octets=32 temps=1 ms TTL=128  

Statistiques Ping pour 10.10.10.34:  
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),  
Durée approximative des boucles en millisecondes :  
    Minimum = 1ms, Maximum = 6ms, Moyenne = 2ms  
    
### 3/

voir le fichier pingpong  

## II
### 1/ 
la commande est arp -a  
l'adresse MAC du binome est : 98-ee-cb-ca-63-9d  
et la MAC de la gateway est  6c-ba-b8-9b-01-40 (trouvé avec un arp -a [ip gateway])  

### 2/

pour la vider il faut "arp -d *" ce qui donne :  
PS C:\WINDOWS\system32> arp -a  

Interface : 192.168.1.58 --- 0x4  
  Adresse Internet      Adresse physique      Type  
  192.168.1.1           6c-ba-b8-9b-01-40     dynamique  
  192.168.1.12          30-fd-38-09-02-2c     dynamique  
  192.168.1.18          e8-ca-c8-17-c4-ea     dynamique  
  224.0.0.2             01-00-5e-00-00-02     statique  
  224.0.0.22            01-00-5e-00-00-16     statique  

Interface : 192.168.56.1 --- 0x13  
  Adresse Internet      Adresse physique      Type  
  224.0.0.22            01-00-5e-00-00-16     statique  
  
### 3/

Voir fichier "ARP1erefois"  
Interface : 10.10.10.33 --- 0x16  
  Adresse Internet      Adresse physique      Type  
  224.0.0.22            01-00-5e-00-00-16     statique  

  réapparu :  
   10.10.10.34           98-ee-cb-ca-63-9d     dynamique  
  10.10.10.35           ff-ff-ff-ff-ff-ff     statique  
### 4/

1ere trame : Source : CompalIn_4f:d8:97 -> destination : Broadcast  
2eme trame : Source : WistronI_ca:63:9d -> destination : CompalIn_4f:d8:97  
les deux sources semblent être des parties d'adresses MAC (avec un identifiant?)  

## III
### 1/

voir le fichier "DORA"  
Discover : Source : 0.0.0.0 -> destination : 255.255.255.255  
Offer : Source : 192.168.1.1 -> destination : 192.168.1.58  
Request : Source : 0.0.0.0 -> destination : 255.255.255.255  
ACK (Acknowledge) : Source : 192.168.1.1 -> destination : 192.168.1.58  

1ere trame (Discover) demande a broadcast si une ip est dispo  
2eme trame (Offer) la passerelle répond en donnant une ip (la notre en l'occurance car on viens de se connecter) (donc la passerelle et l'ip sont connus)  
3eme trame (Request) demande un serveur DNS Ainsi  
4eme trame (Acknowledge) lui donne  

