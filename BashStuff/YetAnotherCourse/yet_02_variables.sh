#!/usr/bin/env bash

#Setting up a default value for a variable:

name=""
echo "Hello, ${name_-"Anonymous"}!"

# The subshell ():

. (cd .. ; echo "Hello, World!"; pwd)
. pwd

# We can execute a subshell that will collapse as soon as the command ends.

# Capturing the result of a command:
# Say we wanted to have a variable obtain the actual result of the command tty. The way to achieve this is to place said command within brackets, like thus:
. my_variable=$(tty)

# Again, seriously sidetracking here, but I tried running something like this in crontab, with the intent of capturing the tty of the cron job as it is running (and then send whatever output to the current terminal - a dirty job). But it doesn't work. The cron job isn't actually running in another terminal, merely another subshell. And thus, the result of the tty capture is 'not a tty'. Indeed.
#
# If possible, move stuff like this to docs or something.
#
# By the way, this was the (nasty) cron job:

* * * * * my_var=$(/usr/bin/tty) ; echo $my_var > /dev/pts/2

# To clarify, the full path is just making sure that the tty is loaded, as cron might be running with a very limited set of tools. And /dev/pts/2 is my actual and current terminal.
# FYI, as I'm writing, my other tmux terminal is being populated with 'not a tty'. Time to shut down that cron job.

# Also, FYI, the current tmux terminal is /dev/pts/1

# WIP
--snip--


