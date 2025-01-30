---
title: "Sysadmin Playground Part 05 | Passwords and Ansible Vault 🔒"
date: 2021-08-29T04:13:05+01:00
showDate: true
tags: ['sysadmin', 'linux']
series: ['Sysadmin Playground']
series_order: 5
---
#### Generating hardened passwords and encrypting them with Ansible Vault.
* * *

## Hardening Passwords

Up until now we've been storing the passwords passed into **Docker** containers through environment variables in plain text right in the roles' tasks; not to mention intentionally using very weak passwords.
There are many solutions to both these points, and presently I'll show one of the simpler ones.

We're going to use a variables file filled with all the passwords stored each in its respective variable; then we're going to encrypt that file with a utility provided by **Ansible** called **Vault**.

We will also use a utility to generate strong passwords. There are plenty of options for this, many websites on the Internet offer this service as well as most full-blown password managers. Here're a couple options to consider:

* [pass](https://www.passwordstore.org) (by far my prefered choice, this is what I use for my personal passwords)
* [Bitwarden](https://bitwarden.com)
* [KeePass](https://keepass.info)
* [Secure Password Generator](https://passwordsgenerator.net) (online website)

For the purposes of this write-up I'm going to go with the last option seeing as it's the simplest out of them all. Bear in mind I do not recommend using Javascript code found on some website to generate passwords for a production environment, or even for personal use. Even if they claim the code only runs client-side and is never sent accross the Internet.

Create a directory called `group_vars` inside the directory holding all the **Ansible** files. Inside of it let's create a file called `all.yml`, this structure means every **Ansible** group will have access to the variables we store in this file.

Use whatever method you chose to generate passwords and store them in this file in YAML format, mine looks like this for now:

**`$ cat all.yml`**
```
# openldap
ldap_host1: "cutxn.pygrn.lab"
ldap_host1_short: "cutxn"
ldap_host2: "cutxo.pygrn.lab"
ldap_host2_short: "cutxo"
ldap_webui_host: "doris.pygrn.lab"
ldap_webui_host_short: "doris"

ldap_admin_pass: "2hJmj7TFrz"
ldap_config_pass: "bTu5njqLLd"
ldap_readonly_pass: "Drq8nNEG6C"

ldap_tw1zr_pass: "fu9F4yzKH3"
ldap_guest1_pass: "Ln9CQMsDZA"
ldap_guest2_pass: "bKwDKP6z57"
```

Now here's an excerpt of the `openldap` role, the task which defines the **OpenLDAP** **Docker** container with some of these variables put into place replacing plaintext passwords:

**`$ tail -n32 roles/openldap/tasks/main.yml`**
```
- name: OpenLDAP container
  when: "ansible_hostname == ldap_host1_short or ansible_hostname == ldap_host2_short"
  docker_container:
    name: '{{ ansible_hostname }}-openldap'
    restart_policy: "always"
    image: 'osixia/openldap:latest'
    hostname: '{{ ansible_hostname }}.pygrn.lab'
    published_ports:
      - "389:389"
    env:
      LDAP_BASE_DN: "dc=pygrn,dc=lab"
      LDAP_ORGANISATION: "Pygrn Lab"
      LDAP_DOMAIN: "pygrn.lab"
      LDAP_ADMIN_PASSWORD: "{{ ldap_admin_pass }}"
      LDAP_CONFIG_PASSWORD: "{{ ldap_config_pass }}"
      LDAP_READONLY_USER: "true"
      LDAP_READONLY_USER_USERNAME: "readonly"
      LDAP_READONLY_USER_PASSWORD: "{{ ldap_readonly_pass }}"
      LDAP_TLS: "true"
      LDAP_TLS_VERIFY_CLIENT: "try"
      LDAP_TLS_CA_CRT_FILENAME: "pygrn.lab-CA.crt"
      LDAP_TLS_CRT_FILENAME: "openldap.crt"
      LDAP_TLS_KEY_FILENAME: "openldap.key"
      LDAP_REPLICATION: "true"
      LDAP_REPLICATION_HOSTS: "#PYTHON2BASH:['ldap://{{ ldap_host1 }}','ldap://{{ ldap_host2 }}']"
    volumes:
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
      - "/srv/openldap/ldap:/var/lib/ldap"
      - "/srv/openldap/slapd.d:/etc/ldap/slapd.d"
      - "/srv/openldap/ldifs:/etc/ldap/ldifs"
      - "/srv/openldap/certs:/container/service/slapd/assets/certs"
```

**IMPORTANT:** I'll replace everything I can regarding hosts and passwords in every role of the playbook to variables within this file, so next time you see references to these variables in future chapters you'll know where their value is stored.

## Encrypting files with Ansible Vault

The next thing to do is to encrypt the `group_vars/all.yml` file with **ansible-vault**:

```
$ ansible-vault encrypt group_vars/all.yml
```

That command will ask you to enter a password to encrypt the file, this password will need to be entered everytime we run the playbook so that **Ansible** can decrypt the file, read its contents and expand the variables within our roles.

We can avoid having to type the password everytime we want to encrypt a new file or run the playbook by storing the password in plain text in a file called `.vaultpass` then defining it within the **Ansible** configuration file `ansible.cfg` like so:

```
$ echo -n nyaa > .vaultpass && echo vault_password_file = ./.vaultpass >> ansible.cfg
```

Yes, I have again used '**nyaa**' as a password, this time even as a master for this pseudo password manager we're using for our playbook. I will again reiterate that one should never use such a simplistic password for anything other than test environments like this one; and also storing a password in plain text inside the directory which holds all the files encrypted by it has its own set of drawbacks, but explaining that is out of scope for now.

Let's also encrypt every file inside the `files` directory with **ansible-vault**, some of them contain plain text passwords and there's no downside to encrypting them too
Here's a simple one-liner script that will iterate through every file inside the `files` directory and encrypt them, excluding those inside the `CA` directory, which are our certificates:

```
$ for f in $(find files/ -type f -not -path "files/CA/*"); do ansible-vault encrypt $f; done
```

## Updating LDAP server with new passwords

Next thing we need to do is update the users' passwords in our **LDAP** server, we could authenticate as **cn=admin** to change the passwords, which is especially useful if we do not know what the current password is, but since every user has read/write access to its own password, and we know what it is, we can bind as the user to change it:

```
$ ldappasswd -ZZ -H ldap://cutxn.pygrn.lab -D cn=tw1zr,ou=Users,dc=pygrn,dc=lab -w nyaa -a nyaa -s fu9F4yzKH3
```

```
$ ldappasswd -ZZ -H ldap://cutxn.pygrn.lab -D cn=guest1,ou=Users,dc=pygrn,dc=lab -w yugi -a yugi -s Ln9CQMsDZA
```

```
$ ldappasswd -ZZ -H ldap://cutxn.pygrn.lab -D cn=guest2,ou=Users,dc=pygrn,dc=lab -w yigo -a yigo -s bKwDKP6z57
```

The process of changing **cn=admin,dc=pygrn,dc=lab** and **cn=admin,cn=config** is more involved, we're going to do it from inside the **OpenLDAP** container, so first **ssh** into either **cutxn** or **cutxo** and run an interactive shell inside the container like this:

```
$ ssh -i /path/to/ssh/key root@192.168.122.3
```

```
$ docker exec -it cutxn-openldap bash
```

Once we have a shell on the container let's do an **ldapsearch** to display the dn we need to change and the **RootDN** hashed password, as well as using **tee** to save the output to an ldif file:

```
$ ldapsearch -LLL -ZZ -H ldap://cutxn.pygrn.lab -D cn=admin,cn=config -w nyaa -b cn=config olcRootDN=cn=admin,dc=pygrn,dc=lab dn olcRootDN olcRootPW | tee /tmp/rootnew.ldif
```

Now use **slappasswd** to generate a new hashed password and append it to the end of the file we just created, this command will prompt you to enter a password an then confirm it:

```
$ slappasswd -h {SSHA} >> /tmp/rootnew.ldif
```

Now modify the file to look like this, where the value of olcRootPW is the new one we just generated, meaning that we delete the one which was there previously and replace it with the one at the bottom of the file which we appended there:

**`$ cat /tmp/rootnew.ldif`**
```
dn: olcDatabase={1}mdb,cn=config
changeType: modify
replace: olcRootPW
olcRootPW: {SSHA}BLjBfAC4CLugKZ/eUj8HIvhUwEEJqTI2
```

Apply the ldif file to modify the password of **cn=admin,cn=config**:

```
$ ldapmodify -ZZ -H ldap://cutxn.pygrn.lab -D cn=admin,cn=config -w nyaa -f /tmp/rootnew.ldif
```

This will make both **cn=admin,dc=pygrn,dc=lab** and **cn=admin,cn=config** have the same password, you can also just re-run the Ansible playbook with the new variables in place to modify these entries, after all that is the advantage of reproducible infrastructure.

Modify the `libnss-ldap.secret` and `pam_ldap.secret` files too with the new **cn=admin** password:

```
$ echo -n '2hJmj7TFrz' | tee pam_ldap.secret > libnss-ldap.secret
```

## Cloud init root password

Lastly we will change the root password of the boxes by modifying its definition in the **cloud-init** files within the **Terraform** directory. Change to that directory (I called mine **cloud_inits**) and issue this command:

```
$ sed -i 's/nyaa/2hJmj7TFrz/g' *
```

Next time the boxes are rebooted the root user will have the same password as our **LDAP** **cn=admin**.
