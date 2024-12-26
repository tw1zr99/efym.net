---
title: "about"
---
## Intro

I'm **tw1zr**, a **GNU/Linux** sysadmin and free software advocate. Also a master of irony.

My real name is George and I currently work as a DevOps Engineer for a software company in Brighton, UK.

I do Linux stuff from the scary black boxes a.k.a terminal emulators.

## Software and workflow

I _exclusively_ use **GNU/Linux** on every single device. My desktop and laptop currently run [Arch Linux](https://archlinux.org) and my servers run [Debian](https://debian.org).

I'm also a massive **vim** user (well, actually **neovim**, but it's pretty much the same thing). This means I tailor 99% of my interactions with my computers to follow **vim**-like keybinds as well as using the command-line for the better part of my activities.

[awesomeWM](https://github.com/awesomeWM/awesome) is my window manager

[rofi](https://github.com/davatorium/rofi) is my application launcher

[alacritty](https://github.com/alacritty/alacritty) is my terminal emulator

[neovim](https://github.com/neovim/neovim) is my text editor

[yazi](https://github.com/sxyazi/yazi) is my file manager

[mpd](https://github.com/MusicPlayerDaemon/MPD)+[ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) are what I use to play my music

[mpv](https://github.com/mpv-player/mpv) is my video player

[nsxiv](https://codeberg.org/nsxiv/nsxiv) is my image viewer

[password-store](https://git.zx2c4.com/password-store) is my password manager

[qutebrowser](https://github.com/qutebrowser/qutebrowser) is my main web browser

[librewolf](https://librewolf-community.gitlab.io) is my secondary web browser

These are the main programs I use on my desktop/laptop, but they're far from the only ones, of course.

Here are a few screenshots showing what my computer looks like during various activities:

{{< about-computer-images >}}

Like I mentioned before I try to use the command-line for everything I can and the reason for this is very simple: it's generally the most efficient way of getting things done. Though I will admit my 10 year old self was fascinated by the hollywood-esque appeal of fast paced stuff popping on a computer screen, this is not the case anymore. I've interacted with computers in many ways and using the command-line is just the most precise way I've found.
However, there are exceptions to the previous sentences, for instance things that require direct interaction with graphic media (like photo/video editing) and even web-browsing (because the modern web is a bloated and cumbersome mess) are better accomplished with a graphical user interface; so when I have to edit a picture I use [GIMP](https://gimp.org) and in the rare cases I have to edit a video I use [OpenShot](https://openshot.org).
But even for these tasks if the edits I need to make aren't too complex or need to be scripted and ran across many files I'll opt to use [ImageMagick](https://imagemagick.org) for photo editing and [FFmpeg](https://ffmpeg.org) for video editing.

## Technical proficiencies

Check out my [Sysadmin Playground](/blog/sysadmin-playground01-intro) series for deployments of some of the stuff I'm familiar with. But here goes a bullet-point list anyway:

* Linux, Linux, Linux. I breathe **GNU/Linux** every day of my life. I'm extremely familiar with its inner workings.
* Infrastructure deployment with [Terraform](https://www.terraform.io)
* Configuration management and orchestration with [Ansible](https://ansible.com)
* Almost all of AWS (clustering, buckets, RDS, role-based permissions with IAM; think of it and I've used it)
* Web hosting with [nginx](https://www.nginx.com) and [apache](https://apache.org)
* Static site generation with [Hugo](https://gohugo.io)
* Proxying services with [Traefik](https://traefik.io)
* Containerization with [Docker](https://docker.com)
* Infrastructure monitoring with [Nagios](https://nagios.com) and [Checkmk](https://checkmk.com)
* Metrics monitoring with [Prometheus](https://prometheus.io) and [Grafana](https://grafana.com)
* Scripting and automation with bash

I'm more network and infrastructure minded, but I can program in a couple of languages:
* bash (big fan)
* PHP
* Python
* Golang

I have for years been hosting every single service I use which is possible to run on my own infrastructure. (I have a blog post explaining most of my reasoning here: [Why I self-host everything I can](/blog/why-i-self-host)). These services include, but are not limited to:

* **VPN** server using [WireGuard](https://wireguard.com) and [OpenVPN](https://openvpn.com)
* **E-mail** server based on [Postfix](http://www.postfix.org) and [Dovecot](https://dovecot.org) with or without web fron-ends like [Roundcube](https://roundcube.net)
* Media server with [Jellyfin](https://jellyfin.org)
* [Monero (XMR)](https://getmonero.org) node accessible through **Tor** and my **WireGuard** network
* **Git** server with plain **CGI** ([cgit](https://git.zx2c4.com/cgit)) or more complex with [Gitea](https://gitea.io)/[Forgejo](https://forgejo.org)
* **XMPP** chat server using [Prosody](https://prosody.im)
* **Matrix** chat server using [Synapse](https://github.com/matrix-org/synapse), [Dendrite](https://github.com/matrix-org/dendrite) and [Conduit](https://gitlab.com/famedly/conduit) with [Element](https://element.io) as a web front-end
* File servers with web-based front-ends like [Nextcloud](https://nextcloud.com) and [Seafile](https://seafile.com)
* File servers at the file system level with protocols like **FTP**, **SFTP**, **SMB** and **NFS**
* Meta-search engine using [Searx](https://searx.github.io/searx)
