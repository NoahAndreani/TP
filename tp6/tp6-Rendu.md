## II.
### 2/

🌞 Dans le rendu, je veux

[noah@dns ~]$ sudo cat /etc/named.conf  
[sudo] password for noah:  
options {  
        listen-on port 53 { 127.0.0.1; any; };  
        listen-on-v6 port 53 { ::1; };  
        directory       "/var/named";  
        dump-file       "/var/named/data/cache_dump.db";  
        statistics-file "/var/named/data/named_stats.txt";  
        memstatistics-file "/var/named/data/named_mem_stats.txt";  
        secroots-file   "/var/named/data/named.secroots";  
        recursing-file  "/var/named/data/named.recursing";  
        allow-query     { localhost; any; };  
        allow-query-cache { localhost; any; };  

        recursion yes;  

        dnssec-validation yes;  

        managed-keys-directory "/var/named/dynamic";  
        geoip-directory "/usr/share/GeoIP";  

        pid-file "/run/named/named.pid";  
        session-keyfile "/run/named/session.key";  


        include "/etc/crypto-policies/back-ends/bind.config";  
};  

logging {  
        channel default_debug {  
                file "data/named.run";  
                severity dynamic;  
        };  
};  

zone "tp6.b1" IN {  
        type master;  
        file "tp6.b1.db";  
        allow-update { none; };  
        allow-query {any; };  
};  
zone "1.4.10.in-addr.arpa" IN {  
     type master;  
     file "tp6.b1.rev";  
     allow-update { none; };  
     allow-query { any; };  
};  

include "/etc/named.rfc1912.zones";  
include "/etc/named.root.key";  


[noah@dns ~]$ sudo cat /var/named/tp6.b1.db  
$TTL 86400  
@ IN SOA dns.tp6.b1. admin.tp6.b1. (   
    2019061800  
    3600  
    1800  
    604800  
    86400  
)  

@ IN NS dns.tp6.b1.  

dns       IN A 10.6.1.101  
john      IN A 10.6.1.11  

[noah@dns ~]$ sudo cat /var/named/tp6.b1.rev  
$TTL 86400  
@ IN SOA dns.tp6.b1. admin.tp6.b1. (  
    2019061800  
    3600  
    1800  
    604800  
    86400  
)  

@ IN NS dns.tp6.b1.  

101 IN PTR dns.tp6.b1.  
11 IN PTR john.tp6.b1.  

Le systemctl status named :  
[noah@dns ~]$ systemctl status named  
● named.service - Berkeley Internet Name Domain (DNS)  
     Loaded: loaded (/usr/lib/systemd/system/named.service; enabled; preset>  
     Active: active (running) since Thu 2023-11-23 14:42:30 CET; 10min ago  
    Process: 686 ExecStartPre=/bin/bash -c if [ ! "$DISABLE_ZONE_CHECKING" >  
    Process: 701 ExecStart=/usr/sbin/named -u named -c ${NAMEDCONF} $OPTION>  
   Main PID: 704 (named)  
      Tasks: 5 (limit: 4673)  
     Memory: 24.0M  
        CPU: 319ms  
     CGroup: /system.slice/named.service  
             └─704 /usr/sbin/named -u named -c /etc/named.conf  


🌞 Ouvrez le bon port dans le firewall  

sudo ss -lntpu  
udp         UNCONN       0            0         10.6.1.101:53             0.0.0.0:*           users:(("named",pid=704,fd=6))  

### 3/

🌞 Sur la machine john.tp6.b1  

résoudre des noms comme john.tp6.b1 et dns.tp6.b1  
  
[noah@john ~]$ dig john.tp6.b1  

; <<>> DiG 9.16.23-RH <<>> john.tp6.b1  
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49136  
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  

;; OPT PSEUDOSECTION:  
; EDNS: version: 0, flags:; udp: 1232  
; COOKIE: 6b65ebc44fa1acc301000000655f602582a384aa3a0975a2 (good)  
;; QUESTION SECTION:
;john.tp6.b1.                   IN      A   

;; ANSWER SECTION:  
john.tp6.b1.            86400   IN      A       10.6.1.11  

;; Query time: 4 msec  
;; SERVER: 10.6.1.101#53(10.6.1.101)  
;; WHEN: Thu Nov 23 15:22:29 CET 2023  
;; MSG SIZE  rcvd: 84  

[noah@john network-scripts]$ dig dns.tp6.b1  
  
; <<>> DiG 9.16.23-RH <<>> dns.tp6.b1  
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 65231  
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  

;; OPT PSEUDOSECTION:  
; EDNS: version: 0, flags:; udp: 1232  
; COOKIE: fae5f4ea81e850ad01000000655f613fb190bbfaaf02039c (good)  
;; QUESTION SECTION:
;dns.tp6.b1.                    IN      A  

;; ANSWER SECTION:  
dns.tp6.b1.             86400   IN      A       10.6.1.101  

;; Query time: 4 msec  
;; SERVER: 10.6.1.101#53(10.6.1.101)  
;; WHEN: Thu Nov 23 15:27:11 CET 2023  
;; MSG SIZE  rcvd: 83  

mais aussi des noms comme www.ynov.com  

[noah@john network-scripts]$ dig www.ynov.com  

; <<>> DiG 9.16.23-RH <<>> www.ynov.com  
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10518  
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1  

;; OPT PSEUDOSECTION:  
; EDNS: version: 0, flags:; udp: 1232  
; COOKIE: 4fd1d00a222113c401000000655f618d298153655c365268 (good)  
;; QUESTION SECTION:  
;www.ynov.com.                  IN      A  

;; ANSWER SECTION:  
www.ynov.com.           300     IN      A       104.26.10.233  
www.ynov.com.           300     IN      A       104.26.11.233  
www.ynov.com.           300     IN      A       172.67.74.226  

;; Query time: 196 msec  
;; SERVER: 10.6.1.101#53(10.6.1.101)  
;; WHEN: Thu Nov 23 15:28:29 CET 2023  
;; MSG SIZE  rcvd: 117  

Connecter uniquement a NOTRE DNS :

[noah@john network-scripts]$ cat /etc/resolv.conf  
 Generated by NetworkManager  
search tp6.b1  
nameserver 10.6.1.101  

🌞 Sur votre PC  

utilisez une commande pour résoudre le nom john.tp6.b1 en utilisant 10.6.1.101 comme serveur DNS

PS C:\Users\andre> nslookup john.tp6.b1 10.6.1.101  
Serveur :   UnKnown  
Address:  10.6.1.101  

Nom :    john.tp6.b1  
Address:  10.6.1.11  
