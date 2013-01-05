#!/bin/sh
# -*- coding: UTF8 -*-

UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"

haveGoogNbArguments() {
	if [ $# -eq 0 -o $# -eq 1 -a "$1" = "-a" ]
	then
		return 1
	else
		return 0
	fi
}

getDateTime() {
	dateTime=`exiv2 "$1" -g $TAGDATETIME|tr -s ' ' ' ' | cut -d ' ' -f 4-5`
}

getFileNameAndExt() {
	fileNameWithoutExt=`echo $1|sed 's/\(.*\)\.[^\.]\+$/\1/'` 
	ext=`echo $1|grep -Eo '\.[^\.]+$'`
}

formatDateTime() {
	date=`echo $1|cut -d ' ' -f 1|tr -s ':' '-'`
	time=`echo $1|cut -d ' ' -f 2|tr -s ':' '.'`
	dateTime=$date\_$time
}

renameFileWithDate() {
	mv $1$3 "$1.$2$3"
}
displayFileWithDate() {
	echo "$1$3 -> $1.$2$3"
}
# Si on a mis un -a en début ou fin des arguments
if `$UTIL/./haveArgument.sh -a $*`
then
	noModify=0 
fi

if ! haveGoogNbArguments $*
then
	exit 1
fi
for arguments
do
	if [ "$arguments" != "-a" ]
	then
		#Accessibilité lecture
		if ! `$UTIL/./isAccessibleFile.sh "$arguments"`
		then
			exit 2
		fi
		if ! `$UTIL/./isImage.sh $arguments`
		then
			exit 3
		fi

		#Accesibilité ecriture répertoire parent
		if [ ! -w `dirname $arguments` ]
		then
			echo "Le repertoire n'est pas accesible en écriture" >&2
			exit 4
		fi

		
		if [ ! -w "$arguments" ]
		then
			echo "Vous n'avez pas les droits d'écriture sur le fichier" >&2
			continue
		fi
		getDateTime	"$arguments"
		formatDateTime "$dateTime"
		getFileNameAndExt "$arguments"

		if echo "$arguments"| grep '\.[0-9]*-[0-9]*-[0-9]*_[0-9]*\.[0-9]*\.[0-9]*\.'> /dev/null
		then
			echo "Le fichier $argument est déjà correctement nommé" >&2
			exit 5
		else
			if [ $noModify ]
			then
				displayFileWithDate $fileNameWithoutExt $dateTime $ext
			else 
				renameFileWithDate $fileNameWithoutExt $dateTime $ext
			fi
		fi
	fi
done

exit 0

