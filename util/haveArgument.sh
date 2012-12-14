#!/bin/sh
# -*- coding: UTF8 -*-
# Premier Argument => nom de la balise à chercher
# Argument suivant, liste dans laquelle chercher la balise.
# La balise à chercher doit être soit au début, soit à la fin des arguments.

lastArgumentVar="$`echo $#`"
lastArgument=`eval echo $lastArgumentVar`

if [ ! $2 ]
then
	exit 2
fi

if [ $2 = "$1" -o $lastArgument = "$1" ] 
then
	exit 0 
else
	exit 1
fi

