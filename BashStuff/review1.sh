#!/bin/bash

# This is just a quick review of BASH code.
# Unfortunately I've had to study many other things and BASH
# has suffered a bit from it. So, this is a very personal review
# to remind myself of how BASH works.
#
# This program won't make much sense other than as a review attempt.


myVar=33
myVar=32
echo $myVar             # pay attention. Linux is case-sensitive

myAge=45
readonly myAge          # now I can't change this value

myAge=33                # this will issue a read-only warning
echo $myAge

unset myVar             # this wouldn't work with a readonly var
echo $myVar             # here it unsets myVar, emptying it

# Local variables
Number=4            # this is a global variable

setNumber() {
	local Number=77
	echo "My current local variable 'Number' is $Number"
}
setNumber           # calling the function

# As we can see, the global variable hasn't been changed:
echo "My global variable 'Number' is $Number"

