#!/usr/bin/env bash

# Strict mode #


#set -e             # Exiting on error
#set -u             # Exiting on an unset variable
#set -o pipefail    # Exiting on a pipe fail

#If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status,
#   or zero if all commands in the pipeline exit successfully. This option is disabled by default.

# this is an unset variable
unset variable1

# this will not work, since I don't have permissions to write to this file. 'set -e' will stop here.
echo things > /home/ricardo/NOTES/PROJECTS/LinuxCommons/BashStuff/YetAnotherCourse/untouchable

# With 'set -u' my code breaks here since I'm trying to use an unset variable
echo "$variable1"


# If there is no set builtin defined, this will run
echo "This shouldn't run."
