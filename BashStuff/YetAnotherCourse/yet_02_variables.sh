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
