#!/usr/bin/env bash

my_var='x'
my_other_var=1

echo $my_var
echo $my_other_var

# Basic if statements

if [[ $my_var == 'y' ]]; then
	echo "$my_var is y."
	exit 3
elif [[ $my_var == 'x' ]]; then
	echo "$my_var is x."
	exit 0
else
	echo "Boop!"
	echo 55
fi

# 


