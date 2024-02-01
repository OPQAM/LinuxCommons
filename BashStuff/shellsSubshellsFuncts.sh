#!/bin/bash

# Using a function to change directory

pro() {

	cd /home/opqam/PROJECTS/
}

# Calling it
pro

: << 'END'

# This is kept here to show what doesn't work
# And also to remember another way to comment out text (:)

cd /home/opqam/PROJECTS/

# Why doesn't this work?
# Remember that when a script runs, it does so in another shell.
# So cd ... won't affect the shell we're in. It will affect that subshell
# a function, or a variable, on the other hand, is called and created
# in the original shell. So if we call it, we'd making modifications
# to that original shell.

END
