# Partie 1
## I
1/🌞 S'assurer que le service sshd est démarré

```
[noah@node1 ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; preset: enabled)
     Active: active (running) since Tue 2024-01-30 14:55:28 CET; 25min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 683 (sshd)
      Tasks: 1 (limit: 4673)
     Memory: 4.8M
        CPU: 52ms
     CGroup: /system.slice/sshd.service
             └─683 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
Jan 30 14:55:28 node1.tp3.b1 systemd[1]: Starting OpenSSH server daemon...
Jan 30 14:55:28 node1.tp3.b1 sshd[683]: main: sshd: ssh-rsa algorithm is disabled
Jan 30 14:55:28 node1.tp3.b1 sshd[683]: Server listening on 0.0.0.0 port 22.
Jan 30 14:55:28 node1.tp3.b1 sshd[683]: Server listening on :: port 22.
Jan 30 14:55:28 node1.tp3.b1 systemd[1]: Started OpenSSH server daemon.
Jan 30 15:06:41 node1.tp3.b1 sshd[1403]: main: sshd: ssh-rsa algorithm is disabled
Jan 30 15:06:42 node1.tp3.b1 sshd[1403]: Accepted password for noah from 10.3.1.1 port 50322 ssh2
Jan 30 15:06:42 node1.tp3.b1 sshd[1403]: pam_unix(sshd:session): session opened for user noah(uid=1000) by (uid=0)
```
2/🌞 Analyser les processus liés au service SSH
```
[noah@node1 ~]$ ps -fe | grep sshd
root         683       1  0 14:55 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        1403     683  0 15:06 ?        00:00:00 sshd: noah [priv]
noah        1407    1403  0 15:06 ?        00:00:00 sshd: noah@pts/0
noah        1564    1408  0 15:19 pts/0    00:00:00 grep --color=auto sshd
```

3/🌞 Déterminer le port sur lequel écoute le service SSH

```
[noah@node1 ~]$ sudo ss -alnpt | grep ssh
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=683,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=683,fd=4))
```

4/🌞 Consulter les logs du service SSH

```
[noah@node1 ~]$ journalctl -xe -u sshd
Jan 30 14:55:28 node1.tp3.b1 systemd[1]: Starting OpenSSH server daemon...
[. . .]
Jan 30 15:06:42 node1.tp3.b1 sshd[1403]: pam_unix(sshd:session): session opened for user noah(uid=1000) by (uid=0)
```
```
[noah@node1 ~]$ sudo cat /var/log/secure |tail
Jan 30 15:12:46 node1 sudo[1469]: pam_unix(sudo:session): session closed for user root
Jan 30 15:26:12 node1 sudo[1570]:    noah : TTY=pts/0 ; PWD=/home/noah ; USER=root ; COMMAND=/sbin/ss -alnpt
[. . .]
Jan 30 15:39:10 node1 sudo[1590]: pam_unix(sudo:session): session closed for user root
```

## II

1/🌞 Identifier le fichier de configuration du serveur SSH
```
[noah@node1 ~]$ sudo cat /etc/ssh/ssh_config
#       $OpenBSD: ssh_config,v 1.35 2020/07/17 03:43:42 dtucker Exp $

# This is the ssh client system-wide configuration file.  See
# ssh_config(5) for more information.  This file provides defaults for
# users, and the values can be changed in per-user configuration files
# or on the command line.

# Configuration data is parsed as follows:
#  1. command line options
#  2. user-specific file
#  3. system-wide file
# Any configuration value is only changed the first time it is set.
# Thus, host-specific definitions should be at the beginning of the
# configuration file, and defaults at the end.

# Site-wide defaults for some commonly used options.  For a comprehensive
# list of available options, their meanings and defaults, please see the
# ssh_config(5) man page.

# Host *
#   ForwardAgent no
#   ForwardX11 no
#   PasswordAuthentication yes
#   HostbasedAuthentication no
#   GSSAPIAuthentication no
#   GSSAPIDelegateCredentials no
#   GSSAPIKeyExchange no
#   GSSAPITrustDNS no
#   BatchMode no
#   CheckHostIP yes
#   AddressFamily any
#   ConnectTimeout 0
#   StrictHostKeyChecking ask
#   IdentityFile ~/.ssh/id_rsa
#   IdentityFile ~/.ssh/id_dsa
#   IdentityFile ~/.ssh/id_ecdsa
#   IdentityFile ~/.ssh/id_ed25519
#   Port 22
#   Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc
#   MACs hmac-md5,hmac-sha1,umac-64@openssh.com
#   EscapeChar ~
#   Tunnel no
#   TunnelDevice any:any
#   PermitLocalCommand no
#   VisualHostKey no
#   ProxyCommand ssh -q -W %h:%p gateway.example.com
#   RekeyLimit 1G 1h
#   UserKnownHostsFile ~/.ssh/known_hosts.d/%k
#
# This system is following system-wide crypto policy.
# To modify the crypto properties (Ciphers, MACs, ...), create a  *.conf
#  file under  /etc/ssh/ssh_config.d/  which will be automatically
# included below. For more information, see manual page for
#  update-crypto-policies(8)  and  ssh_config(5).
Include /etc/ssh/ssh_config.d/*.conf
```

2/🌞 Modifier le fichier de conf
```
[noah@node1 ~]$ sudo cat /etc/ssh/sshd_config | grep -i port
# If you want to change the port on a SELinux system, you have to tell
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
Port 6452
# WARNING: 'UsePAM no' is not supported in RHEL and may cause several
#GatewayPorts no
```
```
[noah@node1 ~]$ sudo firewall-cmd --list-all |grep port
  ports: 6452/tcp
  forward-ports:
  source-ports:
```

3/🌞 Redémarrer le service

```
[noah@node1 ~]$ sudo systemctl restart sshd
```

4/🌞 Effectuer une connexion SSH sur le nouveau port
```
PS C:\Users\andre> ssh noah@10.3.1.11 -p 6452
noah@10.3.1.11's password:
Last login: Tue Jan 30 15:06:42 2024 from 10.3.1.1
[noah@node1 ~]$
```

# Partie 2

1/
```
[noah@node1 ~]$ sudo dnf install nginx
[sudo] password for noah:
Rocky Linux 9 - BaseOS                                                                  7.0 kB/s | 4.1 kB     00:00
[. . .]
rocky-logos-httpd-90.14-2.el9.noarch

Complete!
```

2/

```
sudo systemctl start nginx
```

3/

```
[noah@node1 ~]$ ss -alntp | grep 80
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*
LISTEN 0      511             [::]:80           [::]:*
```
```
[noah@node1 ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for noah:
success
[noah@node1 ~]$ sudo firewall-cmd --reload
success
```

4/
```
[noah@node1 ~]$ ps -ef | grep nginx
root        4197       1  0 13:29 ?        00:00:00 nginx: master process nginx
nginx       4198    4197  0 13:29 ?        00:00:00 nginx: worker process
noah        4288    1355  0 13:49 pts/0    00:00:00 grep --color=auto nginx
```

5/
```
[noah@node1 ~]$ sudo cat /etc/passwd | grep nginx
nginx:x:991:991:Nginx web server:/var/lib/nginx:/sbin/nologin
```

6/ 
```
curl http://10.2.1.11 | head -n 7
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0  3446k      0 --:--:-- --:--:-- --:--:-- 3720k
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
```
## 2/
7/
```
[noah@node1 ~]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Oct 16 20:00 /etc/nginx/nginx.conf
```

8/
```
[noah@node1 ~]$ sudo cat /etc/nginx/nginx.conf | grep server -A 12
[sudo] password for noah:
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
```
```
[noah@node1 ~]$ sudo cat /etc/nginx/nginx.conf | grep include
include /usr/share/nginx/modules/*.conf;
    include             /etc/nginx/mime.types;
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```

## 3

9/ 
```
[noah@node1 ~]$ sudo rm -r /var/www/
[noah@node1 ~]$ sudo mkdir /var/cunsite/
[noah@node1 ~]$ cd /var/cunsite/
[noah@node1 cunsite]$ sudo mkdir tplinux3
[noah@node1 cunsite]$ sudo touch index.html
[noah@node1 cunsite]$ sudo nano index.html
<h1>bonsoiirrr parisss</h1>
```

10/
```
[noah@node1 cunsite]$ sudo chown nginx /var/cunsite/tplinux3/
```