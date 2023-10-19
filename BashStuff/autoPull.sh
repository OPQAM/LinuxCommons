#!/bin/bash

# If you're going to have different SSH key-pairs on different machines, then it's
# a good idea to have this script running locally (also for minor tinkering)

# Specifying the stderr and stdout log files
bad_log_file="/home/opqam/PROJECTS/SCRIPTS/logfile_err.txt"
good_log_file="/home/opqam/PROJECTS/SCRIPTS/logfile_ok.txt"

# Adding the current date
current_date=$(date '+%Y-%m-%d %H:%M:%S')

# Appending the date to the log files
echo "[$current_date] Log entry" >> "$bad_log_file"
echo "[$current_date] Log entry" >> "$good_log_file"

# Give a couple of seconds for the system to be able to deal with the SSH agent
sleep 2

# Appending the logs
exec 2>> "$bad_log_file"
exec 1>> "$good_log_file"

# Start the SSH agent
eval $(ssh-agent -s)

# Add SSH key to the agent (this is an example. Add correct key)
ssh-add /root/.ssh/id_rsa


# The repository pulls
git --git-dir=/home/opqam/PROJECTS/LinuxCommons/.git pull origin master
git --git-dir=/home/opqam/PROJECTS/MigratingCoconuts/.git pull origin master
git --git-dir=/home/opqam/PROJECTS/edoC/.git pull origin master
git --git-dir=/home/opqam/PROJECTS/Documentation/.git pull origin master
git --git-dir=/home/opqam/PROJECTS/Belters/.git pull origin master
git --git-dir=/home/opqam/PROJECTS/Pocket-Lab/.git pull origin master
