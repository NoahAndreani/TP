🌞 Ajouter votre utilisateur au groupe docker
```
 sudo usermod -aG docker noah
```
 🌞 Lancer un conteneur NGINX
```
 docker run -d -p 9999:80 nginx
```

🌞 Visitons

```bash
vérifier que le conteneur est actif avec une commande qui liste les conteneurs en cours de fonctionnement

[noah@B2Tp1Docker ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS
     NAMES
36ca23c32d43   nginx     "/docker-entrypoint.…"   31 minutes ago   Up 31 minutes   0.0.0.0:9999->80/tcp, [::]:9999->80/tcp   vigorous_williams

afficher les logs du conteneur

[noah@B2Tp1Docker ~]$ docker logs 36

afficher toutes les informations relatives au conteneur avec une commande docker inspect

docker inspect [id]

afficher le port en écoute sur la VM avec un sudo ss -lnpt

[noah@B2Tp1Docker ~]$ sudo ss -lnpt
[sudo] password for noah:
State     Recv-Q    Send-Q       Local Address:Port       Peer Address:Port   Process
LISTEN    0         4096               0.0.0.0:9999            0.0.0.0:*       users:(("docker-proxy",pid=4913,fd=4))
LISTEN    0         128                0.0.0.0:22              0.0.0.0:*       users:(("sshd",pid=1598,fd=3))
LISTEN    0         4096                  [::]:9999               [::]:*       users:(("docker-proxy",pid=4919,fd=4))
LISTEN    0         128                   [::]:22                 [::]:*       users:(("sshd",pid=1598,fd=4))
```


🌞 Ecrire un Dockerfile pour une image qui héberge une application Python
```
[noah@B2Tp1Docker python_app_build]$ docker build . -t python_app:version_de_ouf
[+] Building 33.1s (10/10) FINISHED                                                                      docker:default
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 254B                                                                               0.0s
 => [internal] load metadata for docker.io/library/debian:latest                                                   1.9s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [1/5] FROM docker.io/library/debian:latest@sha256:17122fe3d66916e55c0cbd5bbf54bb3f87b3582f4d86a755a0fd3498d36  0.2s
 => => resolve docker.io/library/debian:latest@sha256:17122fe3d66916e55c0cbd5bbf54bb3f87b3582f4d86a755a0fd3498d36  0.1s
 => => sha256:17122fe3d66916e55c0cbd5bbf54bb3f87b3582f4d86a755a0fd3498d360f91b 8.52kB / 8.52kB                     0.0s
 => => sha256:ec54b6327d5099ab29b38d70f7290e42d8769ef676fc262b34a18b688104f61b 1.02kB / 1.02kB                     0.0s
 => => sha256:ff869c3288a47c9625a60473a3d5108ec45bd095a00e23568a82ee8b95d12954 453B / 453B                         0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 188B                                                                                  0.0s
 => [2/5] RUN apt update -y                                                                                        8.1s
 => [3/5] RUN apt install -y python3                                                                              16.7s
 => [4/5] RUN apt install python3-emoji                                                                            3.1s
 => [5/5] COPY app.py /app/app.py                                                                                  0.4s
 => exporting to image                                                                                             2.4s
 => => exporting layers                                                                                            2.3s
 => => writing image sha256:27075160d8e5b5a51935e0dc6c87f90d937e086399f329c56fb4e37ef4a66176                       0.0s
 => => naming to docker.io/library/python_app:version_de_ouf                                                       0.0s


 [noah@B2Tp1Docker python_app_build]$ cat Dockerfile
FROM debian

RUN apt update -y

RUN apt install -y python3

RUN apt install python3-emoji

COPY app.py /bin/app.py

ENTRYPOINT ["python3", "/bin/app.py"]
```


🌞 Lancez les deux conteneurs avec docker compose

docker compose up -d

🌞 Vérifier que les deux conteneurs tournent
```
[noah@B2Tp1Docker compose_test]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED             STATUS             PORTS
                       NAMES
06685eb71cde   debian    "sleep 9999"             48 seconds ago      Up 46 seconds
                       compose_test-conteneur_nul-1
455fe40f3992   debian    "sleep 9999"             48 seconds ago      Up 46 seconds
                       compose_test-conteneur_flopesque-1
33a25018c367   nginx     "/docker-entrypoint.…"   About an hour ago   Up About an hour   80/tcp, 0.0.0.0:9999->8080/tcp, [::]:9999->8080/tcp   focused_greider
[noah@B2Tp1Docker compose_test]$
```

🌞 Pop un shell dans le conteneur conteneur_nul
```
root@06685eb71cde:/# ping conteneur_flopesque
PING conteneur_flopesque (172.18.0.3) 56(84) bytes of data.
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=1 ttl=64 time=0.228 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=2 ttl=64 time=0.171 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=3 ttl=64 time=0.109 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=4 ttl=64 time=0.088 ms
```