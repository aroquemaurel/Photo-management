#!/bin/bash
# -*- coding: UTF8 -*-


UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"

haveGoogNbArguments() {
	if [ ! $# -eq 1 ]
	then
		return 1
	else
		return 0
	fi
}

if ! haveGoogNbArguments $*
then
	exit 1
fi

if ! `$UTIL/./isAccessibleFile.sh "$1"`
then
	exit 2
fi

if [ ! -w "$1" ]
then
	echo "Vous n'avez pas les droits d'écriture sur le fichier" >&2
	exit 2
fi


dateTime=`./Date_prise_de_vue.sh $1|tr -s ' ' |cut -f2-3 -d' '|sed "s/..$//"`
dateTime=`echo $dateTime|sed -e "s/ //g"|sed -e "s/://g"`
touch -t $dateTime $1

exit 0
