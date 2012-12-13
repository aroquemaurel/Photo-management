#!/bin/sh
# -*- coding: UTF8 -*-

# Si on a mis un -o en début ou fin des arguments
lastArgumentVar="$`echo $#`"
lastArgument=`eval echo $lastArgumentVar`

if [ $1 = "-o" -o $lastArgument = "-o" ] 
then
	echo "test"
else
	echo "pastest"
fi
