## Documentation

_This doc holds the changes to a simple Debian 12 Server installation I'm using a Virtual Box machine, but this would work in bare metal_

### Specifics:

	Base Memory: 4096 MB
	Storage: 20,00 GB

----------------------------------------------------------------------

### Created the user, and added passwords to both user and root

_Made sure all is up to date (updates automatically with -y)_
	
	- apt update -y && apt upgrade -y
	
_Installed Vim_
	
	- apt install vim
	
_Virtual Box Guest Additions_
_Mounted the Guest Additions .iso (unsure this helps in this build)_
	
	- mount /dev/cdrom /mnt
	- ls -l /mnt
	
_Installed needed packets to run the additions_
	
	- apt install dkms linux-headers-$(uname -r) build-essential
	
_Installed Guest Additions and rebooted the system_
	
	- sh /mnt/VBoxLinuxAdditions.run
	- systemctl reboot -l
	
----------------------------------------------------------------------

### Installed and configured basic SSH_
	
	- apt install ssh
	
_Configured sshd_config_
	
	- vim /etc/ssh/sshd_config
	
_Uncommented #Port 22 and kept that number for now._
_Added one allowed user (my own). This line was created at the end_
	
	AllowUsers <my_user>
	
_If we want to give access to root, we have to add them to that line_
_But we also have to edit 'PermitRootLogin prohibit-password' to
'PermitRootLogin yes'. I'm not doing that right now._

_After having done this, we should guarantee there are no extra spaces_
_Save our configuration (Esc + :wq + enter)_
_And restart the service_
	
	- systemctl restart ssh
	
_We can also see if the system is running correctly_
	
	- systemctl status ssh
	
_If an error does occur, we can check it out with_
	
	- journalctl -xe
	
_Now we can install a program like putty and connect to our machine
using whatever user we have allowed_

----------------------------------------------------------------------

### Version Control

_Installed git_
	
	- apt install git
	
_Added our ID to git_
	
	- git config --global user.mail "<my_email@mail.com>"
	- git config --global user.name "my_name"
	
_Created a dotfiles folder_
	
	- mkdir /home/my_user/dotfiles
	
_In order to have a dotfiles folder controlling files outside of that folder, we could use hard links (to the file we want)_
	
	- ln /etc/ssh/sshd_config sshd_config
	
_Added our specific file to our dotfiles folder_
	
	- git init
	- git add sshd_config
	- git commit -m "Added link to sshd_config"
	
_Checked if all is correct with status and logs(git hash here)_
		
	- git status
	- git log
	
_If I need to revert to a previous version_
	
	- git revert <commit-hash>
	
_This will revert back to a previous commit while keeping the other snapshots._
_Git reset will remove commits after that point on_
	
	- git reset --hard <commit-hash> 
	
_created an untracked README.md to explain what this fodler is for_
	
	- echo "This folder keeps track of important dotfiles" > README.md
		
_By default, README.md won't be tracked. But we can guarantee it_
		
	- echo "README.md" > .gitignore
	- git add .gitignore
	- git commit -m "Added a README.md and a .gitignore files"
	
----------------------------------------------------------------------

### Configuring FTP

_Installed vsftpd and added it to version control + extra backup_
	
	- apt install vsftpd
	- cd /home/my_user/dotfiles
	- ln /etc/vsftpd.conf
	- git add vsftpd.conf
	- git commit -m "Added hard link to vsftpd.conf"
	- cp /etc/vsftpd.conf /etc/vsftpd.BAK
	
_Changed port number (on a new line)_
	
	- vim /etc/vsftpd.conf
	listen_port=<someOtherNumber>
	
_Allowed for both uploads and downloads (all below: uncomment or add)_
	
	write_enable=YES
	
_Limited user access to their homefolder only_
	
	chroot_local_user=YES
	allow_writeable_chroot=YES
	
_Set which users have access to all + which file decides that_
	
	chroot_list_enable=YES
	chroot_list_file=/etc/vsftpd.chroot_list
	
_Restarte the service and checked the status_
	
	- systemctl restart vsftpd
	- systemctl status vsftpd
	
_Eddited the list_
	
	- vim /etc/vsftpd.chroot_list
	<user1> <user2> <...>
	
_We now can use a program like FileZilla to download and upload files through the FTP protocol. We should strengthen it, though_

----------------------------------------------------------------------

### Strengthening FTP with SSL/TLS

_Created a self-signed cert, valid for 365 days_
	
	- cd /etc/ssl/private
	- openssl req -x509 -nodes -newkey rsa:2048 -keyout vsftpd.pem -out vsftpd.pem -days 365
	
_Added in my details and changed the permissions of vsftpd.pem_
	
	- chmod 600 vsftpd.pem
	
_Edited the configuration file (around line +150)_
	
	- vim /etc/vsftpd.conf
	
	rsa_cert_file=/etc/ssl/private/vsftpd.pem
	rsa_private_key_file=/etc/ssl/private/vsftpd.pem
	ssl_enable=YES
	ssl_ciphers=HIGH
	ssl_tlsv1=YES
	ssl_sslv2=NO
	ssl_sslv3=NO
	force_local_data_ssl=YES
	force_local_logins_ssl=YES
	
_Check to see if all is running well_
	
	- systemctl restart vsftpd
	- systemctl status vsftpd
	
_We now can access in a more secure fashion, using FTP_

----------------------------------------------------------------------

# Adding an SSH Agent, in order to have the SSH passphrase asked only once, per session
# Checking if an agent is running. If it isn't, a new one will start

- eval "$(ssh-agent -s)"

# Adding our SSH (private) key to the agent

- ssh-add /root/.ssh/id_rsa

# Note: take care not to enter the system-wide pairs at /etc/ssh. We want the pairs that are inside our home folder (in this case, the root's).

# Verify that the keys have been added

- ssh-add -l

# Configure the SSH client (this should be working by default, but it doesn't hurt). Edit or create the file ~/.ssh/config

Host *
    AddKeysToAgent yes

# Making sure that the file has the correct permissions (readable only by this user)

- chmod 600 ~/.ssh/config

# And that's it. Now the Agent will request once and never again until the terminal restarts.


----------------------------------------------------------------------

# Configuring the Newtork

