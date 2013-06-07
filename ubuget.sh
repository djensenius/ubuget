#!/bin/sh

#################################################
#	Simple script to download files from		#
#	UBU.com.									#
#												#
#	./ubuget.sh UBUURL							#
#												#
#												#
#	2012 David Jensenius						#
#################################################


if [ $# != 1 ]; then
	echo "Please enter a UBU page to download content from."
    exit
fi

CONTENT=$(curl -s -L $1)
FILES=(`echo $CONTENT | egrep -o "(mailto|ftp|http(s)?://){1}[^'\"]+"`)
CONTENT=$(echo $CONTENT | sed -e "s/TITLE/title/g")
TITLE=$(echo $CONTENT | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}')
TITLE=$(echo $TITLE |tr / " ")
TITLE=$(echo $TITLE |tr : " ")

TITLE=$(echo $TITLE | php -r 'while(($line=fgets(STDIN)) !== FALSE) echo html_entity_decode($line, ENT_QUOTES, "UTF-8");')

mkdir "$TITLE"
cd "$TITLE"

echo $TITLE
for i in "${FILES[@]}"
do
   :
   # do whatever on $i
   if [[ $i == *.mp3 ]] || [[ $i == *.MP3 ]] || [[ $i == *.mov ]] || [[ $i == *.mp4 ]] || [[ $i == *.m4v ]] || [[ $i == *.avi ]] || [[ $i == *.pdf ]] || [[ $i == *.mpg ]]; then
   		echo "Downloading " . $i	
		curl -O $i
	fi
done