#!/bin/bash

# The idea is to create a simple helper function that prints out a simple explanation on how to use this script.
# So we start by creating that function:

show_help() {
	echo "Usage: review01.sh [options]"
	echo "Options:"
	echo "  --help    Show this help message"
	echo "..."
}

# Checking if '--help' was used

if [[ "$1" == "--help" ]]; then
	show_help
	exit 0
fi

# Now we can go on and introduce the rest of the script, if we want to do so

