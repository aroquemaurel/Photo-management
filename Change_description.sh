#!/bin/sh
# -*- coding: UTF8 -*-

UTIL="util"
TAGDESCRIPTION="Exif.IMageDescription"

haveGoogNbArguments() {
	if [ ! $# -eq 2 ]
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

exiv2 -M"set Exif.Image.ImageDescription charset=Ascii $2" $1 

exit 0

