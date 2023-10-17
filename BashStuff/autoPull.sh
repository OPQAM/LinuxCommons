#!/bin/bash

# Specifying the stderr and stdout log files
bad_log_file="/home/opqam/PROJECTS/SCRIPTS/logfile_err.txt"
good_log_file="/home/opqam/PROJECTS/SCRIPTS/logfile_ok.txt"

# Adding the current date
current_date=$(date '+%Y-%m-%d %H:%M:%S')

# Appending the date to the log files
echo "[$current_date] Log entry" >> "$bad_log_file"
echo "[$current_date] Log entry" >> "$good_log_file"


# Appending the logs
exec 2>> "$bad_log_file"
exec 1>> "$good_log_file"

# The pulls, with disabled verbosity (-q)
git --git-dir=/home/opqam/PROJECTS/LinuxCommons.git pull -q origin master
git --git-dir=/home/opqam/PROJECTS/MigratingCoconuts.git pull -q origin master
git --git-dir=/home/opqam/PROJECTS/edoC.git pull -q origin master
git --git-dir=/home/opqam/PROJECTS/Documentation.git pull -q origin master
git --git-dir=/home/opqam/PROJECTS/Belters.git pull -q origin master
git --git-dir=/home/opqam/PROJECTS/Pocket-Lab.git pull -q origin master
