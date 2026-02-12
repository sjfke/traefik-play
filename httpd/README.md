# Nginix Static WebServer Notes

Build and deploy a static web-server using `docker`, `docker compose` and `podman`

## References

* [Deploying NGINX and NGINX Plus on Docker](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/)
* [Setting Up Nginx with Self-Signed HTTPS in Docker Compose](https://ecostack.dev/posts/nginx-self-signed-https-docker-compose/)
* [The Powerhouse Guide to the Nginx Include Directive](https://thelinuxcode.com/nginx-include/)
* [docker compose](https://docs.docker.com/reference/cli/docker/compose/)
* [docker compose build](https://docs.docker.com/reference/cli/docker/compose/build/) - Build or rebuild services
* [How to Use Docker Cp to Copy Files Between Host and Containers](https://www.howtogeek.com/devops/how-to-use-docker-cp-to-copy-files-between-host-and-containers/)
* [podman build](https://docs.podman.io/en/latest/markdown/podman-build.1.html)
* [podman play kube](https://docs.podman.io/en/latest/markdown/podman-kube-play.1.html)
* [How to use NGINX Variables + Reference List](https://statuslist.app/nginx/variables/)
* [Regular Expression Cheat Sheet - PCRE](https://github.com/niklongstone/regular-expression-cheat-sheet)
* [Convert IPv4 to IPv6](https://dnschecker.org/ipv4-to-ipv6.php)
* [RFC-1918](https://www.rfc-editor.org/rfc/rfc1918)

## Docker

```shell
# define variables
PS C:\Users\sjfke> $name = "crazy-frog"
PS C:\Users\sjfke> $container = "crazy-frog"
PS C:\Users\sjfke> $image = "localhost/nginx-test"

# build image
PS C:\Users\sjfke> docker build --tag $image --no-cache -f .\Dockerfile $PWD
PS C:\Users\sjfke> docker image ls $image

# run, test, delete container
PS C:\Users\sjfke> docker run --name $name -p 8080:80 -d $image
PS C:\Users\sjfke> docker exec -it $container bash
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> docker rm --force $name

# development, test (wash repeat cycle)
PS C:\Users\sjfke> docker build --tag $image --no-cache -f .\Dockerfile $PWD
PS C:\Users\sjfke> docker run --name $name -p 8080:80 -d $image
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> docker rm --force $name
```

## Docker Compose

```shell
# define variables
PS C:\Users\sjfke> $project = "enginx"

# build image
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml build

# run, test, delete container
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml up -d
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> $container = docker ps --format json | jq '.Names' # only enginx project running 
PS C:\Users\sjfke> $container = docker ps --format json | jq 'select(.Image|test(\"^enginx.\")) | .Names'
PS C:\Users\sjfke> docker exec -it $container bash
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml down

# development, test (wash repeat cycle)
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml build
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml up -d
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> docker compose -p $project -f .\compose.yaml down
```

## Podman

```shell
# define variables
PS C:\Users\sjfke> $name = "crazy-frog"
PS C:\Users\sjfke> $image = "localhost/nginx-test"

# build image
PS C:\Users\sjfke> podman build --tag $image --no-cache --squash -f .\Dockerfile
PS C:\Users\sjfke> podman image ls $image

# run, test, delete container
PS C:\Users\sjfke> podman run --name $name -p 8080:80 -d $image
PS C:\Users\sjfke> podman exec -it $name bash
PS C:\Users\sjfke> podman kube generate $name -f .\nginx-pod.yaml # generate pod manifest
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> podman rm --force $name

# run, test, delete container using podman play kube
PS C:\Users\sjfke> podman play kube --start .\nginx-pod.yaml
PS C:\Users\sjfke> $container = "$name-pod-$name"
PS C:\Users\sjfke> podman exec -it $container bash
PS C:\Users\sjfke> start http://localhost:8080
PS C:\Users\sjfke> podman play kube --down .\nginx-pod.yaml

# development, test (wash repeat cycle)
PS C:\Users\sjfke> podman build --tag $image --no-cache --squash -f .\Dockerfile
PS C:\Users\sjfke> podman play kube --replace .\nginx-pod.yaml
PS C:\Users\sjfke> start http://localhost:8080
```

## ``jq`` Installation and Usage

```shell
# Install 'jq'
PS C:\Users\sjfke> winget install jqlang.jq # Windows
$ sudo dnf install jq                       # Fedora
$ brew install jq                           # MacOS
```

Usage see [jq Manual (development version)](https://jqlang.github.io/jq/manual/)

## Troubleshooting

```shell
PS C:\Users\sjfke> docker exec -it $container bash
PS C:\Users\sjfke> podman exec -it $container bash

# stop, start etc
$ nginx -s stop   # fast shutdown
$ nginx -s quit   # graceful shutdown
$ nginx -s reload # reloading the configuration file
$ nginx -s reopen # reopening the log files

$ nginx -v        # version
nginx version: nginx/1.25.3

$ nginx -t        # configuration test
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

root@crazy-frog-pod:/# ls -alr /usr/share/nginx/web/
root@crazy-frog-pod:/# ls -al /var/log/nginx/
total 8
drwxr-xr-x 2 root root 4096 Apr 10 02:54 .
drwxr-xr-x 1 root root 4096 Apr 10 02:54 ..
lrwxrwxrwx 1 root root   11 Apr 10 02:54 access.log -> /dev/stdout
lrwxrwxrwx 1 root root   11 Apr 10 02:54 error.log -> /dev/stderr
```
