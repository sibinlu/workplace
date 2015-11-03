#!/bin/sh

DATA_SRC=$1
DATA_DEST=$2

if [[ $(csrutil status) =~ " disabled" ]]
then
	echo "Permission Needed:"
	sudo cp "$1" "$2"
	echo "Done"
else
	echo "Error: No Permission To Continue: disable csrutil settings in recovery mode"
fi
