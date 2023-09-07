Documentation

# This doc holds the changes to a simple Debian 12 Server installation
# I'm using a Virtual Box machine, but this would work in bare metal

# Specifics:

. Base Memory: 4096 MB
. Storage: 20,00 GB

---------------------------------------------------------------------- (standard print)

# Created the user, and added passwords to both user and root

# Made sure all is up to date (updates automatically with -y)
. apt update -y && apt upgrade

# Installed Vim, a I prefer it over nano
. apt install vim

# Virtual Box Guest Additions
# Mounted the Guest Additions .iso (unsure this helps in this build)
. mount /dev/cdrom /mnt
. ls -l /mnt

# Installed needed packets to run the additions
. apt install dkms linux-headers-$(uname -r) build-essential

# Installed Guest Additions and rebooted the system
. sh /mnt/VBoxLinuxAdditions.run
. systemctl reboot -l

----------------------------------------------------------------------

# Installing and configuring basic SSH
. apt install ssh

#Configuring sshd_config
. vim /etc/ssh/sshd_config

# Uncommented #Port 22 and kept that number for now.
# Added one allowed user (my own). This line was created at the end
- AllowUsers <my_user>

# If we want to give access to root, we have to add them to that line
# But we also have to edit 'PermitRootLogin prohibit-password' to
# 'PermitRootLogin yes'. I'm not doing that right now.

#After having done this, we should make sure there are no extra spaces
# Save our configuration (Esc + :wq + enter)
# And restart the service
. systemctl restart ssh

# We can also see if the system is running correctly
. systemctl status ssh

# If an error does occur, we can check it out with
. journalctl -xe

# Now we can install a program like putty and connect to our machine
# using whatever user we have allowed
----------------------------------------------------------------------

# Version Control

# Installing git
. apt install git

# Adding our ID to git
. git config --global user.mail "<my_email@protonmail.com>"
. git config --global user.name "my_name"

# Creating a dotfiles folder
. mkdir /home/my_user/dotfiles

# In order to have a dotfiles folder controlling files outside of that
# folder, we need to use symbolic links (to the file we want)
. ln -s /etc/ssh/sshd_config sshd_config

# Adding our specific file to our dotfiles folder
. git init
. git add sshd_config
. git commit -m "Added symbolic link to sshd_config"

# Checking if all is correct (status and logs)
. git status
. git log

# creating an untracked README.md to explain what this fodler is for
. echo "This folder keeps track of important dotfiles" > README.md

# By default, README.md won't be tracked. But we can guarantee it
. echo "README.md" > .gitignore
. git add .gitignore
.git commit -m "Added a README.md and a .gitignore files"

----------------------------------------------------------------------

# Configuring FTP


