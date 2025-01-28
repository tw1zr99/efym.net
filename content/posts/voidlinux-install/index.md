---
title: "Voidlinux Install"
date: 2021-07-01T19:09:10+01:00
tags: ['linux']
---
#### Notes on my Void Linux setup.
* * *

{{< alert icon="fire" cardColor="#e63946" iconColor="#1d3557" textColor="#f1faee" >}}
**Update:** I'm no longer using Void Linux, my desktop and laptop computers run Arch.
{{< /alert >}}

Recently I switched the Linux distribution I use on my desktop and laptop to Void from Arch. I had used Void before but switched away from it because there were some packages I use missing from their repositories. That point hasn't really changed much, but I thought I'd give it another go anyway.

{{< alert icon=" " >}}
**Note:** There's a guide on the [Void Linux docs](https://docs.voidlinux.org/installation/guides/fde.html) page about an installation with encrypted boot, I personally choose to leave my boot partition unencrypted because I think it's largely useless to do it; and also because the Grub bootloader doesn't support luks2 scheme so you're forced to use luks1 which I'm uncomfortable with.
{{< /alert >}}

I use an ISO keyboard with a UK layout, I'm also a heavy vim user so a lot of of the decisions I make are personal preference, YMMV. Here's how I set it up:

Firstly boot the live ISO image into the box you're doing the installation on (won't cover that since it's fairly obvious) and login as root.

## Preparation

Sets TERM variable (especially useful if doing this through ssh) and vim mode for the shell

```
root@void-live:~ # export TERM=xterm-256color
```

```
root@void-live:~ # alias v=nvim
```

```
root@void-live:~ # set -o vi
```

```
root@void-live:~ # bind -m vi-command 'Control-l: clear-screen'
```

```
root@void-live:~ # bind -m vi-insert 'Control-l: clear-screen'
```

Change keycode 58 = Escape to make Caps Lock key act as Escape because it's $currentYear

```
root@void-live:~ # v /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz
```

```
root@void-live:~ # loadkeys uk
```

Ping any website to check internet connection

```
root@void-live:~ # ping gnu.org
```

Check whether you're booted into UEFI or BIOS

```
root@void-live:~ # ls /sys/firmware/efi/efivars
```

## Partitions

Create 2 partitions on your drive (first one is just for /boot so I always make it 1GB, which is plenty). Encrypt the second one with LUKS

```
root@void-live:~ # fdisk /dev/sda
```

```
root@void-live:~ # cryptsetup luksFormat /dev/sda2
```

```
root@void-live:~ # cryptsetup luksOpen /dev/sda2 [NAMEOFcrypt]
```

LVM setup

```
root@void-live:~ # pvcreate /dev/mapper/[NAMEOFcrypt]
```

```
root@void-live:~ # vgcreate [NAMEOF-vg] /dev/mapper/[NAMEOFcrypt]
```

```
root@void-live:~ # lvcreate --name root -L 100G [NAMEOF-vg]
```

```
root@void-live:~ # lvcreate --name home -l 100%FREE [NAMEOF-vg]
```

Format the newly created partitions

```
root@void-live:~ # mkfs.vfat -F32 /dev/sda1
```

```
root@void-live:~ # mkfs.ext4 -L root /dev/[NAMEOF-vg]/root
```

```
root@void-live:~ # mkfs.ext4 -L home /dev/[NAMEOF-vg]/home
```

Mount the partitions

```
root@void-live:~ # mount /dev/[NAMEOF-vg]/root /mnt
```

```
root@void-live:~ # mkdir -p /mnt/{home,boot}
```

```
root@void-live:~ # mount /dev/[NAMEOF-vg]/home /mnt/home
```

```
root@void-live:~ # mount /dev/sda1 /mnt/boot
```

Mount dev proc sys and run in bind mode in order to chroot to /mnt

```
root@void-live:~ # for dir in dev proc sys run; do mkdir -p /mnt/$dir; mount --rbind /$dir /mnt/$dir; mount --make-rslave /mnt/$dir; done
```

## System bootstrap and installation

```
root@void-live:~ # xbps-install -Sy -R https://alpha.de.repo.voidlinux.org/current -r /mnt base-system base-devel cryptsetup lvm2 neovim openssh connman connman-ncurses dbus-elogind python3 openntpd grub-x86_64-efi
```

Chroot into `/mnt` and continue installation from there

```
root@void-live:~ # chroot /mnt bash
```

```
chroot # chown root:root /
```

```
chroot # chmod 755 /
```

```
chroot # echo [NAMEOFbox] > /etc/hostname
```

Modify hosts file to reflect new hostname

```
chroot # v /etc/hosts
```

Set your timezone, keyboard (I replace Caps_Lock to act as Escape again by setting keycode 58 = Escape), keymap, and locale

```
chroot # ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
```

```
chroot # v /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz
```

```
chroot # echo "KEYMAP=uk" >> /etc/rc.conf
```

```
chroot # echo "LANG=en_GB.UTF-8" > /etc/locale.conf
```

```
chroot # echo "en_GB.UTF-8 UTF-8" >> /etc/default/libc-locales
```

```
chroot # xbps-reconfigure -f glibc-locales
```

## Users and groups

```
chroot # useradd -m -g wheel [NAMEOFuser]
```

```
chroot # groupadd libvirt
```

```
chroot # usermod -a -G audio,video,libvirt,lp [NAMEOFuser]
```

```
chroot # chown [NAMEOFuser]:wheel -R /home/[NAMEOFuser]
```

```
chroot # chmod 700 /home/[NAMEOFuser]
```

```
chroot # passwd [NAMEOFuser]
```

```
chroot # passwd root
```

## Create a swapfile

```
chroot # dd if=/dev/zero of=/var/swapfile count=8192 bs=1MiB
```

```
chroot # chmod 600 /var/swapfile
```

```
chroot # mkswap /var/swapfile
```

```
chroot # swapon /var/swapfile
```

## Edit your fstab

Use this command to add the UUID of sda1 into the fstab file

```
chroot # blkid -o value -s UUID /dev/sda1 >> /etc/fstab
```

Your fstab should look like this

```
/dev/[NAMEOF-vg]/root       /        ext4      defaults         0       0
/dev/[NAMEOF-vg]/home       /home    ext4      defaults         0       0
UUID=[UUIDOFsda1]           /boot    vfat      defaults         0       0
/var/swapfile               swap     swap      none             0       0
```

## Bootloader

I use grub as my bootloader, feel free to use any alternatives you like here.

Use this command if running UEFI

```
chroot # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void" /dev/sda
```

Use this one if running BIOS

```
chroot # grub-install --bootloader-id="Void" /dev/sda
```

Use this command to add the UUID of the encrypted partition /dev/sda2 into /etc/default/grub

```
chroot # blkid -o value -s UUID /dev/sda2 >> /etc/default/grub
```

Modify `/etc/default/grub` to look like the following (only need to change LINUX_DEFAULT line)

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 rd.auto=1 cryptdevice=UUID=[UUIDOFsda2]"
```

Update grub.cfg

```
chroot # grub-mkconfig -o /boot/grub/grub.cfg
```

## Finalising

```
chroot # rm /var/service/agetty-{tty3,tty4,tty5,tty6}
```

```
chroot # ln -fs /etc/sv/{sshd,dbus,connmand,openntpd} /var/service/
```

```
chroot # echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/sudo-wheel
```

```
chroot # echo "[NAMEOFuser] hard nofile 524288" >> /etc/security/limits.conf
```

Exit chroot, unmount drives and reboot

```
chroot # exit
```

```
root@void-live:~ # umount -R /mn
```

```
root@void-live:~ # reboot
```

Right now you should have a fully functioning Void install, I use an Ansible playbook which sets up my entire graphical environment, dotfiles and other things; maybe I'll publish that soon.
