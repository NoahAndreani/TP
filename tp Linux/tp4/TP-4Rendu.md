# Partie 1

1/🌞 Partitionner le disque à l'aide de LVM
```bash
[noah@storage ~]$ sudo lvcreate -l 100%FREE storage -n unedata
```

```bash
[noah@storage ~]$ sudo vgcreate storage /dev/sdb
```

```bash
[noah@storage ~]$ sudo vgextend storage /dev/sdc
```

2/🌞 Formater la partition

```bash
[noah@storage ~]$ sudo mkfs /dev/storage/unedata
```

3/🌞 Monter la partition

```bash
[noah@storage ~]$ sudo mount /dev/storage/unedata /storage/
```

```bash
[noah@storage ~]$ df -h |grep /storage
/dev/mapper/storage-unedata  3.9G   24K  3.7G   1% /storage
```

```bash
[noah@storage storage]$ sudo cat /etc/fstab
/dev/storage/unedata /storage ext4 defaults 0 0
```

apres un reboot
```bash
[noah@storage ~]$ df -h| grep /storage
/dev/mapper/storage-unedata  3.9G   24K  3.7G   1% /storage
```
# Partie 2

1/🌞 Donnez les commandes réalisées sur le serveur NFS storage.tp4.linux
```bash
[noah@storage /]$ sudo mkdir /storage/site_web_1
[noah@storage /]$ sudo mkdir /storage/site_web_2

[noah@storage storage]$ sudo cat /etc/exports
/storage/site_web_1    10.4.2.3(rw,sync,no_subtree_check)
/storage/site_web_2    10.4.2.3(rw,sync,no_root_squash,no_subtree_check)
```
2/🌞 Donnez les commandes réalisées sur le client NFS web.tp4.linux
```bash
 [noah@web ~]$ sudo cat /etc/fstab
 /dev/mapper/rl-root     /                       xfs     defaults        0 0
UUID=d29edd13-1c5e-40bf-ba8b-f30a5a53b97e /boot                   xfs     defaults        0 0
/dev/mapper/rl-swap     none                    swap    defaults        0 0
10.4.2.2:/storage/site_web_1    /var/www/site_web_1   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
10.4.2.2:/storage/site_web_2    /var/www/site_web_2   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
```

# Partie 3

1/🌞 Installez NGINX

```bash
sudo dnf install nginx
```

2/🌞 Analysez le service NGINX

I. Avec une commande ps, déterminer sous quel utilisateur tourne le processus du service NGINX
```bash
[noah@web ~]$ ps -ef |grep nginx
root        2697       1  0 Feb20 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       2698    2697  0 Feb20 ?        00:00:00 nginx: worker process
noah        2869    1299  0 00:29 pts/0    00:00:00 grep --color=auto nginx
```
II. Avec une commande ss, déterminer derrière quel port écoute actuellement le serveur web
```bash
[noah@web ~]$ ss -salpute |grep nginx
tcp   LISTEN 0      511          0.0.0.0:http        0.0.0.0:*    ino:29049 sk:49 cgroup:/system.slice/nginx.service <->
tcp   LISTEN 0      511             [::]:http           [::]:*    ino:29050 sk:4c cgroup:/system.slice/nginx.service v6only:1 <->
```
en regardant la conf, déterminer dans quel dossier se trouve la racine web
```bash
[noah@web ~]$ cat /etc/nginx/nginx.conf | grep root
        root         /usr/share/nginx/html;
#        root         /usr/share/nginx/html;
```

inspectez les fichiers de la racine web, et vérifier qu'ils sont bien accessibles en lecture par l'utilisateur qui lance le processus
```bash
[noah@web ~]$ ls -lA /var/www/
total 8
drwxr-xr-x. 2 nobody root 4096 Feb 20 15:50 site_web_1
drwxr-xr-x. 2 nobody root 4096 Feb 20 15:54 site_web_2
```

3/🌞 Configurez le firewall pour autoriser le trafic vers le service NGINX

```bash
[noah@web ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[noah@web ~]$ sudo firewall-cmd --reload
```

4/🌞 Accéder au site web

```bash
[noah@web ~]$ curl http://10.4.2.3:80
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/
[ . . .]
</html>
```

5/🌞 Vérifier les logs d'accès

```bash
[noah@web ~]$ sudo tail -n 3 /var/log/nginx/access.log
10.4.2.1 - - [21/Feb/2024:02:30:50 +0100] "GET /poweredby.png HTTP/1.1" 200 368 "http://10.4.2.3/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:122.0) Gecko/20100101 Firefox/122.0" "-"
10.4.2.1 - - [21/Feb/2024:02:30:50 +0100] "GET /favicon.ico HTTP/1.1" 404 3332 "http://10.4.2.3/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:122.0) Gecko/20100101 Firefox/122.0" "-"
10.4.2.3 - - [21/Feb/2024:02:31:58 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
```

6/🌞 Changer le port d'écoute

une simple ligne à modifier, vous me la montrerez dans le compte rendu

```bash
[noah@web ~]$ sudo cat /etc/nginx/nginx.conf |grep listen
        listen       8080;
        listen       [::]:8080;
```
redémarrer le service pour que le changement prenne effet

```bash
[noah@web ~]$ systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
     Active: active (running) since Wed 2024-02-21 03:06:37 CET; 9s ago
    Process: 3096 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 3097 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 3098 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 3099 (nginx)
      Tasks: 2 (limit: 4673)
     Memory: 1.9M
        CPU: 16ms
     CGroup: /system.slice/nginx.service
             ├─3099 "nginx: master process /usr/sbin/nginx"
             └─3100 "nginx: worker process"

Feb 21 03:06:37 web.tp4.linux systemd[1]: nginx.service: Deactivated successfully.
Feb 21 03:06:37 web.tp4.linux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Feb 21 03:06:37 web.tp4.linux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Feb 21 03:06:37 web.tp4.linux nginx[3097]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Feb 21 03:06:37 web.tp4.linux nginx[3097]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Feb 21 03:06:37 web.tp4.linux systemd[1]: Started The nginx HTTP and reverse proxy server.
```

prouvez-moi que le changement a pris effet

```bash
[noah@web ~]$ ss -salpute| grep nginx
tcp   LISTEN 0      511          0.0.0.0:webcache      0.0.0.0:*    ino:33264 sk:54 cgroup:/system.slice/nginx.service <->
tcp   LISTEN 0      511             [::]:webcache         [::]:*    ino:33265 sk:55 cgroup:/system.slice/nginx.service v6only:1 <->
```

n'oubliez pas de fermer l'ancien port dans le firewall, et d'ouvrir le nouveau

```bash
[noah@web ~]$ sudo firewall-cmd --add-port=8080/tcp --permanent
[sudo] password for noah:
success
[noah@web ~]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
[noah@web ~]$ sudo firewall-cmd --reload
success
```

prouvez avec une commande curl sur votre machine que vous pouvez désormais visiter le port 8080

```bash
[noah@web ~]$ curl http://10.4.2.3:8080
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/
      [. . .]
</html>
```

#! chemin vers bash  
#nom  
#date