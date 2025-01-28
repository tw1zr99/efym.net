---
title: "Nighttime Backups 💾"
date: 2020-08-24T14:10:20+01:00
tags: [ 'linux', 'backups', 'bash' ]
---
The system I use to backup config files from all my boxes.

<!--more-->

* * *

When you're like me and try to self-host as many of the services you use as humanly possible, having a reliable backup system is imperative. I have already lost my configs more times than I'd care to admit so I wrote a couple scripts to automate the process.

I run a server in my house which acts as a NAS and a central location to automate various things including backups. From there I run a cronjob which iterates through every single one of my boxes, mounts them on this central server through sshfs and backs up every config file and directory before uploading them to [Backblaze.](https://backblaze.com)

borgbackup+rclone is the best combination I've found to create encrypted backups and upload them to object storage like Backblaze B2.

Before showing you the script I run as a cronjob, let's take a look at another one which takes the name of any (but only one) of your boxes and backs it up individually. I'll be the first one to admit the code inside the case statement is a little janky and repetitive, but it works just fine; feel free to email me suggestions.

~~~
#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "specify a box, and one at a time"
    exit 1
fi

selected_box=$1
case $selected_box in
	"[CENTRAL BOX]") box=[CENTRAL BOX] &&\
		mountpoint -q /mnt/boxes/$box || mount --bind / /mnt/boxes/$box &&\
		export BORG_PASSCOMMAND="cat /etc/borg_keys/[CENTRAL BOX]_key" ;;
	"[ROUTER]") box=[ROUTER] &&\
		mountpoint -q /mnt/boxes/$box || sshfs root@$box:/ /mnt/boxes/$box &&\
		export BORG_PASSCOMMAND="cat /etc/borg_keys/[ROUTER]_key" ;;
	"[BOX 1]") box=[BOX 1] &&\
		mountpoint -q /mnt/boxes/$box || sshfs root@$box:/ /mnt/boxes/$box &&\
		export BORG_PASSCOMMAND="cat /etc/borg_keys/[BOX 1]_key" ;;
	"[LAPTOP]") box=[LAPTOP] &&\
		mountpoint -q /mnt/boxes/$box || sshfs root@$box:/ /mnt/boxes/$box &&\
		export BORG_PASSCOMMAND="cat /etc/borg_keys/[LAPTOP]_key" ;;
	"[VPS 1]") box=[VPS 1] &&\
		mountpoint -q /mnt/boxes/$box || sshfs root@$box:/ /mnt/boxes/$box &&\
		export BORG_PASSCOMMAND="cat /etc/borg_keys/[VPS 1]_key" ;;
	*	) echo "box not valid" && exit 1 ;;
esac

if mountpoint -q /mnt/boxes/$box; then
	borg create -v --stats -p \
	root@[CENTRAL BOX]:/path/to/backups/$box::$(date +%Y-%m-%d_t_%H-%M) \
		/path/to/dir1 \
		/path/to/dir2 \
		/path/to/dir3 \
		--exclude /path/of/excluded/dir1 \
		--exclude /path/of/excluded/dir2 \

	borg prune -v --list root@[CENTRAL BOX]:/path/to/backups/$box \
		--keep-daily=2 \
		--keep-weekly=3 \
		--keep-monthly=5

	umount /mnt/boxes/$box
fi
~~~

One thing worth noting is that I keep the borg repokeys in files at `/etc/borg_keys` which allows me to set `BORG_PASSCOMMAND` as the output of each file in order to not have to input the password which is crucial for it to run as a cronjob

> **Note:** Please make absolutely sure for these files to be owned by root and have 400 ugo permissions.

Now for what is actually in my crontab:
---------------------------------------

~~~
#!/bin/bash

# bail if not [CENTRAL BOX]
if [[ "$(uname -n)" != "[CENTRAL BOX]" ]]; then
  echo "run from [CENTRAL BOX]"
  exit
fi
# bail if not running as root
if [ "$EUID" -ne 0 ]; then
  echo "run as root"
  exit
fi
# bail if borg is already running, maybe previous run didn't finish
if pidof -x borg >/dev/null; then
    echo "backup already running"
    exit
fi

for box in [CENTRAL BOX] [ROUTER] [BOX 1] [LAPTOP] [VPS 1]; do
	echo "################################################"
	echo "################ now doing $box ################"
	echo "################################################"
	if [[ "$box" == "[CENTRAL BOX]" ]]; then
		mountpoint -q /mnt/boxes/$box || mount --bind / /mnt/boxes/[CENTRAL BOX]
	else
		mountpoint -q /mnt/boxes/$box || sshfs root@$box:/ /mnt/boxes/$box
	fi
	if ! mountpoint -q /mnt/boxes/$box; then 
		echo "couldn't mount $box"
	fi
	export BORG_PASSCOMMAND="cat /etc/borg_keys/${box}_key"
	if mountpoint -q /mnt/boxes/$box; then
		borg create -v --stats \
			root@[CENTRAL BOX]:/mnt/drives/oasis/backups/$box::$(date +%Y-%m-%d_t_%H-%M) \
			/mnt/boxes/$box/etc \
			/mnt/boxes/$box/var/www \
			/mnt/boxes/$box/var/lib \
			/mnt/boxes/$box/repos \
			--exclude /mnt/boxes/$box/var/lib/dpkg \
			--exclude /mnt/boxes/$box/var/lib/libvirt \
			--exclude /mnt/boxes/$box/var/lib/apt \

		borg prune -v --list root@[CENTRAL BOX]:/mnt/drives/oasis/backups/$box \
			--keep-daily=2 \
			--keep-weekly=3 \
			--keep-monthly=5

		umount /mnt/boxes/$box
	fi
done

export RCLONE_CONFIG_PASS=$(cat /etc/borg_keys/rclone)

rclone -v sync /mnt/drives/oasis/backups backblaze:tw1zr-backups
~~~

Here I added a couple killswitches at the beginning to make sure borg and rclone don't run at the same time, also to prevent 2 instances of the same script interfering with eachother.

As you may have realised these scripts require for you to define the boxes which will be backed up and also the way I wrote them assumes these boxes are configured in the ssh config file and set up with public key authentication. It is also assumed that the borg repositories are already in place and rclone has been configured with an encrypted config file, which in my case also resides at `/etc/borg_keys`
