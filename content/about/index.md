---
title: "About"
---

## Intro

I'm **tw1zr**, a dedicated **GNU/Linux** sysadmin, DevOps Engineer and free software advocate. My real name is George, well met.

I navigate the inner depths of servers from the ominous black boxes known as terminal emulators.

## Software and workflow

I _exclusively_ use **GNU/Linux** on every device. My desktop and laptop run [Arch Linux](https://archlinux.org) while my servers are powered by [Ubuntu](https://ubuntu.com), usually inside a [Proxmox](https://proxmox.com) hypervisor. I also run a [TrueNAS](https://truenas.com) file server.

I'm a massive **vim/neovim** enthusiast, I customise 99% of my computer interactions with **vim**-like keybindings and rely heavily on the command line for most tasks.

Here's my essential toolkit:

- **Window Manager:** [awesomeWM](https://github.com/awesomeWM/awesome)
- **Application Launcher:** [rofi](https://github.com/davatorium/rofi)
- **Terminal Emulator:** [alacritty](https://github.com/alacritty/alacritty)
- **Text Editor:** [neovim](https://github.com/neovim/neovim)
- **File Manager:** [yazi](https://github.com/sxyazi/yazi)
- **Music Player:** [mpd](https://github.com/MusicPlayerDaemon/MPD) + [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)
- **Video Player:** [mpv](https://github.com/mpv-player/mpv)
- **Image Viewer:** [nsxiv](https://codeberg.org/nsxiv/nsxiv)
- **Password Manager:** [password-store](https://git.zx2c4.com/password-store) & [Bitwarden](https://bitwarden.com)
- **Web Browsers:** [Firefox](https://www.mozilla.org/en-GB/firefox) & [LibreWolf](https://librewolf.net)

These are my primary tools, though my toolkit is always expanding.

### Gallery

Here are a few screenshots showcasing my setup during various activities:

{{< gallery >}}
  <img src="01.webp" class="grid-w33" />
  <img src="02.webp" class="grid-w33" />
  <img src="03.webp" class="grid-w33" />
  <img src="04.webp" class="grid-w33" />
  <img src="05.webp" class="grid-w33" />
  <img src="06.webp" class="grid-w33" />
  <img src="07.webp" class="grid-w33" />
  <img src="08.webp" class="grid-w33" />
{{< /gallery >}}

I prefer the command line for its efficiency and precision. However, for tasks that demand graphical interfaces, like photo or video editing, I opt for tools like [GIMP](https://gimp.org), [OpenShot](https://openshot.org), [ImageMagick](https://imagemagick.org), and [FFmpeg](https://ffmpeg.org).

## Technical proficiencies

Check out my [Sysadmin Playground](/posts/sysadmin-playground01-intro) series for in-depth deployments. Here's a snapshot of my skill set:

### Systems & infrastructure

- **GNU/Linux:** Expertise in various distributions, deeply familiar with system internals.
- **Kubernetes:** Orchestrating containerised applications for scalable deployments.
- **GitOps with [Flux](https://fluxcd.io) and [ArgoCD](https://argo-cd.readthedocs.io):** Implementing declarative infrastructure and continuous delivery for Kubernetes.
- **Infrastructure as code:** [Terraform](https://www.terraform.io) for provisioning, [Ansible](https://ansible.com) for configuration management and orchestration.
- **Containerisation:** [Docker](https://docker.com) for building and managing containers.
- **Web hosting:** [nginx](https://www.nginx.com) and [Apache](https://apache.org) for serving web applications.
- **Ingress controller & reverse proxy:** [Traefik](https://traefik.io) for dynamic routing and load balancing.
- **Static site generation:** [Hugo](https://gohugo.io) for building fast, static websites.
- **CI/CD:** [Github Actions](https://github.com/features/actions) and [CircleCI](https://circleci.com) for continuous integration and deployment pipelines.
- **Monitoring & logging:** [Nagios](https://nagios.com), [Checkmk](https://checkmk.com), [Prometheus](https://prometheus.io), [Grafana](https://grafana.com), and [Datadog](https://www.datadoghq.com) for comprehensive infrastructure and application monitoring.
- **Version control:** Managing code and infrastructure with [Git](https://git-scm.com).

### Cloud services

- **AWS expertise:** Proficient with services like ECS, EKS, EC2, S3, RDS, Lambda and others.

I frankly prefer hosting my services on my own infrastructure, but AWS is widely used in enterprise. I interact with it daily for work.

### Networking

- **In-Depth networking knowledge:** Comprehensive understanding of network protocols, security, and infrastructure design.

From the OSI model, to VLANs, subnetting and everything in between. I have created, configured and managed large and complex network systems.

### Programming & scripting

- **Languages:** Proficient in Go, PHP, Python, and bash for automation and development.

While actual programming is admittedly not my forte, I'm capable of doing it to a competent degree.

### Self-hosted services

For years, I've been self-hosting every service possible on my infrastructure. Learn more in my [Why I self-host everything I can](/posts/why-i-self-host) post.

Most of the following services I host are run inside a Kubernetes cluster in my house, this very website is hosted there as well.

- **VPN servers:** [WireGuard](https://wireguard.com) and [OpenVPN](https://openvpn.com) for secure connections.
- **Overlay networks:** [Netbird](https://netbird.com) for fast and encrypted mesh tunnels.
- **E-mail servers:** [Postfix](http://www.postfix.org) and [Dovecot](https://dovecot.org) with web interfaces like [Roundcube](https://roundcube.net).
- **Identity servers:** [Authelia](http://authelia.com) and [Kanidm](https://kanidm.com) for centralised management of users through OIDC.
- **Media servers:** [Jellyfin](https://jellyfin.org) for streaming media.
- **Cryptocurrency nodes:** Running a [Monero (XMR)](https://getmonero.org) node accessible via **Tor** and **WireGuard**.
- **Git servers:** Utilising [cgit](https://git.zx2c4.com/cgit), [Gitea](https://gitea.io), and [Forgejo](https://forgejo.org) for version control.
- **Chat servers:** [Prosody](https://prosody.im) for **XMPP** and [Synapse](https://github.com/matrix-org/synapse), [Dendrite](https://github.com/matrix-org/dendrite), [Conduit](https://gitlab.com/famedly/conduit) with [Element](https://element.io) for **Matrix**.
- **File servers:** [Nextcloud](https://nextcloud.com), [Seafile](https://seafile.com), and protocols like **FTP**, **SFTP**, **SMB**, and **NFS**.
- **Search engines:** [Searx](https://searx.github.io) for a decentralised meta-search experience.
- **Links aggregator and archival:** [Karakeep](https://karakeep.app) used for saving links about interesting things I find online and want to preserve.
