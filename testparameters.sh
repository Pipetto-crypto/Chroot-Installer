#!/bin/bash

if [[ $(echo "$@") =~ "-d" ]]
then
	echo "Found"
else
	echo "Not found"
fi
