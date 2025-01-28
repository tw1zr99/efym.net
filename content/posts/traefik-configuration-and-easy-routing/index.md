---
title: "🚦 Traefik configuration and easy routing"
date: 2022-08-20T11:11:59+01:00
tags: ['linux', 'routing']
---
#### My configuration for Traefik with wildcard TLS certificates.
* * *

When you host several Internet-facing services it's of the utmost importance the encrypt the traffic with TLS. It's also very convient to have wildcard certificates and have subdomains redirect traffic to specific ports so that no more than 1 TLS certificate is needed. It's also true that subdomains look better aesthetically than a domain name with ports; exhibit A:
- https://git.efym.net
- https://efym.net:3000

Most people will agree that the first option is more pleasing to the eye, also easier to remember.
Not to mention that you won't have port shortages of any kind, which also makes running multiple instances of the same service at the same time a breeze. I do this a lot while performing tests.

## Domain registrar DNS

The first thing we need to do is point the registrar's DNS records for our domain name to the IP address of the box we're hosting **Traefik** on, I am using [Njalla](https://njal.la) and created these records:

![](/blog/traefik-configuration/1.png)

## Reverse proxy with Traefik

We're going to use what's called a reverse proxy. There are a few options in this department, in the past I've used [nginx](https://nginx.com) and it works well; but my preferred one is [Traefik](https://traefik.io). I've been using it for around 2 years with no problems at all.
Its configuration isn't the easiest, but once it has been properly set up it is—in my opinion—the best reverse proxy when working with containers since it can dynamically route traffic to the correct endpoints by reading labels assigned to **Docker** containers on creation.

We're going to deploy **Traefik** using **docker-compose**. I will assume the reader can install **docker-compose** by themselves.

There are 2 ways to way to write down **Traefik** configuration, we can do it on with config files or by appending lines to the **command** directive in the **docker-compose** file. I personally use config files so that's what I'll show here.

There are also 2 types of configuration instructions: static and dynamic. The static configurations are the ones under the **command** directive or inside a file called `traefik.yml`. Dynamic configurations go under the containers' labels or in any other file besides `traefik.yml`.

Here's a diagram to visualize the topology:

![](/blog/traefik-configuration/2.png)

Let's create some directories to store **Traefik** files:

```
$ mkdir -p /srv/traefik/traefik-{config,ssl,logs}
```

Firstly let's create our **Traefik** static configuration file with this content:

**`$ cat /srv/traefik/traefik-config/traefik.yml`**
```
global:
  checkNewVersion: false
  sendAnonymousUsage: false

log:
  level: INFO
  format: common
  filePath: /var/log/traefik/traefik.log

accesslog:
  format: common
  filePath: /var/log/traefik/access.log

api:
  dashboard: true
  insecure: true

entryPoints:
  web:
    address: :80
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
  websecure:
    address: :443

certificatesResolvers:
  letsencrypt:
    acme:
      email: tw1zr@efym.net
      storage: /ssl-certs/acme.json
      caServer: "https://acme-v02.api.letsencrypt.org/directory"
      dnsChallenge:
        provider: njalla
        delaybeforecheck: 10
        resolvers:
          - "9.9.9.9"

tls:
  options:
    default:
      minVersion: VersionTLS12

providers:
  docker:
    exposedByDefault: false
  file:
    directory: /etc/traefik
    watch: true
```

This static configuration file defines:
* The log format and storage
* Forced **http** to **https** redirection
* Minimum TLS version accepted (here set to TLSv1.2)
* Directory to watch for dynamic config files (set to `/etc/traefik`)
* TLS certificate resolver
We're going to use [Let's Encrypt](https://letsencrypt.org) through a DNS challenge to obtain our wildcard certificate. It will be stored in ACME format in the `/ssl-certs/acme.json` file as defined.
Also note that I set the **provider** directive to **njalla**, that's because [Njalla](https://njal.la) is the domain registrar that I use. But this can be changed if you use another registrar. [Traefik has very good documentation on this](https://doc.traefik.io/traefik/https/acme/).

The **Njalla** provider needs one environment variables to be able to complete the DNS challenge, we will store this variables in a file called `traefik-env` and later define it in our `docker-compose.yml` file.

**`$ cat /srv/traefik/traefik-env`**
```
NJALLA_TOKEN=xxxxxxxxxxxxxxxxxxxx
```

(My real token has been redacted for obvious reasons.)

We will also create a dynamic config file to define middlewares. In this file we will define a basic auth middleware that will be used to authenticate to the **Traefik** dashboard.

We can use `htpasswd` to generate the basic auth credentials:

```
$ htpasswd -nbB tw1zr xxxxx
```

(My real password has been replaced for **`xxxxx`**)

**`$ cat /srv/traefik/traefik-config/middlewares.yml`**
```
http:
  middlewares:
    traefik-auth:
      basicAuth:
        users:
          - "tw1zr:$2y$05$H41PI9inzmhZcEOkUuTR7O74/7ADxZ/Z7.awyAhXB/lR3AHdNiPAu"
```

Now inside the base `/srv/traefik` directory our `docker-compose.yml` file should look like this:

**`$ cat /srv/traefik/docker-compose.yml`**
```
---
version: "3.7"
services:

  traefik:
    container_name: "traefik"
    hostname: "traefik"
    image: "traefik:latest"
    restart: "unless-stopped"
    ports:
      - "80:80"
      - "443:443"
    env_file:
      - "./traefik-env"
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "./traefik-config:/etc/traefik"
      - "./traefik-ssl:/ssl-certs"
      - "./traefik-logs:/var/log/traefik"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.tls.certresolver=letsencrypt"
      - "traefik.http.routers.traefik.tls.domains[0].main=efym.net"
      - "traefik.http.routers.traefik.tls.domains[0].sans=*.efym.net"

      - "traefik.http.routers.traefik.tls=true"
      - "traefik.http.routers.traefik.service=api@internal"
      - "traefik.http.routers.traefik.middlewares=traefik-auth@file"
      - "traefik.http.routers.traefik.rule=Host(`traefik.efym.net`)"
    networks:
      - "rawr"

networks:
  rawr:
    name: "rawr"
    ipam:
      driver: "default"
      config:
        - subnet: "10.3.0.0/24"
```

With this file we're telling **Docker** to map ports 80 and 443 (**http** and **https** respectively) to the same ports in the container. Those ports are **HTTP** standards, now when any **HTTP** traffic hits the host machine it will be redirected to the **Traefik** container; then **Traefik** will forward that traffic to whatever endpoint we assign it using **Docker** labels.

The **env_file** directive maps the `traefik-env` file we created with enviroment variables so the container can use them when created.

We're also mounting a few volumes, the reasoning is as follows:
* **/etc/localtime**: TLS certificates are time-sensitive, it's important to have the correct time inside the container that **Traefik** is running in.
* **/var/run/docker.sock**: Allows **Traefik** to monitor the **Docker** socket and dynamically configure itself based on container labels.
* **./traefik-config**: Persistance of static and dynamic config files
* **./traefik-ssl**: Persistance of TLS certificates
* **./traefik-logs**: Persistance of logs generated by **Traefik**

Now about the labels:
* Enable **Traefik** for this container as well as TLS
* We assign the certificate resolver's name that was defined in the static config file
* Specify the domain name and all its subdomains (with `*`, which stands for wildcard) that the certificate is going to be valid for
* Enable the **Traefik** web dashboard
* Enable the middleware we created above for basic auth
* Lastly we define the subdomain we want to root to this container (to the dashboard in this case)
(There's no reason to define which port it gets routed to in this case, the dashboard is an internal **Traefik** thing

At the end of the file we also specify a network named **rawr**. Every container that will be routed to by **Traefik** needs to share a network with it, the name of the network is arbitrary.

All that's left to do now is change into `/srv/traefik` directory and start the container with this command:

```
$ docker-compose up -d
```

Wait a minute or so for **Traefik** to spin up and acquire the certificate, then if we open **https://traefik.efym.net** we should get a basic auth prompt, after entering the correct credentials we should see the **Traefik** dashboard:

![](/blog/traefik-configuration/3.png)

My dashboard shows many more routers and services than a brand new install would because I have more stuff running.
