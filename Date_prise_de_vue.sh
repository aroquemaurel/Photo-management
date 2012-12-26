#!/bin/sh
# -*- coding: UTF8 -*-

#TODO supprimer les -o de la boucle
# Constantes
UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"

haveGoogNbArguments() {
	if [ $# -eq 0 -o $# -eq 1 -a "$1" = "-o" ]
	then
		return 1
	else
		return 0
	fi
}
# Initialisation de toutes les variables
chronologiqueView=1
listArguments="$*"
display=""
dateTime=""

# Si on a mis un -o en début ou fin des arguments
if `$UTIL/./haveArgument.sh -o $*`
then
	chronologiqueView=0 
fi

if ! haveGoogNbArguments $*
then
	exit 1
fi

for arguments
do
	if [ "$arguments" != "-o" ]
	then
		if `$UTIL/./isAccessibleFile.sh $arguments`
		then
			dateTime=`$UTIL/./getTaken.sh "$arguments"`
			display="$display $arguments: $dateTime\n" 
		else
			exit 3
		fi 
	fi
done

if [ $chronologiqueView ]
then
	echo $display | sort -t ':' -i -k 2
else
	echo $display 
fi

exit 0
