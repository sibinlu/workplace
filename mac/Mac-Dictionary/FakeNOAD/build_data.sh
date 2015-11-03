#!/bin/sh
####Duplicate for more random choises

Dup=1

RAW_DATA="$1"
#data.txt
NOAD_DATA="$2"
#NOAD_wotd_list.txt
DICT_DATA="$3"
#NOAD.xml


XMLHEAD=$"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<d:dictionary xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:d=\"http://www.apple.com/DTDs/DictionaryService-1.0.rng\">\n"
XMLEND=$"\n</d:dictionary>"
# id,title,title,title,id,content
XMLENTRY=$"<d:entry id=\"%s\" d:title=\"%s\" class=\"entry\"><d:index d:value=\"%s\"/><span class=\"hg\"><span d:dhw=\"1\" role=\"text\" class=\"hw\">%s</span><span class=\"gp tg_hg\"></span></span><span class=\"sg\"><span class=\"se1\"><span d:abs=\"1\" id=\"%s.001\" class=\"msDict t_core\"><span role=\"text\" class=\"df\">%s</span></span></span></span></d:entry>\n"

#HTMLENCODE="sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'\"'\"'/\&#39;/g; s/ /\&nbsp;/g' <<< "
HTMLENCODE="sed 's/ /\&nbsp;/g' <<< "


#########
data=$(cut -f1 -f2 data.txt)
echo "$data" > ${NOAD_DATA}

[[ $Dup -eq 1 ]] && echo "$data" >> ${NOAD_DATA}
echo "Completed With " ${NOAD_DATA}


#######
#awk -v head="$XMLHEAD" -v end="$XMLEND" -v entry="$XMLENTRY" -v encode="$HTMLENCODE" -F $'\t' 'BEGIN{print head} \
#	{   cmd2="sed 's/ /\&nbsp;/g' <<< " $2;		\
#		cmd3="sed 's/ /\&nbsp;/g' <<< " $3;		\
#		while( cmd2 | getline line){c2=line};	\
#		while( cmd3 | getline line){c3=line};	\
#		printf entry,$1,$2,$2,c2,$1,c3}   \
#	END{print end}' data.txt > ${DICT_DATA}

function htmlencode(){
	local result=$(sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'"'"'/\&#39;/g; s/ /\&nbsp;/g' <<< "$1")
	echo "$result"
	return 1
}

testtest=$(htmlencode "a b<c>d'e\"f&")
echo "$testtest"

#awk -v head="$XMLHEAD" -v end="$XMLEND" -v entry="$XMLENTRY" -v encode="$HTMLENCODE" -F $'\t' 'BEGIN{print head} {    cmd2="echo \""$2"\" | sed \"s/ /\\&nbsp;/g\""; cmd3="echo \""$3"\" | sed \"s/ /\\&nbsp;/g\""; cmd2 | getline c2; close(cmd2); while(cmd3 | getline line){c3=line}; print c2"\t"c3"\n"} END{print end}' data.txt > ${DICT_DATA} 
awk -v head="$XMLHEAD" -v end="$XMLEND" -v entry="$XMLENTRY" -v encode="$HTMLENCODE" -F $'\t' 'BEGIN{print head} 
function encode(str) {
	gsub(/\&/,"\\&amp;",str);
	#gsub(/ /,"\\&nbsp;",str);
	gsub(/</,"\\&lt;",str);
	gsub(/>/,"\\&gt;",str);
	gsub(/\"/,"\\&quot;",str);
	gsub(/'"'"'/,"\\&#39;",str);
	return str;
}
{
	c2 = encode($2);
	c3 = encode($3);
	printf entry,$1,c2,c2,c2,$1,c3;
} 
	END{print end}' data.txt > ${DICT_DATA} 
echo "Completed With " ${DICT_DATA}
