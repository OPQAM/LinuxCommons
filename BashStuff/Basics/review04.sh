#!/bin/bash


# Using case to set up a standard help message. As in, if all else fails, present a help message to inform the user how to deal with the 'app'

# This would be the standard
#if [ $# -eq 0 ]; then
#	echo "Usage: $0 <option>"
#	echo ""
#	echo "Possibilities = {'boop', 'bop', 'bip'}"
#	exit 1
#fi

option=$1

case $option in
	boop) 
		echo "Boop is a perfectly valid magic school."
		;;
	bop) 
		echo "You should be ashamed of yourself!"
		;;
	bip)
		echo "But does he know?..."
		;;
	*)
		echo "Usage: $0 <option>"
		echo ""
		echo "Possibilities = {'boop', 'bop', 'bip'}"
		;;
esac

