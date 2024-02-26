#!/bin/bash

# Let's do arrays

myFruit=("banana" "apple" "cherry" "orange")

# Accessing the array I just created:
echo "${myFruit[0]}"
echo "${myFruit[1]}"
echo "${myFruit[2]}"
echo "${myFruit[3]}"

# Accessing the number of elements in the array (length)
echo "${#myFruit[@]}"


# Accessing the whole array (all the elements)
echo "${myFruit[@]}"

# Using this idea, with a for loop
for element in "${myFruit[@]}"; do
	echo "$element"
done

# We can easily append elements to our array:
myFruit+=("kiwi" "strawberry")   # Note the parenthesis! '('

echo "Let's check our new array:"

for i in "${myFruit[@]}"; do
	echo "$i"
done
