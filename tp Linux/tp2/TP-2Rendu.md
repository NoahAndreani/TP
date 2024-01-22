## I

1/🌞 Trouver le chemin vers le répertoire ```personnel de votre utilisateur
pwd -> /home/noah```

2/🌞 Trouver le chemin du fichier de logs SSH  
```le fichier de log ssh se situe a ~/var/log/secure```

3/🌞 Trouver le chemin du fichier de configuration du serveur SSH  
```le fichier de config se situe a /etc/ssh/sshd_config (quand on se situe a la racine)```

## II  
4/🌞 Créer un nouvel utilisateur  
```sudo useradd -d /home/papier_alu marmotte puis sudo passwd marmotte (en mettant 2x chocolat)```

5/🌞 Prouver que cet utilisateur a été créé  
```résultat de : sudo cat /etc/passwd |grep marmotte = marmotte:x:1001:1001::/home/papier_alu:/bin/bash```


6/🌞 Déterminer le hash du password de l'utilisateur marmotte  
```résultat de : sudo cat /etc/shadow |grep marmotte = "marmotte:chocolat:19744:0:99999:7:::```

## III
7/🌞 Tapez une commande pour vous déconnecter : fermer votre session utilisateur  
```la commande "exit"```

8/🌞 Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur marmotte  
```[marmotte@localhost ~]$```