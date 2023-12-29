
## **Linux Commands**

<br>

### Basic Commands

|**Command**    | **Description**       |
|---------------|-----------------------|
|ls             |list directory         |
|cd             |change directory       |
|mkdir          |make directory         |
|touch          |create blank file      |
|echo           |write on terminal      |
|cp             |copy                   |
|mv             |move(cut)              |
|rm             |remove file            |
|cat            |list contents of file  |
|tree           |see directory structure|
|man            |check the manual       |

### Important Folders

|**Folder Path**|**Description**        |
|---------------|-----------------------|
|/etc/passwd    |has all users          |
|/etc/group     |has all groups         |
|/etc/shadow    |has user userpasswords |


### Other Commands

**. passwd <user\>** ... *(change the password of user)*

**. adduser <user\>** ... *(add new user)*

**. deluser <user\>** ... *(remove user)*

**. deluser <user\> --remove-home** ... *(removes user & homefolder)*

**. addgroup <group\>** ... *(adds new group)*

**. delgroup <group\>** ... *(removes group)*

**. adduser <user\> <group\>** ... *(adds user to group)*

**. deluser <user\> <group\>** ... *(removes user from group)*
 
**. usermod -g <group\> <user\>** ... *(changes the primary group of user)*

**. id** ... *(shows the groups to which user belongs)*

**. init 0** ... *(shuts down the machine)*

**. init 6** ... *(restarts the machine)*

**. chown** ... *(alters ownership of files)*

**. chown -R <user\> <file\>** ... *(changes owner of folder and all content)*

**. chown <user\>:<group\> <file/folder\>** ... *(changes both owner and group of file)*

**. chgrp** ... *(changes the group owning the file)*

**. chgrp -R <group\> <file\>** ... *(same, and all its content)*

**. chmod 754 <file\>** ... *(changes the permissions of files)*

**. chmod -R 660 <file\>** ... *(alters folder permissions and of all its content)*
 
**. head 5** ... *(shows the firts 5 lines of the file)*

**. tail 12** ... *(shows the last 12 lines of the file)*
 
**. sort** ... *(orders the file)*
 
**. wget <URL\> -O <file\>** ... *(downloads the content of the URL and saves it)*

### Wildcards

|**Wildcard** | **Description**             |
|-------------|-----------------------------|
|\*           |0 or more characters         |
|?            |exactly 1 character          |
|\>           |output redirection (overrite)|
|\>\>         |output redirection (append)  |

<br>

### SSH
---

The [SSH protocol](https://en.wikipedia.org/wiki/Secure_Shell) allows for secure access over a network.

#### Installation and Configuration

**.apt install ssh**

**. vim /etc/ssh/sshd_config** ... * (remember your backups)*


##### sshd_config:

	port 22

	AllowUsers <user\>                    (users that can access the system via SSH)

	DenyUsers <user1\> <user2\>            (users that are forbidden from doing so)

	AllowGroups <group1\> <group2\>        (groups that can access the system via SSH)
 
	DenyGroups <group1\> <group2\>         (groups that are forbidden from doing so)

	PermitRooLogin YES                   (to allow root access via SSH)




**Note:** *do not use **AlloUsers** and **AllowGroups** simultaneously!*

<br>

> **. systemctl restart ssh** ... *(SSH restart, so that configuration changes can take place)*
>
> **. systemctl status ssh** ... *(to check if SSH is working without issues)*
>
> **. journalctl -xe** ... *(error check: if necessary. Watch for white spaces)*

<br>

### SSH Connection:

> **ssh <username\>@<IP\> -p <port\>** ... *(lowercase p)*


### SCP (Secure Copy Protocol) File Transfer:

> **. scp -P <port\> <file\> <HisUser\>@<ip\>:/<destination\>** ... *(from our machine 1 to remote machine 2)*
>
> **. scp -P <port\> <HisUser\>@<ip\>:/<file\> <destination\>** ... *(receive from remote machine 2 to our machine 1)*
>
> **. scp -P <port\> <MyUser\>@<ip\>:/<file\> <destination\>** ... *(receive in remote machine 2 from my machine 1)*
>
> **. scp -P <port\> <file\> <MyUser\>@<ip\>:/<destination\>** ... *(send from remote machine 2 to my machine 1)*

**note:** *we only need SSH at the machine we are trying to connect to.*

<br>

### FTP (File Tranfer Protocol)
---

The [FTP protocol](https://en.wikipedia.org/wiki/FTP) is used to transfer files between computers over a network.

#### Installation and Configuration

**. apt install vsftpd**
**. vim /etc/vsftpd.conf**


##### vsftpd.conf:


	listen_port=X                        (the X default value is 21, but we should change this)

	write_enable=YES                     (so that users can also upload, not just download9

	chroot_local_user=YES                (locks users inside their own homefolder when using FTP)

	allow_writeable_chroot=YES           (lets users upload and download in their homefolder)

	chroot_list_enable=YES               (allows some users to not be restricted by the chroot)

	chroot_list_file=/etc/<filename\>     (specifies the file to tell which users)




**Note:** *that specific file only contains the names of said users*

<br>

> **. systemctl restart vsftpd** ... *(FTP system restart)*
> 
> **. systemctl status vsftpd** ... *(FTP system check)*

<br>

#### Encryption

[Encryption](https://en.wikipedia.org/wiki/Encryption) is a way of concealing information, in order to keep it from being unwillingly shared.

> **. cd /etc/ssl/private**
>
> **. openssl req -x509 -nodes -newkey rsa:2048 -keyout <file\> -out <file\> -days 365**
>
> **. chmod 600 <file\>** ... *(change the permissions of the certificate)*

We are creating a self-signed certificate, valid for 365 days.

|**Entry**      |**Explanation**                                         |
|---------------|--------------------------------------------------------|
|req            |creating and processing cert signing requests CSRs...   |
|x509           |tells OpenSSL that we want a self-signed cert, not a CRS|
|nodes          |we don't want to encrypt the private key                |
|newkey rsa:2048|generate a RSA private key with the size of 2048bits    |
|keyout <file\> |where the private key will be stored                    |
|out <file\>    |where the self-signed cert will be stored               |
|days 365       |validity period. After this, the cert will expire       |


> **. vim /etc/vsftpd.conf**


##### vsftpd.conf:

	rsa_cert_file=etc/ssl/private/<file\>

	rsa_private_key_file=/etc/ssl/private/<file\>

	ssl_enable=YES

	ssl_ciphers=HIGH

	ssl_tlsv1=YES

	ssl_sslv2=NO

	ssl_sslv3=NO

	force_local_data_ssl=YES

	force_local_logins_ssl=YES



**Note:** *Now we can securely use FTP.*

<br>

### NETWORK CONFIGURATION
---

*Networks Interface Cards are identified by the system with the name enpXsY (ex: **enp0s3**)*

en         (ethernet)
p          (pci card; o = onboard; s = pci express)
X          (bus)
Y          (the occupied slot)


> **. ip a** ... *(identify all available network interface cards)*
>
> **. ls /sys/class/net** ... *(fulfills the same purpose)*
>
> **. ifconfig** ... *(will do the same, but we have to install the net-tools app)*
>
> **. ifdown enp0s3** ... *(disable the enp0s3 nic)*
>
> **. ifup enp0s3** ... *(activate it)*
>
> **. dhclient -r enp0s3** ... *(release the current ip)*
>
> **. dhclient enp0s3** ... *(request a new ip)*
>
> **. ip route** ... *(check the current gateway address)*
>
> **. cat/etc/resolv.conf** ... *(check the DNS addresses)*
>
> **. ip address add 192.168.0.44/24 dev enp0s8** ... *(this temporarily sets the ip)*
>
> **. ip route add default via 192.168.27.223*** ... *(configure the default gateway)*
>
> **. ip addr flush enp03** ... *(flushing the current definitions without restarting)*
>
> **. apt install resolvconf** ... *(app to definitely set the ip)*


**vim /etc/network/interfaces** ... *(we can check here how the interface cards are working)*


##### interfaces:

	allow-hotplug enp0s3

	iface enp0s3 inet static            (change here to static)

	address 192.168.27.249

	netmask 255.255.255.0

	gateway 192.168.27.222

	dns-nameservers 8.8.8.8 8.8.4.4


> **. ifdown enp0s3**
>
> **. ifup enp0os3**

<br>

#### Adding an extra interface card

To do this, we need to add it to the VM and restart the machine.
Then we'll need to check the name given with **ip addr**.
Finally, we'll have to edit once more the **/etc/network/interfaces** file.
Only then will the NIC be recognized.

##### interfaces:

	allow-hotplug enp0s8

	iface enp0s8 inet static

	address 192.168.27.253

	netmask 255.255.255.0

<br>

### FILE COMPRESSION
---

File compression or [data compression](https://en.wikipedia.org/wiki/File_compression) is the reduction of the number of bits necessary to represent said data.

<br>

#### TAR (Grouping - 'use .tar')
Tape archive, AKA ['tar'](https://www.geeksforgeeks.org/tar-command-linux-examples/) is an archiver and extractor.

NOTE: be inside the folder where your 'to be' compressed liles and folders are located.

> **. tar -cvf <file.tar\> <files.txt\> <folders\>** ... *(groups files or folder)*
>
> **. tar -xvf <file.tar\>** ... *(extracts archived tar file to our position)*
>
> **. tar -xvf <file.tar\> -C /location/** ... *(extracts to the specified location)*
>
> **. tar -rvf <file.tar\> <file1\> <file2\>** ... *(appends a file or folder to a tar)*

#### TAR (Compression - use '.tar.gz')

> **. tar -zcvf <file.tar.gz\> <files.txt\> <folders\>** ... *(The same for all commands: add **z**)*
>
> **. tar -zxvf <file.tar.gz\> -C /location/** ... *(extract to the specified location)*
>
> **. tar -tvf <file.tar\>** ... *(or **tar.gz**. List the contents of the **.tar** or **.gz** file)*

<br>

#### GZIP
Exclusively used for files, [gzip](https://www.geeksforgeeks.org/gzip-command-linux/) is a single file compressor.

> **. gzip <files_to_be_compressed\>**
>
> **. gzip -d <files.tar.gz\>** ... *(several files to decompress at the same time)*
>
> **. gzip -k <file1\> <file2\>** ... *(keeping a copy of the original files)*

<br>

#### ZIP
A Unix utility, [zip](https://www.geeksforgeeks.org/zip-command-in-linux-with-examples/) is used for compressing and pckaging files. 

> **. zip <files.zip\> <file1\> <file2\>** ... *(basic syntax)*
>
> **. zip -t /</folder/zip.file\> </folder/\>** ... *(To compress a folder and all its content)*
> 
> **. unzip <files.zip\>** ... *(uncompress the file)*
>
> **. zip -sf files.zip** ... *(List the content of a zipped file)*

<br>

### FIND
---

The [find](https://www.geeksforgeeks.org/find-command-in-linux-with-examples/) command is used to walk through a file hierarchy and perform a recursive search.

> **. find . -name file.txt** ... *(search for files and folders from the current folder)*
>
> **. find /home -iname file.txt** ... *(case insensitive search in the /home folder)*
>
> **. find / -type d -name <name\>** ... *(**d** lets us search for folders only)*
>
> **. find / -type f -iname "*.txt"** ... *(**f** searches for files only. Wildcards => brackets)*
>
> **. find /home -type f -perm 0777** ... *(searching files by their permissions)*
>
> **. find / -user root -name ".bin"** ... *(find files and folders by their owner)*
>
> **. find / -group <group\>** ... *(find files and folders by group of users)*
>
> **. find / -mmin -60** ... *(searching for files used in the last hour)*
>
> **. find / -size +50M** ... *(searching for files bigger than 50Mb)*
>
> **. find / -size +50M -size -100M** ... *(files bigger than 50Mb and smaller than 100Mb)*
>
> **. find / -maxdepth 4 -name "*.md"** ... *(searching for files down to a depth of 4 steps)*

<br>

### GREP
---

Searching within files, [grep](https://www.geeksforgeeks.org/grep-command-in-unixlinux/) will seek for particular patterns.

> **. grep grsi /etc/passwd** ... *(searching for the word **grsi** inside the file **passwd**)*
> 
> **. grep -w grsi /etc/paswd** ... *(same, but looking for the whole word)*
> 
> **. grep "grsi is the" /etc/passwd** ... *(expression search)*
> 
> **. grep -i thing /home/grsip/file.txt** ... *(**i** makes the search case insensitive)*
> 
> **. grep -r root /etc** ... *(search within a folder and all its subfolders)*
> 
> **. grep -v nologin /etc/passwd** ... *(search all lines where the word isn't present)*
> 
> **. grep ^coisa /etc/passwd** ... *(search for all lines that start with the word 'coisa')*
> 
> **. grep coisa$ /etc/passwd** ... *(ditto, but ending in the word 'coisa')*

<br>

### TEE
---
Forking an input into the standard output and another file, [tee](https://www.geeksforgeeks.org/tee-command-linux-example/) is yet aother very useful Linux tool.

		----------------------
			  |
	One entry ->	  |
			  |
			  |
      <-------		         ------>
	Two exits		Two exits

>**. ls -l | tee <file1.txt\> <file2.txt\>** ... *(the result of **ls -l** in the files + on terminal)*
>
>**. ls -hal | tee -a <file1.txt\> <file2.txt\>** ... *(appends to the files)*

<br>

### HISTORY
---

The [history](https://www.geeksforgeeks.org/history-command-in-linux-with-examples/) command helps us by showing our previously inputed commands.

> **. history** ... *(check all commands entered in the Linux shell by the user)*
>
> **. history 50** ... *(check the last 50 commands)*
>
> **. !230** ... *(repeat command number 230)*

**Note:** *all commands are saved inside the file **.bash_history** in the user's homefolder.*
      *Logging off or rebooting will add this session's commands to that file.*

<br>

### ALIAS
---

The [alias](https://www.geeksforgeeks.org/alias-command-in-linux-with-examples/) comman will let us substitute one or several commands for any other command we create.

> **. alias lst_detail="ls -hal"** ... *(will create the command **lst_details** which will do **ls -hal**)*

**Note:** *these commands are volatile and thus will perish upon a system reboot.*
*To make them permanent we must add them to the file **.bashrc*** 
*Also, in order for the change to take, we need to logout.*

<br>

### SOFT & HARD LINKS
---

[Soft & hard links](https://www.geeksforgeeks.org/soft-hard-links-unixlinux/) can serve several purposes. [This](https://github.com/OPQAM/MigratingCoconuts/blob/master/documentation0.md), for example.

> **. ln -s /file.txt /home/user/file_softLink.txt** ... *(creates a Soft Link)*
>
> **. ln /file.txt /home/user/file_hardLink.txt** ... *(same, but creates a Hard Link)*

**Note:** *Soft Links are very much like Windows shortcuts, pointing directly to the file or folder.*
*Hard Links point towards the space that the file occupies on the drive.*
*We can use Hard Links as backups, making it harder for a file to be accidentally deleted.*

<br>

### CRONTAB
---

The [cron](https://en.wikipedia.org/wiki/Crontab) command-line utility is used to schedule jobs on a Unix-like machine.

0-59	0-23	1-31	1-12	0-6		(0 = Sunday & 7 = Sunday)
(Min)	(Hour)	(DOM)	(MON)	(DOW)	command 
	
DOM ---> Day of Month
MON ---> Month
DOW ---> Day of Week
cmd ---> Command

**Note:** *Events will happen in a cycle.*
*use **\*** for empty values (means 'Any').*


#### A few examples
	
	Min	Hour	DOM	MON	DOW	command
	
	30	17	*	*	*	rm -r /tmp/* (every day at 17:30)
 	30	0	*	12	*	........     (December at 00:30)
  	0	0	1-15,20	12	* 	........     (1 to 15, 20 of December)
	0	12	*	12	1-5	........             
	12	12	20-25	1-10	6	........     (every day from 20 to 25 and all saturdays)
	0	10,20	*	*	*	........
	*	20	*	*	0,6	........     (every minute)
	30	*	*	*	0,4,6	........
	*/15	*	*	10	*	........     (every 15 minutes)
	*	9-18/3	*	*	*	........     (every 3 hours, from 9 to 18)


> **. crontab -e** ... *(Open crontab and add cron jobs to it
>
> **. crontab -r** ... *(Delete current crontab)*
>
> **. crontab -l** ... *(See current crontab)*
>
> **. select-editor** ... *(change crontab editor)*
>
> **. crontab -e -u john** ... *(Edit crontab for the user 'john')*

**Notes:** *stored in: **/var/spool/cron/crontabs** (no need to edit the file)*
*It starts running commands at first unit (ex: first minute)*
*If no destination file is added, it will write in the user's homefolder.*
*Echo doesn't work. There is no printing to the terminal.*

> **. grep cron /var/log/syslog | tail -10** ... *(as an example: the last 10 crontab commands)*
>
> **. touch /etc/cron.allow** ... *(select those that can access crontab. If empty, then only the root can access it)*

**Notes:** *We can serve a similar purpose with **cron.deny**.*
*If **cron.allow** exits it will stop the system from checking **cron.deny**.
*Debian 12 doesn't have **/var/log/syslog** by default. We can check logs with, for example, **journalctl -u cron**.*

Examples:

__a.	Do a copy of the folder /USER into /root/user_back at the 10th of July at 8h:30am__
	Min	Hour	DOM	MON	DOW	cmd
	30	8	10	6	*	cp -r /USER > /root/user_back


__b.	Restart SSH every workday at 8am__
	Min	Hour	DOM	MON	DOW	cmd
	0	8	*	*	1-5	systemctl restart ssh


__c.	Restart SSH every workday, every hour, between 9am and 6pm__
	Min	Hour	DOM	MON	DOW	cmd
	0	9-18	*	*	1-5	systemctl restart ssh


__d.	Execute ls –la every 10 minutes e place the result in a text file called ls_la.txt__
	Min	Hour	DOM	MON	DOW	cmd
	*/10	*	*	*	*	ls -la > ls_la.txt

__e. Execute rm –rf /dump1/* every hour__
	Min	Hour	DOM	MON	DOW	cmd
	0	*	*	*	*	rm -rf /dump1/*

__f.	Execute rm –rf /dump1/* once a day__
	Min	Hour	DOM	MON	DOW	cmd
	0	12	*	*	*	rm –rf /dump1/*

__g.	Execute rm –rf /dump1/* once a week__
	Min	Hour	DOM	MON	DOW	cmd
	0	12	*/7	*	*	rm –rf /dump1/*
(or...)
	0	12	*	*	0	rm –rf /dump1/*

__h.	Execute rm –rf /dump1/* once a month**__
	Min	Hour	DOM	MON	DOW	cmd
	0	12	1	*	*	rm –rf /dump1/*

__i.	Execute rm –rf /dump1/* once a year__
	Min	Hour	DOM	MON	DOW	cmd
	0	12	1	1	*	rm –rf /dump1/*

__j.	Make rm /home/someuser/tmp/* run every minute, non stop__
	Min	Hour	DOM	MON	DOW	cmd
 	*  *  *  *  * rm /home/someuser/tmp/*


<br>

### AT
---

Much like with crontab, [at](https://www.geeksforgeeks.org/at-command-in-linux-with-examples/) is used to create jobs. But unlike crontab, it will leave no trace.
Meaning that after a job is fulfilled, its task and command gets permanently deleted.

<br>

#### Examples

> **. at now + 15 min**
> 
> **. at 12:00**
> 
> **. at 15:23 1 jun 2024**
> 
> **. at 12:00 5/24/2024** ... *(month/day/year)*
> 
> **. at 14:33 THU**

**Note:** *after setting one of the above tasks we then specify what command is to be started.*
When we are done, we exit with **Ctrl-D**.*

<br>

#### Reference

> **. atq** ... *(which tasks are there. Alternative to **-l**)*
>
> **. at -c <number\>** ... *(see the commands of task number X)*
>
> **. atrm <number\>** ... *(remove task number X. Alternative to **-r**)*

**Notes:** *as with crontab, we have **/etc/at.allow**.*
**The file **at.deny** exists by default and denies usage to all users that can't login (system users).* 
				
<br>

### EXIT CODES
---

[Exit codes](https://itsfoss.com/linux-exit-codes/) will inform us of the last executed command, informing us if it ran correctly.

> **. echo $?** ... *(Retuns exit code. If **0** all is ok)*

Scripts usually run on a schedule and without human supervision 24/7, 
so it's a good idea to have exit codes inform us if something went wrong.
So we can, for example, upon getting a non 0 value, email the sysadmin.

<br>

### RSYNC
---

#### Installation

. apt install rsync

The utility tool [rsync](https://en.wikipedia.org/wiki/Rsync) is an efficient way to transfer files between machines, by comparing the modification times and sizes of files.

> **. rsync <option\> <file_to_copy_from\> <user\>@<host\>:<destination\>**


-r          (recursive (timestamp isn't preserved, so it keeps the transfer date)
-v          (verbose)
-a          (archive mode (preserves the timestamp)
-d          (compress and decompress automatically at the origin and destination, respectivelly)
-h          (human-readable)

<br>

#### Examples


> **. rsync -zvh backup.tar /tmp/backups/** ... *(Copy/sync a directory in the same machine)*

> **. rsync -avzh /data/ grsip@192.168.1.205:** ... *(forwarded to the user's home)*

**Note:** *without the final **/** it will copy both folder and files within(!).*
*i.e.* **rsync -avzh /data grsip@192.168.1.205:**

> **. rsync -avzh root@192.168.1.205:/file_grsip.tar.gz ./** ... *(receives the file into the current folder)*
>
> **. rsync -avzh -e "ssh -p9000" root@192.168.1.205:/file_grsip.tar.gz ./** ... *(note how we add the port)*

Crontab doesn't let us do things on the foreground. So we cannot enter passwords.
An interesting solution is to have a secure connection, between two machines, that doesn't require a password.
This connection will work in one direction only and between those two users. Anything else will fail.
We'll need an RSA key.

<br>

#### Secure, passwordless connection
-> This is necessary when we want to add commands in crontab where there are ssh connections. This makes it possible so that the admin doesn't have to provide password for the actions(!).

> **. ssh-keygen -t rsa** ... *(creates the passwordless key)*
>
> **. ssh-copy-id -i .ssh/id_rsa.pub grsip@192.168.1.205** ... *(no path required)*

*Now, the other machine has a public key.*

<br>

#### Connection test

> **.ssh grsip@192.168.1.205** ... *(passwordless direct login)*
 
*And now we can directly connect to the other machine, with these users and in this direction.*
*We can go ahead and create crontab or at jobs that will send files accross our machines.*

<br>

### DHCP
---

Dynami Host Configuration Protocol - [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)

All steps should be ran as root.
In order to attribute IP addresses, our DHCP server will need to have an IP inside that specific network.
So, before any of these configurations are set up, it is a good idea to attribute and fix a static IP address.
Also, we are assuming a configuration made on enp0sX - in an internal network (Virtual Box).

<br>

#### Installation

	 . apt install isc-dhcp-server          (DHCP configuration files are stored in /etc/dhcp/)
	 . vim /etc/default/isc-dhcp-server     (we need to set up the network interface + config location)

<br>

##### isc-dhcp-server:

	DHCPDv4_CONF=/etc/dhcp/dhcpd.conf           (this or the v6 line must be uncommented)

	...

	INTERFACESv4="enp0s3"                       (we need to add here or in v6 the appropriate network interface)

 <br>

#### Configuration

**. vim /etc/dhcp/dhcpd.conf**.

<br>

##### dhcpd.conf:

	subnet 10.4.0.0 netmask 255.255.0.0                   (the network we want to configure)

	{

 		range 10.4.100.100 10.4.100.200;               (the range of addresses that will use DHCP)

		option domain-name-servers 8.8.8.8, 8.8.4.4;   (the DNS. Pay attention to the comma)

		option domain-name "linux.dhcp";               (the domain name)

		option routers 10.4.0.1;                       (the default-gateway)

		default-lease-time 86400;                      (the default lease time, in seconds, i.e. a day)

		max-lease-time 172800;                         (the maximum lease time, in seconds, i.e. two days)

	}

#### Reset the command and verify its state

**. systemctl restart isc-dhcp-server**
**. systemctl status isc-dhcp-server**
**. journalctl -xe** ... *(to retect any possible errors)*

**Notes:** *we can see our IP with **ip addr**, we can know our gateway through **ip route**, and we can see our DNS through **cat /etc/resolf.conf**.*

<br>

#### Set IPs through MAC address

This can make it so that a machine can always get the same IP address, tying said IP address to the machine's MAC address.
We'll be adding a few lines to **/etc/dhcp/dhcpd.conf**.

<br>

##### dhcpd.conf:

	host webserver                                (configuring a single host inside the network)

	{
    
		hardware ethernet 08:00:27:89:A2:D8;

		fixed-address 10.4.100.30;

	}

We now need to restart our DHCP service and check if the correct IP was attributed to that machine.

<br>

#### DHCP Logs

**. cat /var/lib/dhcp/dhcpd.leases** ... *(this file is monitoring, in real time, what the server is doing to its IPs)*
**. cat /var/lib/dhcp/dhcpd.leases~** ... *(a backup of the oldest data of the /dhcpd.leases file)*

**Notes:** *all logs ate stored in **/var/log/syslog** (if it exists).*
**grep dhcp /var/log/syslog** *will check only dhcp logs.*
**grep dhcp /var/log/syslog | tail -20** *of those, this will check only the last 20 logs*

<br>

#### Connecting to another interface (for outside access)

**. vim /etc/sysctl.conf**

<br>

##### sysctl.conf

	net.ipv4.ip_forward=1         (this line needs to be uncommented for Linux to forward packets between interfaces)

Now we should restart the server.

**. apt install iptables** ... *(installing the iptables packet)*


> **.iptables --table nat --append POSTROUTING --out-interface enp0s8 -j MASQUERADE** ... *(use whatever 'bridged adapter' interface here)*


**Notes:** *now we can access the internet through enp0s8 (for example)*.
*But this command will vanish as soon as we restart our machine, so we need to create a script for it.*

**.vim /root/script.sh**

<br>

##### script.sh:

	#!/bin/sh

	iptables --table nat --append POSTROUTING --out-interface enp0s8 -j MASQUERADE        (same line as before)

**.chmod +x /root/script.sh** ... *(we need to give it executable permissions)*
**./root/script.sh** ... *(we cna do this to test if the script is running fine)*

We now need to create the file **/etc/rc.local** so taht our script can run automatically at restart.
We'll also need to give it executable permissions.

<br>

##### rc.local:

	#!bin/sh -e (the '-e' instructs the shell to exit immediately if the scripts exits with a non-zero status)

	/root/script.sh

	exit 0              (if it reaches here and returns zero, then it was probably successful)


**.chmod +x /etc/rc.local** ... *(permission to execute)*
**./etc/rc.local** ... *(testing the script)*

Now we can restart the server and check to see if our internal network can access the internet.

---

<br> 

### SAMBA

---

[Samba](https://en.wikipedia.org/wiki/Samba_(software)) A free and open-source suite that provides network services for file and print services to clients using the SMB/CIFS protocol.


#### Installation

	.apt install samba


#### Configuration

**.vim /etc/samba/smb.conf**

Note that whenever the configuration file is changed, we'll need to

**.systemctl restart smbd**

Also, we can read more about smb.conf definitions [here](http://www.samba.org/samba/docs/using_samba/ch06.html).

All configurations to be done in 'Share Definitions', at the end:

	[shared folder]
	comment = file sharing in Debian
	path = /srv/samba/share
	browsable = yes
	guest ok = yes
	read only = no

The folder */srv/samba/share* needs to be created and total permissions should be given:

**.chmod -R 777 /srv/samba/share**
**.systemctl restart smbd**

NOTE: If we want a user to, at the very least, be able to enter a folder, we'll need to give that user reading and executing permissions (in general chmod -R 775 -> so that other users can enter)

(in the Windows machine, go to the address toolbar in files)

**\\<destination IP\>\shared_folder**

We can define other types of access/authentication:

	[private]
	comment = partilha de ficheiros com acesso autenticado
	path = /srv/samba/docs_privados
	browsable = yes
	guest ok = no
	read only = no

We can set permissions for the files and folders that might have been created through Samba
with the commands *create mask* (files) and *directory mask* (folders).
	
	create mask = 0750
	directory mask = 0770

If we want for all files and folders to inherit upper layer permissions, we can do:

	inherit permissions = yes         (this will be considered before create mask and directory mask)


We'll need to add users for access:

**.smbpasswd –a “utilizador”**              (adds a user)
**.smbpasswd –d “utilizador”**              (disables a user) 
**.smbpasswd –e “utilizador”**              (enables a previously disabled user)
**.smbpasswd –x “utilizador”**              (removes a user)

**.pdbedit -L**                              (verify which users are in the system currently)

We must add these to *smb.conf* in order to give access to certain users. Ex:

	write list = @editors,alex              (writing access to the 'editors' group and to user 'alex')
	read list = @editors
	valid users = @pvsw                     (only members of group will have access)
	invalid users = xpto                    (this user has access denied)
	admin users = mike,john                 (users who can perform operations as root)
	max connections = 3                     (maximum number of concurrent connections)
	...

The commands 'hosts allow' and 'hosts deny' can also be used to allow or forbid access to sharing:

	hosts allow = 192.168.2.0/24 192.168.3.0/24

#### Checking for errors

We can do that with the command

**.testparm**

#### Sharing from Windows to Linux

**.apt install smbclient cifs-utils**

**.mkdir /media/pc_windows**

**.mount –t cifs –o username=user,password=password //<sharing_IP\>/<sharing_name\>/media/pc_windows**

Note: if we want this command to automatically run at start, we should add this last line to a bash script, inside the file '/etc/rc.local', but add the command sleep 10 before mounting:

	#!/bin/sh –e
	sleep 10
	mount –t cifs –o username=utilizador,password=password //ip_partilha/nome_da_partilha
	/media/pc_windows

 (remember to make it an executable)


#### Cleaning the Windows cache

It's a mess, and sometimes it doesn't work. But:

**.net use * /DELETE**                                       (Windows 7/8)
**.klist purge**                                              (Windows 7/8 and 10)

Word of advice: use them both. And if that fails, you can [just do this](https://i0.wp.com/www.putertutor.co.uk/wp-content/uploads/2022/03/turn-it-off-and-on-again.jpg?fit=602%2C328&ssl=1).


NOTE: despite having given create mask = 0777 and directory mask = 0777 to a folder in samba, folders created in samba got 777, but files only had 766. There is something else not giving executable permissions to both group and others. I read that umask might work subtractively.. but upon doing 'umask' I got the result 022. So, one would likely expect 755, not 766. What could cause this?

---

<br> 

### NIS - WIP

 The Network Information Service, or [NIS](https://www.geeksforgeeks.org/linux-network-information-service/) (also known as the Yellow Pages) is a client–server [directory service](https://en.wikipedia.org/wiki/Directory_service) protocol for distributing system configuration data such as user and host names between computers on a computer network.

#### Installation

	.apt install nis


#### Configuration (Server)

**.vim /etc/ypserv.securenets**

in here we can add the networks that we want to use (instead of everything being open by default)

- Don't touch the local host lines, but otherwise comment out the *0.0.0.0	0.0.0.0*.
Below we add *255.255.255.0	192.168.1.0* (as an example: mask, network IP)

**.vim /etc/hosts**

We should add the server's IP and the hostname (around the third line or so, right below our own server's name)

- Create the file /etc/defaultdomain and add a single line with our domain name:
mydomain.nis         (as an example)

Restart all services:

.systemctl restart rpcbind ypserv yppasswdd ypxfrd

Enable them at strtup:

.systemctl enable rpcbind ypserv yppasswdd ypxfrd

Create a NIS database:

./usr/lib/yp/ypinit -m

-> We'll be asked for extra servers. If we just want this one, we can end with [ctrl] + D

Adding users or groups:

.make -C /var/yp

#### Configuration (Client)

- Also install nis

- Edit /etc/yp.conf and add the following line at the end:

domain (domain_name) server (server_ip)
ex:
domain mydomain.nis server 192.168.1.212

Edit the file /etc/nsswitch.conf, adding the word nis 4 times:

passwd:		files systemd nis
group:		files systemd nis
shadow:		files systemd nis
...

hosts:		files dns nis

Create the file /etc/defaultdomain and add the domain name (like before)

Edit the file /etc/pam.d/common-session, and add this line at the end to add a user's home directory the first time the user connects through NIS:

session optional	pam_mkhomedir.so	skel=/etc/skel	umask=077

Restart the service and then enable it:

.systemctl restart rpcbind nscd ypbind
.systemctl enable rpcbind nscd ypbind

To change password, use the command:
. yppasswd

With ypcat passwd we can see what users have been created in the NIS server

Domain name:

.nisdomainname

Reconfigure the service:

.dpkg-reconfigure nis

WIP

### TCP WRAPPERS

---

#### Config

NOTE: to have vsftpd work with TCPWrappers, we nede to change the */etc/vsftpd.conf*, and add:

	tcp_wrappers=yes

#### Configuration

Configure the files:
/etc/hosts.allow
/etc/hosts.deny

syntax:

(service: network or IP)

exs:
**(in hosts.allow)**
sshd, vsftpd, telnet: 192.168.1.0/24, 192.168.1.10             (a network and a host are allowed)
sshd, telnet: 192.168.230.0/24 EXCEPT 192.168.230.122          (Excepting a single address)
vsftpd: server1, server2.atec.com                              (server1 = domain, second is the machine's name)
vsftpd: .rh.grsip.pt                                           (all machines that end in that name)

We can also use ', local' or ', paranoid' after a setting to, respectively, allow all local machines or, with paranoid, it will check with the DNS server to see if the name is associated with the IP (slow)

**(in hosts.deny)**
ALL: ALL                                             (all services and all IPs - to be blocked)

NOTE: If there is any single match in hosts.allow, it stops there and it gets authorized.
If nothing is found here, it will search in hosts.deny - to see if there are any matches there. If there are
no matches, it will allow entry.

NOTE: TCPWrappers reads each line one by one, in order. Be careful of the order we write them in.

Example: we want to block 192.168.230.122. If we do it like this, it won't blocked:

sshd, telnet: 192.168.230.0/24
sshd: 192.168.230.0/24 EXCEPT 192.168.230.122

The first line is read, and the IP goes through.

NOTE: we can also do in 'hosts.allow' after any line ':allow' and at the end 'ALL: ALL: deny', thus not needing to use a 'hosts.deny' file. (optional)


<br> 

### APACHE

---

#### Installation

. apt install apache2

#### Configuration

(we can now access directly, through web browser, our apache folder, by typing our IP address
The page can be found at '/var/www/html/' - it's a file index.html)

We can access it directly (it's the default) but if we add other files, we'll have to, for example, do 192.168.1.222/index3.html (in web browser)
If there is no index.html, it will show a folder (on the browser) with all the existing files in that folder

Nota: dar 'Refresh' à página com [CTRL] + F5

We add vsftpd (install + write_enable=yes so that we can use it -> remember to restart the system) to send files to our folder

- We can connect with vsftpd and send files.

We can send files to the **user's own folder**, ofc. Then move the file to our '/var/www/html'

IMPORTANT: mind the file permissions!

We need to give reading rights to 'other' users.

.chmod +r myFile.html

OR

.chmod 644 myFile.html

We can check logs in:

/var/log/apache2/access.log  (successful accesses to our page)
/var/log/apache2/error.log   (failed accesses to our page)

Use, for instance:
.tail -15 /var/log/apache2/error.log                          (read from end, upwards)

**As an alternative to sending files to the user's homefolder and then moving said files to our apache2 folder:**

- We can use a symbolic link.

Example:

mkdir /home/myUser/webpage                               (keep webpages here)

.ln -s /home/myUser/webpage/  /var/www/html/mySymLink

**Atenção - Dar permissões:**
(this is for Debian 12 onwards. Permissions are now different. The default permissions for homefolders are 700. Before Debian 12 it was 755. So we need to give executable permissions! Folders created inside that user's folder are, by default 755)

.chmod +x /home/grsip

Now we can access with the browser:

192.168.1.222/mySymLink

NOTE: our newly created webpage has been created by root, and thus we can't send files through vsftpd. We need do:

chown -R myUser:myUser /home/myUser/webpage                   ('-R' for all content as well)



NOTA: a pasta de imagens tem que estar ABAIXO da pasta de ficheiros (i.e index.html)!!!
...

UserDir (part of Apache notes - wip) - enabling user-specific directories

It will read, as a website as: .../~UserDirectory

Go inside */etc/skel* and add a folder + file like */web/Index.html*

- Since we're adding to the skel folder, this means that any new user will get this folder and file by default.

. a2enmod userdir
. vim /etc/apache2/mods-enable/userdir.conf

Add the following:

UserDir web             (since we're using the 'web' folder by default)
Directory /home/*/web   (same)

restart apache:
systemctl restart apache2

If using previous Debian versions, we're good to go. If using Debian 12, we still have to give executing permissions to the home folder:
chmod +x /home/<homefolder>

We can now test on another machine (<IP>/~username)
