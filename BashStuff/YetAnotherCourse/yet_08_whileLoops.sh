#!/bin/bash


numbr=0

while true; do
	echo "My number is: $numbr"
	((numbr++))
	if [[ "$numbr" == 100001 ]]; then
		sleep 2
		echo "Cultivate a stoic calmness."
		sleep 1
		break
	fi
done



