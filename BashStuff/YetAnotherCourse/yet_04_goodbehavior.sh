#!/usr/bin/env bash

# Strict mode #


#set -e             # Exiting on error
#set -u             # Exiting on an unset variable
set -o pipefail    # Exiting on a pipe fail

#If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status,
#   or zero if all commands in the pipeline exit successfully. This option is disabled by default.

# this is an unset variable
unset variable1

# this will not work, since I don't have writting permissions to this file. 'set -e' will stop here.
echo things > /home/ricardo/NOTES/PROJECTS/LinuxCommons/BashStuff/YetAnotherCourse/untouchable

# With 'set -u' my code breaks here since I'm trying to use an unset variable
echo "$variable1"

function fail_function() {
	echo "Failing here"
	return 1
}

# pipeline
fail_function | echo "Second command"

# Checking what is the return value of the pipeline
if [ $? -eq 0 ]; then
	echo "Pipeline succeeded"
else
	echo "Pipeline failed"
fi

# Note the different results depending if 'set -o pipefail' is on or off.
# Note also that this set won't actually stop the script. We need 'set -e'
# to exit on an error.

# If there is no set (-e or -u) builtin defined, this will run
echo "This shouldn't run."
