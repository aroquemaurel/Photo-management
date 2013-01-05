#!/bin/sh
# -*- coding: UTF8 -*-

# Constantes
UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"

# Déclaration variables
returnCode=3

if `$UTIL/./haveArgument.sh -d` 
then
	haveArgumentDirectory=0
else
	haveArgumentDirectory=1
fi

# Retourne 0 si le nombre d'arguments du programme est correct
haveGoogNbArguments() {
	if [ $# -lt 1 ]
	then
		return 1
	elif `$UTIL/./haveArgument.sh -d $* && test $# -lt 3`
	then
		return 1
	else
		return 0
	fi
}

getDirectory() {
	if [ $1 = '-d' ]
	then
		haveArgumentDirectory=0
		directory=$2
	else
	haveArgumentDirectory=1
		directory="."
	fi
}

if ! haveGoogNbArguments $*
then
	exit 1
fi

getDirectory "$@"

if ! `$UTIL/./isAccessibleDirectory.sh "$directory"`
then
	exit 2
fi

if [ $haveArgumentDirectory -eq 0 ]
then
	shift 2
fi

for file 
do
	if ! `$UTIL/./isAccessibleFile.sh "$file"`
	then
		continue
	fi
	
	if ! `$UTIL/./isImage.sh $file`
	then
		continue
	fi

	returnCode=0
	./Range_selon_date_et_description.sh "$file" "$directory"
done

exit $returnCode
