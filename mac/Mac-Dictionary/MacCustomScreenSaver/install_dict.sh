#!/bin/sh

NEWDICTIONARY=$1 #"/Users/sibinlu/t.txt"
DICTIONARY_NAME=$2 #"t1.txt"
SYSTEM_DICTIONARY_PATH="/System/Library/Assets/com_apple_MobileAsset_DictionaryServices_dictionaryOSX"


if [[ $(csrutil status) =~ " disabled" ]]
then
	#echo $NEWDICTIONARY
	#echo $DICTIONARY_NAME
	search=$(find ${SYSTEM_DICTIONARY_PATH} -name "${DICTIONARY_NAME}")
	echo "Installing Dictionary to System"
	if [[ -n $search ]]
	then
		echo "System Dictionary Found:"
		target=$(echo "$search" | awk -F '\n' '{r="";s=$0;i=-1;	\
			while(i!=0){
				i=index(s,"/");	\
				r=r substr(s,1,i);	\
				s=substr(s,i+1,length(s)-i);	\
			}	\
			print r;}')
		#echo $target
		echo "copying ${NEWDICTIONARY} to ${search}"
		sudo rm -rf "$search";
		sudo ditto --noextattr --norsrc  "${NEWDICTIONARY}" "$search"
		#sudo cp -r "${NEWDICTIONARY}" "$target"
		echo "Done"
	else
		echo "ERROR: Dictionary not found"
fi
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



