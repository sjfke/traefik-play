# traefik-play

Sandbox for Traefik testing using a container, docker and podman 

## Traefik

* [traefik - Docker Official Image](https://hub.docker.com/_/traefik)


## Revers Proxy Example

```yaml
services:
  traefik:
    image: traefik:v3.6.7
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--entrypoints.web.address=:80"
    ports:
      - "80:80"
      - "8080:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

  whoami:
    image: traefik/whoami
    labels:
      - "traefik.http.routers.whoami.rule=Host(`whoami.localhost`)"

  httpd:
    build: httpd
    labels:
      - "traefik.http.routers.httpd.rule=Host(`httpd.localhost`)"
```

> NOTE: ``traefik`` > ``volumes`` is required even on ``Windows``

To start and test.

```console
PS1> docker compose up -d
PS1> start http://localhost:8080/dashboard/
PS1> start http://whoami.localhost/
PS1> curl.exe http://whoami.localhost
PS1> start http://whoami.localhost/
PS1> docker compose down # --remove-orphans # if you change compose.yaml 
```

To build the Docker images

```console
PS1> docker compose build httpd
PS1> docker compose build lighttpd
```

## Web Servers

### ``httpd`` the orignal **HTTP** server

* [httpd - Official Docker Image](https://hub.docker.com/_/httpd)
* [Apache HTTP Server Version 2.4 Documentation](https://httpd.apache.org/docs/2.4/)

### ``lighttpd`` a high-performance **HTTP** server

* [lighttpd - Docker Image](https://hub.docker.com/r/sebp/lighttpd)
* [lighttpd wiki and documentation](https://www.lighttpd.net/)
* [Installing and configuring lighttpd webserver – HOWTO](https://www.cyberciti.biz/tips/installing-and-configuring-lighttpd-webserver-howto.html)
* [Lighttpd Web Server Cheatsheet](https://cheatsheetshero.com/user/all/505-lighttpd-web-server-cheatsheet.pdf)
* [Docker Library - httpd](https://github.com/docker-library/httpd)
* [Production Web server: Lighttpd](https://wiki.alpinelinux.org/wiki/Production_Web_server:_Lighttpd#Lighttpd_Advanced_security)

### ``nginx`` is a deprecated high-performance **HTTP** server

* [nginx - Official Docker Image](https://hub.docker.com/_/nginx)
