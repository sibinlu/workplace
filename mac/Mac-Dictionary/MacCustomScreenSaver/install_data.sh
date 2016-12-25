#!/bin/sh

DATA_SRC=$1
DATA_DEST=$2

if [[ $(csrutil status) =~ " disabled" ]]
then
	echo "Installing Data into $DATA_DEST".
	sudo cp "$1" "$2"
	echo "Done"
else
	echo "Error: No Permission To Continue: disable csrutil settings in recovery mode"
	echo "#########"
    echo "You may face the SIC issue for Mac OS after 10.11"
    echo "SIC: System Integrity Protection"
	echo ""
	echo "To disable it temporarily:"
	echo "1. boot into recovery mode: restart your Mac and hold Command+R as it boots."
	echo "2. Utility -> Terminal"
	echo "3. csrutil status"
	echo "4. Now Make it :  csrutil disable"
	echo "5. after you finished your task : csrutil enable"
fi
