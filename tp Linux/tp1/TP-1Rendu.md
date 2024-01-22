1/ delete les fichiers kernels dans le /boot


2/ sudo passwd tout les utilisateurs de /etc/passwd qui ont un mdp
2/ Supprimer /etc/passwd puis /etc/shadow permet d'empecher TOUT user (root y compris) de ce connecter


3/ dd if=/dev/zero of=/dev/sda bs=4M  
envoie des 0 (dev/zero) a dev/sda (le disque dur)

4/ creer un fichier dans .bash_profile qui se echo (echo /.bash_profile/fichier) et quand on se co , sa reboot