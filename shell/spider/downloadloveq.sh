user="sibinlu"
password="ss60742"

prefix="http://dl.loveq.cn/live/program/"
fprefix="LoveQ.cn_"
finishlist="finishlist"

weeks=2

CURLUSER="-u "$user":"$password
echo $CURLUSER

# 0 : Success;   1 : Fail;      2: Fail & Delete;
function geturl()
{
  if [ ! -n $1 ]; 
  then
    echo 'No Url to crawl'
    return 1
  fi

  local code=0

  while [ $code -ne 416 ] #[ $code -ne 200 ] && [ $code -ne 206 ]
  do
    code=$(curl -l -w %{http_code} --retry 1 -C - -O $CURLUSER $1)
	if [ $code -eq 200 ] || [ $code -eq 206 ];
	then
		#echo 'Success: ' $code
		echo 'Check File Integrity: ' $code
		#return 0;
    else 
		if [ $code -eq 416 ];
		then
			#echo 'File May Exist: ' $code
			echo 'Check Sucess: ' $code
			return 0;
		else
			if [ $code -eq 404 ];
			then 
				echo 'File not Exist on Server: ' $code
				return 2;
			else
				echo 'Fail & Retry: ' $code
			fi
		fi
    fi  
  done
}

function downloadmp3()
{
	#
	if [ -f $finishlist ];
	then 
		#echo "list exist"
		. $finishlist
	else
		fl=()
	fi
	#

	local file=$fprefix$1"-"$2".mp3"


	#
	if [ -f $file ];
	then 
		#echo "file exist: " $file
		local found=0
		for s in "${fl[@]}"
		do
			if [[ $s == $file ]]
			then
				echo "No need to download " $file 
				return;
			fi
		done
	fi
	#

	local url=$prefix$file
	echo "Start Downloading : " $url
	geturl $url

	local ref=$?
	if	[ $ref -eq 2 ]
	then
		rm $file
	fi

	if [ $ref -eq 0 ]
	then
		fl+=( $file )
		set | grep ^fl > $finishlist
	fi
}

function downloadlastweek()
{
	index=$1
    w=$(date +%w)
	interval_sun=$[ $w + $index * 7] 
	interval_sat=$[$interval_sun + 1]
	o_sun="-v-"$interval_sun"d"
	o_sat="-v-"$interval_sat"d"
	sun=$(date $o_sun +%F)
	sat=$(date $o_sat +%F)

	downloadmp3 $sat "1"
	downloadmp3 $sat "2"
	downloadmp3 $sun "1"
	downloadmp3 $sun "2"

}

#downloadmp3 "2015-08-09" "2"
#result=$(geturl http://dl.loveq.cn/live/program/LoveQ.cn_2015-04-11-1.mp3)
#geturl http://dl.loveq.cn/live/program/LoveQ.cn_2015-08-17-1.mp3
#r=$?
#echo "r= "$r
#echo "result= " $result

for (( c=$weeks; c>=0; c-- ))
do
	downloadlastweek $c
done

echo ""
w=$(date +%w)
echo "All Done! From " $(date -v-$[ $w + $weeks * 7 + 1 ]d +%F) "  to " $(date -v-$[ $w ]d +%F)
