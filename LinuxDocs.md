Documentation

# This doc holds the changes to a simple Debian 12 Server installation
# I'm using a Virtual Box machine, but this would work in bare metal

# Specifics:

. Base Memory: 4096 MB
. Storage: 20,00 GB

----------------------------------------------------------------------

# Created the user, and added passwords to both user and root

# Made sure all is up to date (updates automatically with -y)
- apt update -y && apt upgrade

# Installed Vim, a I prefer it over nano
- apt install vim

# Virtual Box Guest Additions
# Mounted the Guest Additions .iso (unsure this helps in this build)
- mount /dev/cdrom /mnt
- ls -l /mnt

# Installed needed packets to run the additions
- apt install dkms linux-headers-$(uname -r) build-essential

# Installed Guest Additions and rebooted the system
- sh /mnt/VBoxLinuxAdditions.run
- systemctl reboot -l

----------------------------------------------------------------------

# Installing and configuring basic SSH
- apt install ssh

#Configuring sshd_config
- vim /etc/ssh/sshd_config

# Uncommented #Port 22 and kept that number for now.
# Added one allowed user (my own). This line was created at the end
AllowUsers <my_user>

# If we want to give access to root, we have to add them to that line
# But we also have to edit 'PermitRootLogin prohibit-password' to
# 'PermitRootLogin yes'. I'm not doing that right now.

#After having done this, we should guarantee there are no extra spaces
# Save our configuration (Esc + :wq + enter)
# And restart the service
- systemctl restart ssh

# We can also see if the system is running correctly
- systemctl status ssh

# If an error does occur, we can check it out with
- journalctl -xe

# Now we can install a program like putty and connect to our machine
# using whatever user we have allowed
----------------------------------------------------------------------

# Version Control

# Installing git
- apt install git

# Adding our ID to git
- git config --global user.mail "<my_email@protonmail.com>"
- git config --global user.name "my_name"

# Creating a dotfiles folder
- mkdir /home/my_user/dotfiles

# In order to have a dotfiles folder controlling files outside of that
# folder, we need to use symbolic links (to the file we want)
- ln -s /etc/ssh/sshd_config sshd_config

# Adding our specific file to our dotfiles folder
- git init
- git add sshd_config
- git commit -m "Added symbolic link to sshd_config"

# Checking if all is correct with status and logs(git hash here)
- git status
- git log

# Reverting to a previous version
- git revert <commit-hash>

# This will revert back to a previous commit while keeping the other
# snapshots. Git reset will remove commits after that point on
- git reset --hard <commit-hash> 

# creating an untracked README.md to explain what this fodler is for
- echo "This folder keeps track of important dotfiles" > README.md

# By default, README.md won't be tracked. But we can guarantee it
- echo "README.md" > .gitignore
- git add .gitignore
- git commit -m "Added a README.md and a .gitignore files"

----------------------------------------------------------------------

# Configuring FTP

# Installing vsftpd and adding it to version control + extra backup
- apt install vsftpd
- cd /home/my_user/dotfiles
- ln -s /etc/vsftpd.conf
- git add vsftpd.conf
- git commit -m "Added symbolic link to vsftpd.conf"
- cp /etc/vsftpd.conf /etc/vsftpd.BAK

# Changing port number (on a new line)
- vim /etc/vsftpd.conf
listen_port=<someOtherNumber>

# Allow for both uploads and downloads (all below: uncomment or add)
write_enable=YES

# Limiting user access to their homefolder only
chroot_local_user=YES
allow_writeable_chroot=YES

# Setting which users have access to all + which file decides that
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list

# Edditing the list
- vim /etc/vsftpd.chroot_list
<user1> <user2> <...>

# We now can use a program like FileZilla to download and upload
# files through the FTP protocol. We should strengthen it, though

----------------------------------------------------------------------

# Strengthening FTP with SSL/TLS

# Creating a self-signed cert, valid for 365 days
- cd /etc/ssl/private
- openssl req -x509 -nodes -newkey rsa:2048 -keyout vsftpd.pem -out
vsftpd.pem -days 365

# Add in your details and change the permissions of vsftpd.pem
- chmod 600 vsftpd.pem

# Editing the configuration file (around line +150)
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

# Check to see if all is running well
- systemctl restart vsftpd
- systemctl status vsftpd

# We now can access in a more secure fashion, using FTP

----------------------------------------------------------------------

# Configuring the Newtork

