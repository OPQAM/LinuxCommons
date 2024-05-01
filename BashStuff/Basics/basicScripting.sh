#!/bin/bash

# Adding attributes to variables:

declare -i z=333                   # (-i => integer)
declare -r f=354                   # (-r => read-only)
declare -l f="WhateverMAN"         # (-l => lower-case)
declare -u b="WhateverMan"         # (-u => upper-case)

# Built-in variables:

$MACHTYPE     (returns the machine type)
$BASH_VERSION (returns the bash version)
$SECONDS      (number of seconds the bassh session has been running)

# More variables to be found at:
# http://tldp.org/LDP/abs/html/internalvariales.html

#We can run commands that are assigned to variables. We can assign them thusly. Using pwd as an example:
#
x=$(pwd)
echo $x

# 16:16
