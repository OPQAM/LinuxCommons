#!/usr/bin/env bash

my_array=(1 2 3 "a")


# Print an element
echo ${my_array[2]}

# Print all items (@)
echo ${my_array[@]}

# Print the length of the array (#)
echo ${#my_array[@]}
