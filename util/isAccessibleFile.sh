#!/bin/sh
# -*- coding: UTF8 -*-

if [ ! -f $1 ]
then
	echo "$1 n\'est pas un fichier" >&2
	exit 1
fi

if [ ! -r $1 ]
then
	echo "Vous n\'avez pas les droits de lecture sur $1" >&2
	exit 2
fi

#if [ ! -x $1 ]
#then
#	echo Vous n avez pas les droits d\'execution sur $1 >&2
#	exit 3
#fi

exit 0
