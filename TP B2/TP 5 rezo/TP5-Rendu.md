# 1/

🌞 Récupérer l'application dans la VM hosting.tp5.b1

```
[noah@hosting ~]$ curl -O https://gitlab.com/it4lik/b2-network-2024/-/raw/main/tp/net/5/server.py?inline=false
```

🌞 Essayer de lancer l'app

```
[noah@hosting ~]$ python server.py

[noah@hosting ~]$ ss -lutnp
tcp           LISTEN         0              1                            0.0.0.0:13337                      0.0.0.0:*            users:(("python",pid=1702,fd=3))

```

🌞 Tester l'app depuis hosting.tp5.b1

```
[noah@hosting ~]$ python client.py
Calcul à envoyer: 789-987
-198
```

🌞 Créer le fichier /etc/systemd/system/calculatrice.service

```
[noah@hosting ~]$ sudo touch /etc/systemd/system/calculatrice.service       
```

🌞 Démarrer le service
```
[noah@hosting ~]$ sudo systemctl status calculatrice
● calculatrice.service - Super calculatrice réseau
     Loaded: loaded (/etc/systemd/system/calculatrice.service; disabled; pr>
     Active: active (running) since Thu 2024-10-24 16:02:21 CEST; 15s ago
   Main PID: 1910 (python)
      Tasks: 1 (limit: 4666)
     Memory: 3.3M
        CPU: 13ms
     CGroup: /system.slice/calculatrice.service
             └─1910 /usr/bin/python /opt/calculatrice/server.py

Oct 24 16:02:21 hosting.tp5.b1 systemd[1]: Started Super calculatrice résea>

[noah@hosting ~]$ ss -lutnp |grep 13337
tcp   LISTEN 0      1            0.0.0.0:13337      0.0.0.0:*

[noah@hosting ~]$ python client.py
Calcul à envoyer: 10+7
17
```

🌞 Configurer une politique de redémarrage dans le fichier calculatrice.service
```
[noah@hosting ~]$ cat /etc/systemd/system/calculatrice.service
[Unit]
Description=Super calculatrice réseau

[Service]
ExecStart=/usr/bin/python /opt/calculatrice/server.py
Restart=on-failure
RestartSec=30

[Install]
WantedBy=multi-user.target
```

🌞 Tester que la politique de redémarrage fonctionne

```
[noah@hosting ~]$ sudo systemctl status calculatrice
● calculatrice.service - Super calculatrice réseau
     Loaded: loaded (/etc/systemd/system/calculatrice.service; disabled; preset: disabled)
     Active: activating (auto-restart) (Result: signal) since Thu 2024-10-24 17:02:48 CEST; 26s ago
    Process: 2032 ExecStart=/usr/bin/python /opt/calculatrice/server.py (code=killed, signal=KILL)
   Main PID: 2032 (code=killed, signal=KILL)
        CPU: 27ms

Oct 24 17:02:48 hosting.tp5.b1 systemd[1]: calculatrice.service: Main process exited, code=killed, status=9/KILL
Oct 24 17:02:48 hosting.tp5.b1 systemd[1]: calculatrice.service: Failed with result 'signal'.
[noah@hosting ~]$ sudo systemctl status calculatrice
● calculatrice.service - Super calculatrice réseau
     Loaded: loaded (/etc/systemd/system/calculatrice.service; disabled; preset: disabled)
     Active: active (running) since Thu 2024-10-24 17:03:18 CEST; 1s ago
   Main PID: 2093 (python)
      Tasks: 1 (limit: 4666)
     Memory: 3.3M
        CPU: 38ms
     CGroup: /system.slice/calculatrice.service
             └─2093 /usr/bin/python /opt/calculatrice/server.py

Oct 24 17:03:18 hosting.tp5.b1 systemd[1]: Started Super calculatrice réseau.
```

🌞 Ouverture automatique du firewall dans le fichier calculatrice.service

```
[noah@hosting ~]$ cat /etc/systemd/system/calculatrice.service
[Unit]
Description=Super calculatrice réseau

[Service]
ExecStart=/usr/bin/python /opt/calculatrice/server.py
Restart=on-failure
RestartSec=30
ExecStartPre=/usr/bin/firewall-cmd --add-port=13337/tcp --permanent
ExecStartPre=/usr/bin/firewall-cmd --reload
ExecStopPost=/usr/bin/firewall-cmd --remove-port=13337/tcp --permanent
ExecStopPost=/usr/bin/firewall-cmd --reload

[Install]
WantedBy=multi-user.target
```

🌞 Vérifier l'ouverture automatique du firewall

```bash
[noah@hosting ~]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8
  sources:
  services: cockpit dhcpv6-client ssh
  ports: 13337/tcp
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
[noah@hosting ~]$ sudo systemctl status calculatrice
● calculatrice.service - Super calculatrice réseau
     Loaded: loaded (/etc/systemd/system/calculatrice.service; disabled; preset: disabled)
     Active: active (running) since Thu 2024-10-24 17:59:47 CEST; 9s ago
    Process: 2526 ExecStartPre=/usr/bin/firewall-cmd --add-port=13337/tcp --permanent (code=exited, status=0/SUCCESS)
    Process: 2528 ExecStartPre=/usr/bin/firewall-cmd --reload (code=exited, status=0/SUCCESS)
   Main PID: 2531 (python)
      Tasks: 1 (limit: 4666)
     Memory: 3.3M
        CPU: 227ms
     CGroup: /system.slice/calculatrice.service
             └─2531 /usr/bin/python /opt/calculatrice/server.py

Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: Starting Super calculatrice réseau...
Oct 24 17:59:47 hosting.tp5.b1 firewall-cmd[2526]: success
Oct 24 17:59:47 hosting.tp5.b1 firewall-cmd[2528]: success
Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: Started Super calculatrice réseau.
[noah@hosting ~]$ sudo systemctl status calculatrice
○ calculatrice.service - Super calculatrice réseau
     Loaded: loaded (/etc/systemd/system/calculatrice.service; disabled; preset: disabled)
     Active: inactive (dead)

Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: calculatrice.service: Deactivated successfully.
Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: Stopped Super calculatrice réseau.
Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: Starting Super calculatrice réseau...
Oct 24 17:59:47 hosting.tp5.b1 firewall-cmd[2526]: success
Oct 24 17:59:47 hosting.tp5.b1 firewall-cmd[2528]: success
Oct 24 17:59:47 hosting.tp5.b1 systemd[1]: Started Super calculatrice réseau.
Oct 24 18:00:42 hosting.tp5.b1 python[2531]: Données reçues du client : b'Hello'
Oct 24 18:00:42 hosting.tp5.b1 firewall-cmd[2537]: success
Oct 24 18:00:42 hosting.tp5.b1 firewall-cmd[2538]: success
Oct 24 18:00:42 hosting.tp5.b1 systemd[1]: calculatrice.service: Deactivated successfully.
[noah@hosting ~]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

  PS C:\Users\andre> python3.12.exe 'C:\Users\andre\Downloads\client.py'
Calcul à envoyer: 7+7-8
6
```