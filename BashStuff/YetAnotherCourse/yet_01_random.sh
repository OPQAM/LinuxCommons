#!/usr/bin/env bash

# The above shebang line will make sure that we're running the best instance of bash for our system

echo "Hello, world!"

# The usual #!/bin/bash is less portable and demands that we're using bash and in that location.
# Just a heads up.

# Quick Substitution or Caret Substitution:
# So, ok... this is sidetracking the Bash course, but I learned of this today and it's fun.
#
# So, if we run a command, say:
#
# . echo "Hello world!"
# And then run:
# . ^world^WoRlD
#
# This will re-run our previous command, try to find the first instance of 'world' and substitute it for 'WoRlD'. Nice!

#Another interesting note is giving execution command on the file, but only to the user. Instead of trying to remember the exact number setting for the permissions or just writing +x, which will give execution permissions for all users, we can give said permissions to this user alone:
#
#. chomd u+x file.sh
# Principle of least privilege. This way, the group and others won't have executing permissions.



