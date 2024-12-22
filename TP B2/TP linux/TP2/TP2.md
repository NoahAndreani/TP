 
# I. Good practices
 
 🌞 Limiter l'accès aux ressources
```
memory: 1024M
cpus: '1'
```

🌞 No root && 🌞 Gestion des droits du volume qui contient le code
docker run -s ou 

```
FROM nginx

RUN apt update -y

RUN chown -R nginx:nginx /etc/nginx

RUN chown -R nginx:nginx /var/cache/nginx

RUN touch /var/run/nginx.pid

RUN chown nginx:nginx /var/run/nginx.pid

USER nginx
```

🌞 Gestion des capabilities sur le conteneur NGINX
```
impossible : windows
```

🌞 Mode read-only

docker run avec l'option  --read-only