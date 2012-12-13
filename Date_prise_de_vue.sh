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
if [ `$UTIL/./haveArgument.sh -o $*` ]
then
	chronologiqueView=0 
	for arguments
	do
		echo $arguments
	done
# TODO On trie les arguments par ordre chronologique et puis récursif
fi

for arguments
do
	display="$display \n$arguments : `exiv2 $arguments -g $TAGDATETIME|tr -s ' ' ';' | cut -d ';' -f 4`"
done

if [ $chronologiqueView ]
then
	echo $display | sort -t ':' -i -k 2
else
	echo $display 
fi
