# Partie 1
## I

1/🌞 Trouver le chemin vers le répertoire 
```
personnel de votre utilisateur
pwd -> /home/noah
```

2/🌞 Trouver le chemin du fichier de logs SSH  
```
le fichier de log ssh se situe a ~/var/log/secure
```

3/🌞 Trouver le chemin du fichier de configuration du serveur SSH  
```
le fichier de config se situe a /etc/ssh/sshd_config (quand on se situe a la racine)
```

## II  
4/🌞 Créer un nouvel utilisateur  
```
sudo useradd -d /home/papier_alu marmotte puis sudo passwd marmotte (en mettant 2x chocolat)
```

5/🌞 Prouver que cet utilisateur a été créé  
```
résultat de : sudo cat /etc/passwd |grep marmotte = marmotte:x:1001:1001::/home/papier_alu:/bin/bash
```


6/🌞 Déterminer le hash du password de l'utilisateur marmotte  
```
résultat de : sudo cat /etc/shadow |grep marmotte = "marmotte:d8729025d3be00402ed19188828f029c:19744:0:99999:7:::
```

## III
7/🌞 Tapez une commande pour vous déconnecter : fermer votre session utilisateur  
`la commande "exit"`

8/🌞 Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur marmotte  
`[marmotte@localhost ~]$`

# Partie 2

## 1.

## I

1/🌞 Lancer un processus sleep  
```
ps aux |grep sleep 
noah        1922  0.0  0.1   5584  1024 pts/0    S+   20:55   0:00 sleep 1000
```

2/🌞 Terminez le processus sleep depuis le deuxième terminal  
```
[noah@localhost ~]$ kill 1922

et on reçoit "Terminated" sur le terminal qui était sleep
```

## II
3/🌞 Lancer un nouveau processus sleep, mais en tâche de fond  
```
"sleep 1000 &" permet de sleep en arrière plan
```

4/🌞 Visualisez la commande en tâche de fond  
```
[noah@localhost ~]$ jobs 
[1]-  Running               sleep 1000 &
```

## III
5/🌞 Trouver le chemin où est stocké le programme sleep  
```
[noah@localhost ~]$ ls -al /usr/bin/sleep

-rwxr-xr-x. 1 root root 36312 Apr 24  2023 /usr/bin/sleep
```

6/🌞 Tant qu'on est à chercher des chemins : trouver les chemins vers tous les fichiers qui s'appellent `.bashrc`  
```
[noah@localhost ~]$ sudo find / -name ".bashrc" 

/etc/skel/.bashrc
/root/.bashrc
/home/noah/.bashrc
/home/papier_alu/.bashrc
```

## IV
7/🌞 Vérifier que les commandes sleep, ssh, et ping sont bien des programmes stockés dans l'un des dossiers listés dans votre PATH  
```
Sleep :
[noah@localhost ~]$ which sleep
/usr/bin/sleep

Ssh : [noah@localhost ~]$ which ssh 
/usr/bin/ssh

Ping : [noah@localhost ~]$ which ping
/usr/bin/ping
```
## 2.

8/🌞 Installer le paquet git  
`[noah@localhost ~]$ sudo dnf install git`

9/🌞 Utiliser une commande pour lancer git  
```
[noah@localhost ~]$ git show
fatal: not a git repository (or any of the parent directories): .git
```
chemin : `/usr/bin/git`

10/🌞 Installer le paquet nginx  

```bash
$ sudo dnf install nginx
```

11/🌞 Déterminer  
le chemin vers le dossier de logs de NGINX
```
[noah@localhost ~]$ sudo ls /var/log/nginx/
```

le chemin vers le dossier qui contient la configuration de NGINX
```
[noah@localhost ~]$ sudo ls /etc/nginx/conf.d/
```

12/🌞 Mais aussi déterminer...
```
[noah@localhost yum.repos.d]$ grep -rn -E '^mirrorlist'

rocky-addons.repo:13:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=HighAvailability-$releasever$rltype
[...]
rocky.repo:88:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=CRB-$releasever-source$rltype
```