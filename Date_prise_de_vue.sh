#!/bin/sh
# -*- coding: UTF8 -*-

#TODO supprimer les -o de la boucle
# Constantes
UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"
# Initialisation de toutes les variables
chronologiqueView=1
listArguments="$*"
display=""

# Si on a mis un -o en début ou fin des arguments
if `$UTIL/./haveArgument.sh -o $*`
then
	chronologiqueView=0 
fi
if [ $# -eq 0 -o $# -eq 1 -a $1 = "-o" ]
then
	exit 1	
fi
for arguments
do
	if [ "$arguments" != "-o" ]
	then
		if `$UTIL/./isAccessibleFile.sh $arguments`
		then
			display="$display \n$arguments : `exiv2 $arguments -g $TAGDATETIME|tr -s ' ' ' ' |
			cut -d ' ' -f 4-5`"
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
