# 1.

☀️ Carte réseau WiFi

```
C:\Users\andre>ipconfig /all :  
   Adresse physique . . . . . . . . . . . : 48-68-4A-B3-70-0E

   Adresse IPv4. . . . . . . . . . . . . .: 10.33.72.233(préféré)

    Masque de sous-réseau. . . . . . . . . : 255.255.240.0
    Notation CIDR /20
    10.33.79.255/20
   ```

   ☀️ Déso pas déso  
    10.33.79.255  
    10.33.7.255  
   4094 adresses dispos  
   ☀️ Hostname
```
C:\Users\andre>hostname
Noah
```

☀️ Passerelle du réseau

```
C:\Users\andre>ipconfig /all :  
    Passerelle par défaut. . . . . . . . . : 10.33.79.254
    C:\Users\andre>arp -a :  
    10.33.79.254          7c-5a-1c-d3-d8-76     dynamique
```

☀️ Serveur DHCP et DNS
```
C:\Users\andre>ipconfig /all :  

 Serveur DHCP . . . . . . . . . . . . . : 10.33.79.254  
  Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8  
                                       1.1.1.1  
```

☀️ Table de routage

```
C:\Users\andre>netstat -r

          0.0.0.0          0.0.0.0     10.33.79.254     10.33.72.233     35
```

# 2.

☀️ Hosts ?

```
C:\Users\andre>ping b2.hello.vous

Envoi d’une requête 'ping' sur b2.hello.vous [1.1.1.1] avec 32 octets de données :
Réponse de 1.1.1.1 : octets=32 temps=15 ms TTL=55
Réponse de 1.1.1.1 : octets=32 temps=16 ms TTL=55
Réponse de 1.1.1.1 : octets=32 temps=19 ms TTL=55
Réponse de 1.1.1.1 : octets=32 temps=19 ms TTL=55

Statistiques Ping pour 1.1.1.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 15ms, Maximum = 19ms, Moyenne = 17ms
```

☀️ Go mater une vidéo youtube et déterminer, pendant qu'elle tourne...

serveur : 142.250.201.46
port : 443
port local : 56 443
(fais sur WireShark)

☀️ Requêtes DNS

```
C:\Users\andre>nslookup www.thinkerview.com
Serveur :   dns.google
Address:  8.8.8.8

Réponse ne faisant pas autorité :
Nom :    www.thinkerview.com
Addresses:  2a06:98c1:3121::7
          2a06:98c1:3120::7
          188.114.97.7
          188.114.96.7
```
```
C:\Users\andre>nslookup 143.90.88.12  
Nom :    EAOcf-140p12.ppp15.odn.ne.jp
```

☀️ Hop hop hop
```
C:\Users\andre>tracert www.ynov.com

Détermination de l’itinéraire vers www.ynov.com [104.26.11.233]
avec un maximum de 30 sauts :

  1     3 ms     1 ms     1 ms  10.33.79.254
  2     4 ms     6 ms     3 ms  145.117.7.195.rev.sfr.net [195.7.117.145]
  3     7 ms     4 ms     3 ms  237.195.79.86.rev.sfr.net [86.79.195.237]
  4     3 ms     3 ms     3 ms  196.224.65.86.rev.sfr.net [86.65.224.196]
  5    11 ms    11 ms    10 ms  164.147.6.194.rev.sfr.net [194.6.147.164]
  6    30 ms     *        *     162.158.20.24
  7    18 ms    16 ms    22 ms  162.158.20.31
  8    16 ms    18 ms    17 ms  104.26.11.233
```

☀️ IP publique
```
C:\Users\andre>ipconfig /all
   Passerelle par défaut. . . . . . . . . : 10.33.79.254
```

# 3.

☀️ Capture ARP

```
C:\Users\andre>ping 10.33.79.254

Envoi d’une requête 'Ping'  10.33.79.254 avec 32 octets de données :
Délai d’attente de la demande dépassé.
Délai d’attente de la demande dépassé.

Statistiques Ping pour 10.33.79.254:
    Paquets : envoyés = 2, reçus = 0, perdus = 2 (perte 100%),
```

☀️ Capture DNS

```
C:\Users\andre>nslookup jouetclub.fr
Serveur :   dns.google
Address:  8.8.8.8

Réponse ne faisant pas autorité :
Nom :    jouetclub.fr
Address:  217.70.184.55
```

☀️ Capture TCP

```
C:\Users\andre>curl pokedle.net
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>cloudflare</center>
</body>
</html>
```