
## Linux Basic Commands


####################################################################################
	
	**. ls** _(List directory)_
	**. cd** _(Change directory)_
	**. mkdir** _(Make directory)_
	**. touch** _(Create blank file)_
	**. cp (-r to copy directory)'** _(Make copy of file)_
	**. mv** _(Move/Rename file)_
	**. rm** _(remove file)_
	**. cat** _(list the content of a file)_
	**. tree** _(see tree structure of directories)_
	**. man** _(manual for a specific command)_
	
####################################################################################

/etc/passwd _(holds all users)_
/etc/group _(has all groups)_
/etc/shadow _(has all user (encrypted) passwords)_
		
	**. passwd <user>** _(change the password of a user)_
	**. adduser <user>** _(add new user)_
	**. deluser <user>** _(remove user)_
	**. deluser <user> --remove-home** _(removes both the user and its homefolder)_
	**. addgroup <group>** _(adds a new group)_
	**. delgroup <group>** _(removes a group)_
	**. adduser <user> <group>** _(adds a user to a group)_
	**. deluser <user> <group>** _(removes user from a group)_
	**. usermod -g <group> <user>** _(changes the primary group of a user)_
	**. id** _(shows the groups to which the user belongs to)_
	**. init 0** _(shuts down the machine)_
	**. init 6** _(restarts the machine)_
	**. chown** _(alters the ownership of files)_
	**. chown -R <user> <file>** _(changes the owner of the folder and of all its content)_
	**. chown <user>:<group> <file/folder>** _(changes both owner and group of the file)_
	**. chgrp** _(changes the group owner of the file)_
	**. chgrp -R <group> <file>** _(changes the group owner of the file and all its content)_
	**. chmod 754 <file>** _(changes the permissions of files/folders)_
	**. chmod -R 660 <file>** _(alters the permissions for the folder and all its content)_
	
####################################################################################
. *         -> 0 or more characters
. ?         -> exactly 1 character
. >         -> output redirection, with overrite
. >>        -> output redirection, by addition
. head 5    -> shows the firts 5 lines of the file
. tail 12   -> shows the last 12 lines of the file
. sort            -> orders the file
. wget <URL> -O <file>   -> downloads the content of the URL and saves it
####################################################################################
                                      -SSH-

Installing:

. apt install ssh
. apt install openssh-server             (on older distros)

Configuration:
. vim /etc/ssh/sshd_config               (remember your backups)
-------------------------------------------------
port 22

AllowUsers <user>                     -> users that can access the system via SSH
DenyUsers <user1> <user2>             -> users that are forbidden from doing so

AllowGroups <group1> <group2>         -> groups that can access the system via SSH
DenyGroups <group1> <group2>          -> groups that are forbidden from doing so

# Avoid using AlloUsers and AllowGroups at the same time!

PermitRooLogin YES         -> to allow root access via SSH (from prohibit-password)
-------------------------------------------------

. systemctl restart ssh -> SSH restart, so that configuration changes can take place
. systemctl status ssh  -> to check if SSH is working without issues
. journalctl -x         -> to detect which error caused the issue

SSH CONNECTION:

ssh <username>@<IP> -p <port>       -> (lowercase p)

SCP FILE TRANSFER:

. scp -P <port> <file> <HisUser>@<ip>:/<destination> -> from our to their machine
. scp -P <port> <HisUser>@<ip>:/<file> <destination> -> from their machine
. scp -P <port> <MyUser>@<ip>:/<file> <destination>  -> (there) receive from mine
. scp -P <port> <file> <MyUser>@<ip>:/<destination>  -> (there) send to mine

*** Só é preciso na máquina de DESTINO ***
####################################################################################
                                       -FTP-

Installation:

. apt install vsftpd

Configuration:

. vim /etc/vsftpd.conf                  (remember your backups)
-------------------------------------------------
listen_port=993               -> the default value is 21, but we should change this

write_enable=YES    -> so that users can also upload, not just download

chroot_local_user=YES     -> locks users inside their own homefolder when using FTP
allow_writeable_chroot=YES   -> lets users upload and download in their homefolder

chroot_list_enable=YES       -> allows some users to not be restricted by the chroot
chroot_list_file=/etc/<filename>  -> specifies the file to tell which users

# That specific file only contains the names of said users
-------------------------------------------------

. systemctl restart vsftpd         -> FTP system restart
. systemctl status vsftpd          -> FTP system check
. journalctl -xe                   -> error check

Encryption:

. cd /etc/ssl/private
. openssl req -x509 -nodes -newkey rsa:2048 -keyout <file> -out <file> -days 365

(we are creating a self-signed certificate, valid for 365 - explanation:
req              -> creating and processing cert signing requests CSRs...
-x509            -> tells OpenSSL that we want a self-signed cert, not a CRS
-nodes           -> we don't want to encrypt the private key
-newkey rsa:2048 -> generate a RSA private key with the size of 2048bits
-keyout <file>   -> where the private key will be stored
-out <file>      -> where the self-signed cert will be stored
-days 365        -> validity period. After this, the cert will expire

.chmod 600 <file>  -> change the permissions of the certificate

#final changes to the /etc/vsftpd.conf:
-------------------------------------------------
rsa_cert_file=etc/ssl/private/<file>
rsa_private_key_file=/etc/ssl/private/<file>
ssl_enable=YES
ssl_ciphers=HIGH
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
-------------------------------------------------
#Now we can securely use FTP
####################################################################################
                             -Network Configuration-

#Networks Interface Cards are identified by the system with the name enpXsY
# en         -> ethernet
# p          -> pci card. There are also o (onboard) or s (pci express)
# X          -> bus
# Y          -> the occupied slot

. ip addr            -> identify all available network interface cards
. ls /sys/class/net  -> fulfill the same purpose
. ifconfig           -> will do the same, but we have to install the net-tools app

. /etc/network/interfaces    -> we can check how the interface cards are working

. ifdown enp0s3      -> disable the enp0s3 nic
. ifup enp0s3        -> activate it

. dhclient -r enp0s3   -> release the current ip
. dhclient enp0s3      -> request a new ip

. ip route (or ip r)     -> check the current gateway address
. cat/etc/resolv.conf    -> check the DNS addresses

. ip address add 192.168.0.44/24 dev enp0s8   -> this sets the ip (temporarily)
. ip route add default via 192.168.27.223     -> configure the default gateway

.ip addr flush enp03   -> flushing the current definitions without restarting

. apt install resolvconf  -> app to definitely set the ip

. /etc/network/interfaces
-------------------------------------------------
allow-hotplug enp0s3
iface enp0s3 inet static   -> change here to static
address 192.168.27.249
netmask 255.255.255.0
gateway 192.168.27.222
dns-nameservers 8.8.8.8 8.8.4.4
-------------------------------------------------

. ifdown enp0s3
. ifup enp0os3           -> these two commands so that the ip changes

#In order to add an extra interface card, 
#we need to add it in the VM and restart the machine
#Then we'll need to check the name given with:
.ip addr
#Then we'll need to change the /etc/network/interfaces 
#so that this new nic can be recognized
-------------------------------------------------
allow-hotplug enp0s8
iface enp0s8 inet static
address 192.168.27.253
netmask 255.255.255.0
-------------------------------------------------
####################################################################################
                                 -File Compression-

TAR (Grouping)
. tar cvf /<file.tar> <files.txt> <folders>  -> groups files or folder (no compress)
. tar xvf <file.tar>                         -> extracts archived tar file
. tar xvf <file.tar> -C /location/           -> extract to the specified location
. tar rvf <file.tar> <other files to be added> -> adds a file or folder to a tar

TAR (Compressing)
. tar zcvf <file.tar.gz> <files.txt> <folders> -> The same to all commands. Add 'z'
. tar zxvf <file.tar.gz> -C /location/         -> extract to the specified location
. tar tvf <file.tar (or tar.gz)>    -> list the contents of the '.tar' or '.gz' file

GZIP (no grouping by itself - it compresses)

- Gzip is exclusively used by files, not folders

. gzip <files_to_be_compressed>
. -d <files.tar.gz>                 -> several files to decompress at the same time
. gzip -k <files to be decompressed>   -> keeping a copy of the original files

ZIP
. zip <files.zip> <files to compress>     -> basic syntax
. unzip <files.zip>                       -> uncompress the file
. zip -sf files.zip                       -> List the content of a zipped file
. zip -t /</folder/zip.file> </folder/>  -> To compress a folder and all its content
####################################################################################
                                      -Find-

. find . -name ficheiro.txt  -> search for files and folders from the current folder
. find /home -iname ficheiro.txt  -> case insensitive search in the /home folder

. find / -type d -name Coisa      -> 'd' lets us search for folders only
. find / -type f -iname "*.txt" -> 'f' searches for files only. Wildcards=>brackets

. find /home -type f -perm 0777   -> searching files by their permissions
. find / -user root -name ".bin"  -> find files and folders by their owner
. find / -group ATEC              -> find files and folders by group of users

. find / -mmin -60                -> searching for files used in the last hour

. find / -size +50M               -> searching for files bigger than 50Mb
. find / -size +50M -size -100M   -> smaller than 100Mb and bigger than 50Mb

. find / -maxdepth 4 -name "*.md" -> searching for files down to a depth of 4 steps
####################################################################################
                                      -Grep-

. grep grsi /etc/passwd    -> searching for the word 'grsi' inside the file 'passwd'
. grep -w grsi /etc/paswd            -> same, but looking for the whole word
. grep "grsi is the" /etc/passwd     -> expression search
. grep -i thing /home/grsip/atec.txt -> 'i' makes the search case insensitive
. grep -r root /etc               -> search within a folder (and all its subfolders)
. grep -v nologin /etc/passwd        -> search all lines where the word isn't present
. grep ^coisa /etc/passwd    -> search for all lines that start with the word 'coisa'
. grep coisa$ /etc/passwd            -> ditto, but ending in the word 'coisa'
####################################################################################
                                      -Tee-

		----------------------
			  |
	One entry ->	  |
			  |
			  |
      <-------		  |	       ------>
	Two exits		Two exits

. ls -l | tee file1.txt file2.txt (write 'ls -l' in the files and also prints)
. ls -hal | tee -a file1.txt file2.txt (append to the files)
####################################################################################
                                      -History-

. history              -> check all commands entered in the Linux shell by the user
. history 50           -> check the last 50 commands
. !230                 -> repeat the command number 230

Note: all commands are saved inside the file .bash_history in the user's homefolder
      logging off or rebooting will add this session's commands to that file
####################################################################################
                                        -Alias-

. alias lst_detail="ls -hal"  -> creates the command 'lst_details' doing: 'ls -hal'

Note: these commands are volatile and thus will perish upon a system reboot.
to make them permanent we must add them to the file .bashrc 
(inside the user's home folder)in order for the change to take, we need to logout
####################################################################################
                                  -Soft & Hard Links-

. ln -s /file.txt /home/user/file_softLink.txt  -> creates a Soft Link

. ln /file.txt /home/user/file_hardLink.txt     -> same, but creates a Hard Link

Note: Soft Links are much like Windows shortcuts, 
pointing directly to the file or folder.
Hard Links point towards the space that the file occupies on the drive. We can use
Hard Links as backups, making it harder for a file to be accidentally deleted
####################################################################################
                                   -Crontab-

0-59	0-23	1-31	1-12	0-6		(0 = Sunday & 7 = Sunday)
Min	Hour	DOM	MON	DOW	cmd 

DOM -> Day of Month
MON -> Month
DOW -> Day of Week
cmd -> Command

-> Events will happen in a cycle
-> use '*' for empty values (means 'Any')

Exs:

Min	Hour	DOM	MON	DOW	cmd

30	17	*	*	*	rm -r /tmp/*         (every day at 17:30)
30	0	*	12	*	........             (Dezembro às 00:30)
0	0	1-15,20,25	12	* 	........     (1 a 15, 20, 25, Dez)
0	12	*	12	1-5	........             
12	12	20-25	1-10	6	........ 
(!!! Neste caso é um 'V' todos os dias de 20 a 25 e todos os sábados)
0	10,20	*	*	*	........
*	20	*	*	*	0,6	...... (minuto a minuto)
30	*	*	*	0,4,6	........
*/15	*	*	10	*	....... (/ -> de 15 em q5 minutos)
*	9-18/3	*	*	*	....... (de 3 em 3 horas, das 9 às 18)

. crontab -e          -> Open crontab and add cron jobs to it
. crontab -r          -> Delete current crontab
. crontab -l          -> See current crontab
. select-editor       -> trocar editor crontab
. crontab -e -u john  -> Edit crontab for the user 'john'

-> guardado em: /var/spool/cron/crontabs (não é preciso ver)
-> começa a anotar/correr comandos à primeira unidade (ex: minuto)
-> se não é posto a posição do ficheiro de destino, escreve na homefolder do user
-> Echo não funciona. Não há output

-> idea: 
. grep cron /var/log/syslog | tail -10 (por exemplo - últimos comandos de crontab)
. touch /etc/cron.allow     -> selectionar os que podem aceder ao crontab
(se vazio, ninguém exceto o root pode aceder)
-> mesma ideia com o cron.deny (os que não podem aceder)
-> o cron.allow, se existir, faz com que o sistema não olhe para o cron.deny(!)
   Se estiver vazio, ninguém tem acesso a não ser o root(!)

Nota: &&, ||, ;
####################################################################################
				-at-

# This, much like crontab, is used to create jobs. But unlike crontab, it will leave
# no trace. Meaning that after a job is fulfilled, its command gets deleted

# Examples:

. at now + 15 min
. at 12:00
. at 15:23 1 jun 2024
. at 12:00 5/24/2024      -> Mês/Dia/Ano
. at 14:33 THU

# Then we introduce commands
> <commands>

# And exit
> (ctrl + D)

. atq    -> Que tarefas existem (alternativamente at -l)
. at -c <número>   -> ver comandos da tarefa <número>
. atrm <número>     -> eliminar tarefa <número> (alternativamente at -r)

# em vez de /etc/cron.allow há o /etc/at.allow
# se allow existir, o deny é negado (como com o crontab)
# at.deny existe by default - e nega a utilização a todos os utilizadores do sistema mas que não fazemos login com eles (os outros users todos que não os utilizáveis)

####################################################################################
				-Exit Codes-

. echo $?        -> Retuns exit code. If '0' all is ok.

# Scripts usually run on a schedule and without human supervision 24/7, 
# so it's a good idea to have exit codes inform us if something went wrong.
# So we can, for example, upon getting a non 0 value, email the sysadmin.

####################################################################################

Note: Debian 12 doesn't have /var/log/syslog
 We can check logs in, for example, journalctl -u cron

####################################################################################
				-rsync-

# A utility for efficiently transferring and synchronizing files between a computer and a storage drive and accross networked computers by comparing the modification times and sizes of files.

-> rsync <option> <file_to_copy_from> <user@>host:dest


-r - recursivo (não preserva timestamp - fica com data da transferência)
-v - verbose
-a - archive mode (preserva o timestamp)
-d - comprimir e descomprimir automaticamente (origem e destino)
-h - human-readable

EX: 
. rsync -avzh /dados/ grsip@192.168.1.205:    (vai para a home do user)
- no ficheiro recebido estará a data de transmissão dos dados(? - verificar)
NOTA: sem a barra, copia a pasta E O CONTEÚDO
Ou seja, rsync -avzh /dados grsip@192.168.1.205:

Receber ficheiros. Ex:

. rsync -avzh root@192.168.1.205:/file_grsip.tar.gz ./   -> para a pasta atual

Crontab(!): não dá para fazer coisas em foreground (ergo, nada de por passwords).
Solução: user sem password -> estabelecer connexão de sgurança - apenas de uma máquina para a outra - apenas num sentido e entre 2 utilizadores. Só neste sentido e com estes utilizadores não precisa de palavra passe. Qualquer outro sentido ou users, pede pass.

Precisamos de chave RSA!

. ssh-keygen -t rsa     -> criada a chave (sem pass-phrase)
. ssh-copy-id -i .ssh/id_rsa.pub grsip@192.168.1.205 -> não é preciso caminho

Agora a outra máquina tem a chave pública do outro lado.

Teste connexão:
.ssh grsip@192.168.1.205       -> login direto sem palavra-passe
 
Nota: porta:
rsync -avzh -e "ssh -p9000" root@192.168.1.205:/file_grsip.tar.gz ./

PASSAR A LIMPO!

####################################################################################



