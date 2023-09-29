
## **Linux Commands**

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

> **. passwd <user\>** ... *(change the password of user)*
> 
> **. adduser <user\>** ... *(add new user)*
>
> **. deluser <user\>** ... *(remove user)*
>
> **. deluser <user\> --remove-home** ... *(removes user & homefolder)*
>
> **. addgroup <group\>** ... *(adds new group)*
>
> **. delgroup <group\>** ... *(removes group)*
>
> **. adduser <user\> <group\>** ... *(adds user to group)*
>
> **. deluser <user\> <group\>** ... *(removes user from group)*
>
> **. usermod -g <group\> <user\>** ... *(changes the primary group of user)*
>
> **. id** ... *(shows the groups to which user belongs)*
>
> **. init 0** ... *(shuts down the machine)*
>
> **. init 6** ... *(restarts the machine)*
>
> **. chown** ... *(alters ownership of files)*
>
> **. chown -R <user\> <file\>** ... *(changes owner of folder and all content)*
>
> **. chown <user\>:<group\> <file/folder\>** ... *(changes both owner and group of file)*
>
> **. chgrp** ... *(changes the group owning the file)*
>
> **. chgrp -R <group\> <file\>** ... *(same, and all its content)*
>
> **. chmod 754 <file\>** ... *(changes the permissions of files)*
>
> **. chmod -R 660 <file\>** ... *(alters folder permissions and of all its content)*
> 
> **. head 5** ... *(shows the firts 5 lines of the file)*
>
> **. tail 12** ... *(shows the last 12 lines of the file)*
> 
> **. sort** ... *(orders the file)*
> 
> **. wget <URL\> -O <file\>** ... *(downloads the content of the URL and saves it)*

### Wildcards

|**Wildcard** | **Description**             |
|-------------|-----------------------------|
|\*           |0 or more characters         |
|?            |exactly 1 character          |
|\>           |output redirection (overrite)|
|\>\>         |output redirection (append)  |


### SSH

The [SSH protocol](https://en.wikipedia.org/wiki/Secure_Shell) allows for secure access over a network.

#### Installation:

	. apt install ssh

#### Configuration:

	. vim /etc/ssh/sshd_config     (remember your backups)

---
---
(*sshd_config* file)

**port 22**

***AllowUsers <user\>** ... (users that can access the system via SSH)*

***DenyUsers <user1\> <user2\>** ... (users that are forbidden from doing so)*

***AllowGroups <group1\> <group2\>** ... (groups that can access the system via SSH)*
 
**DenyGroups <group1\> <group2\>** ... (groups that are forbidden from doing so)*

***PermitRooLogin YES** ... (to allow root access via SSH)*

**Note:** *do not use **AlloUsers** and **AllowGroups** simultaneously!*

---
---


<br>

> **. systemctl restart ssh** ... *(SSH restart, so that configuration changes can take place)*
>
> **. systemctl status ssh** ... *(to check if SSH is working without issues)*
>
> **. journalctl -xe** ... *(error check: if necessary. Watch for white spaces)*


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


### FTP (File Tranfer Protocol)

The [FTP protocol](https://en.wikipedia.org/wiki/FTP) is used to transfer files between computers over a network.

#### Installation:

	. apt install vsftpd

#### Configuration:

	. vim /etc/vsftpd.conf                  (remember your backups)

---
---
(*vsftpd.conf* file)

***listen_port=X** ... (the X default value is 21, but we should change this)*

***write_enable=YES** ... (so that users can also upload, not just download9*

***chroot_local_user=YES** ... (locks users inside their own homefolder when using FTP)*

***allow_writeable_chroot=YES** ... (lets users upload and download in their homefolder)*

***chroot_list_enable=YES** ... (allows some users to not be restricted by the chroot)*

***chroot_list_file=/etc/<filename\>** ... (specifies the file to tell which users)*

*(That specific file only contains the names of said users)*

---
---


<br>

> **. systemctl restart vsftpd** ... *(FTP system restart)*
> 
> **. systemctl status vsftpd** ... *(FTP system check)*


#### Encryption:

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


> **vim /etc/vsftpd.conf**

---
---
(*vsftpd.conf* file)

*(these can be found, and added to, at about line 150)*

***rsa_cert_file=etc/ssl/private/<file\>***

***rsa_private_key_file=/etc/ssl/private/<file\>***

***ssl_enable=YES***

***ssl_ciphers=HIGH***

***ssl_tlsv1=YES***

***ssl_sslv2=NO***

***ssl_sslv3=NO***

***force_local_data_ssl=YES***

***force_local_logins_ssl=YES***

---
---

**Note:** *Now we can securely use FTP.*

<br>


### NETWORK CONFIGURATION

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

---
---
(*interfaces* file)

***allow-hotplug enp0s3***

***iface enp0s3 inet static**   (change here to static)*

***address 192.168.27.249***

***netmask 255.255.255.0***

***gateway 192.168.27.222***

***dns-nameservers 8.8.8.8 8.8.4.4***

---
---


<br>

> **. ifdown enp0s3**
>
> **. ifup enp0os3**

#### Adding an extra interface card

To do this, we need to add it to the VM and restart the machine.
Then we'll need to check the name given with **ip addr**.
Finally, we'll have to edit once more the **/etc/network/interfaces** file.
Only then will the NIC be recognized.

---
---
(*interfaces* file)

***allow-hotplug enp0s8***

***iface enp0s8 inet static***

***address 192.168.27.253***

***netmask 255.255.255.0***

---
---


<br>

### FILE COMPRESSION

File compression or [data compression](https://en.wikipedia.org/wiki/File_compression) is the reduction of the number of bits necessary to represent said data.

#### TAR (Grouping)

> **. tar cvf /<file.tar\> <files.txt\> <folders\>** ... *(groups files or folder)*
>
> **. tar xvf <file.tar\>** ... *(extracts archived tar file)*
>
> **. tar xvf <file.tar\> -C /location/** ... *(extracts to the specified location)*
>
> **. tar rvf <file.tar\> <file1\> <file2\>** ... *(adds a file or folder to a tar)*

#### TAR (Compression)

> **. tar zcvf <file.tar.gz\> <files.txt\> <folders\>** ... *(The same for all commands: add **z**)*
>
> **. tar zxvf <file.tar.gz\> -C /location/** ... *(extract to the specified location)*
>
> **. tar tvf <file.tar\>** ... *(or **tar.gz**. List the contents of the **.tar** or **.gz** file)*

#### GZIP (Compression-only - files exclusively)

> **. gzip <files_to_be_compressed\>**
>
> **. gzip -d <files.tar.gz\>** ... *(several files to decompress at the same time)*
>
> **. gzip -k <file1\> <file2\>** ... *(keeping a copy of the original files)*

#### ZIP

> **. zip <files.zip\> <file1\> <file2\>** ... *(basic syntax)*
>
> **. zip -t /</folder/zip.file\> </folder/\>** ... *(To compress a folder and all its content)*
> 
> **. unzip <files.zip\>** ... *(uncompress the file)*
>
> **. zip -sf files.zip** ... *(List the content of a zipped file)*


### FIND

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


### GREP

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


### TEE
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


### HISTORY

> **. history** ... *(check all commands entered in the Linux shell by the user)*
>
> **. history 50** ... *(check the last 50 commands)*
>
> **. !230** ... *(repeat command number 230)*

**Note:** *all commands are saved inside the file **.bash_history** in the user's homefolder.*
      *Logging off or rebooting will add this session's commands to that file.*
      

### ALIAS

> **. alias lst_detail="ls -hal"** ... *(will create the command **lst_details** which will do **ls -hal**)*

**Note:** *these commands are volatile and thus will perish upon a system reboot.*
*To make them permanent we must add them to the file **.bashrc*** 
*Also, in order for the change to take, we need to logout.*


### SOFT & HARD LINKS

> **. ln -s /file.txt /home/user/file_softLink.txt** ... *(creates a Soft Link)*
>
> **. ln /file.txt /home/user/file_hardLink.txt** ... *(same, but creates a Hard Link)*

**Note:** *Soft Links are very much like Windows shortcuts, pointing directly to the file or folder.*
*Hard Links point towards the space that the file occupies on the drive.*
*We can use Hard Links as backups, making it harder for a file to be accidentally deleted.*


### CRONTAB

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
> **. select-editor** ... *(trocar editor crontab)*
>
> **. crontab -e -u john** ... *(Edit crontab for the user 'john')*

**Notes:** *stored in: **/var/spool/cron/crontabs** (no need to edit the file)*
*It starts running commands at first unit (ex: first minute)*
*If no destination file is added, it will write in the user's homefolder.*
* Echo doesn't work. There is no printing to the terminal.

> **. grep cron /var/log/syslog | tail -10** ... *(as an example: the last 10 crontab commands)*
>
> **. touch /etc/cron.allow** ... *(select those that can access crontab. If empty, then only the root can access it)*

**Note:** *We can serve a similar purpose with **cron.deny**.*
*If **cron.allow** exits it will stop the system from checking **cron.deny**.
*Debian 12 doesn't have **/var/log/syslog** by default. We can check logs with, for example, **journalctl -u cron**.*


### AT

*Much like with **crontab**, **at** is used to create jobs. But unlike crontab, it will leave no trace.*
*Meaning that after a job is fulfilled, its task and command gets permanently deleted.*

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

#### Reference

> **. atq** ... *(which tasks are there. Alternative to **-l**)*
>
> **. at -c <number\>** ... *(see the commands of task number X)*
>
> **. atrm <number\>** ... *(remove task number X. Alternative to **-r**)*

**Notes:** *as with crontab, we have **/etc/at.allow**.*
**The file **at.deny** exists by default and denies usage to all users that can't login (system users).* 
				
    
### EXIT CODES (wip)

> **. echo $?** ... *(Retuns exit code. If **0** all is ok)*

Scripts usually run on a schedule and without human supervision 24/7, 
so it's a good idea to have exit codes inform us if something went wrong.
So we can, for example, upon getting a non 0 value, email the sysadmin.


### RSYNC

The utility tool [rsync](https://en.wikipedia.org/wiki/Rsync) is an efficient way to transfer files between machines, by comparing the modification times and sizes of files.

	rsync <option\> <file_to_copy_from\> <user\>@<host\>:<destination\>


	-r      (recursive (timestamp isn't preserved, so it keeps the transfer date)
	-v      (verbose)
	-a      (archive mode (preserves the timestamp)
	-d      (compress and decompress automatically at the origin and destination, respectivelly)
	-h      (human-readable)

#### Examples

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

#### Secure, passwordless connection

> **. ssh-keygen -t rsa** ... *(creates the passwordless key)*
>
> **. ssh-copy-id -i .ssh/id_rsa.pub grsip@192.168.1.205** ... *(no path required)*

*Now, the other machine has a public key.*

#### Connection test

> **.ssh grsip@192.168.1.205** ... *(passwordless direct login)*
 
*And now we can directly connect to the other machine, with these users and in this direction.*
*We can go ahead and create crontab or at jobs that will send files accross our machines.*



