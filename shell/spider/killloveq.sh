#!/bin/sh
lovesh=$(ps -ax | grep -e ".*sh [^\*]*downloadloveq.sh")
lovesh=${lovesh:0:5}


lovecurl=$(ps -ax | grep -e "curl .*LoveQ\.cn_[0-9]*-")
lovecurl=${lovecurl:0:5}

count=0
if [ ${lovesh} ]
then
	echo "loveqsh " ${lovesh}
	kill -9 ${lovesh}
	((count=${count}+1))
fi

if [ ${lovecurl} ]
then
	echo "lovecurl" ${lovecurl}
	kill -9 ${lovecurl}
	((count=${count}+1))
fi

counts=$([ ${count} -ge 2 ] && echo "es" || echo "" )
echo ${count}" process"${counts}" killed"
