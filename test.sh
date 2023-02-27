#!/bin/bash


numbers=("c" "a" "b" "n" "r" "d")	
index=1
for i in ${numbers[@]}
do
	if [ "$i" == "a" ]
	then
		echo $index
		break
	fi
index=$((index+1))
done	

echo ${numbers[$((index-1))]}
