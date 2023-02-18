#!/bin/bash

for i in $*
do
	if [ "$i" == "--path" ]
	then
		INSPATH=$(echo $@ | awk '{ print $NF }')
		echo "$INSPATH"
	fi

done
