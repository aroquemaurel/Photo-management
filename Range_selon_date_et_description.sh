#!/bin/sh
# -*- coding: UTF8 -*-

# Constantes
UTIL="util"
TAGDATETIME="Exif.Photo.DateTimeOriginal"

# Déclaration variables
optionTiretC=1
optionTiretA=1
file=1
directoriesPath=1

if [ $# -eq 3 ]
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
	elif `$UTIL/./haveArgument.sh -c $* && test $# -lt 2`
	then
		return 1
	elif `$UTIL/./haveArgument.sh -a $* && test $# -lt 2`
	then
		return 1
	elif [ $# -gt 3 ]
	then
		return 1
	else
		return 0
	fi
}

#Remplace caractères alpha numériques( , ', ", \, par _ du paramètre $1 dans $return
replaceAlphanumericByUnderscore() {
	return=`echo "$1"|sed "s/\([ |'|\"|\\]\)/_/g"` 
}

# Quitte le programme avec le code de retour 2 si le répertoire n'est pas accesible.
directoryArgumentExistAndIsWrittable() {
	if [ "$1" ] 
	then
		if ! `$UTIL/./isAccessibleDirectory.sh "$1"`
		then
			exit 2 
		fi
	fi

	return 0
}

getFileAndDirectory() {
	if [ "$1" = '-c' -o "$1" = '-a' ]
	then
		file="$2"
		if [ "$2" != "-c" -o "$2" != "-a" -o "$2" ]
		then
			directory="$3"
		fi
	else
		file="$1"
		if [ "$2" ]
		then
			directory="$2"
		fi
	fi 

	if [ ! $directory ]
	then
		directory="."
	fi
}

# Retourne la partie de la date correspondante à file suivant le premier argument
# 1 année
# 2 Mois
# 3 Jours
getGoodPartOfDate() {
	part=`expr $1 + 1`
	return=`./Date_prise_de_vue.sh "$file"|tr -s ' ' ':'|cut -f$part -d':'|sed "s/\([ ]\)//g"`
	return=`echo "$return"|sed "s/\([ ]\)//g"`
}
getDescription() {
	return=`exiv2 -g Exif.Image.ImageDescription "$file"|tr -s ' '|cut -f4- -d' '`
	replaceAlphanumericByUnderscore "$return"
	return=`echo $return|sed "s/\([ ]\)//g"`
}
getDirectoriesPath() {
	getGoodPartOfDate 1
	year=$return
	getGoodPartOfDate 2
	month=$return
	getDescription 
	description="$return"
	directoriesPath=`echo $directory/$year/$month/$description|sed "s/\([ ]\)//g"`
}

if ! haveGoogNbArguments $*
then
	exit 1
fi

# Si on a mis un -c ou -a en début ou fin des arguments
if `$UTIL/./haveArgument.sh -c $*`
then
	optionTiretC=0 
elif `$UTIL/./haveArgument.sh -a $*`
then
	optionTiretA=0
fi

getFileAndDirectory "$@"
replaceAlphanumericByUnderscore "$directory"
directory=$return

if ! `$UTIL/./isAccessibleFile.sh "$file"`
then
	exit 2
fi

if ! `$UTIL/./isImage.sh $file`
then
	exit 3
fi
directoryArgumentExistAndIsWrittable "$directory"

getDirectoriesPath
if [ $optionTiretA -eq 0 ]
then
	echo $directoriesPath
else
	mkdir -p $directoriesPath
	if [ ! $optionTiretC -eq 0 ]
	then
		mv "$file" $directoriesPath
	fi
fi



