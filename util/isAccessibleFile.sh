#!/bin/sh
# -*- coding: UTF8 -*-

if [ ! -f "$*" ]
then
	echo "$* n'est pas un fichier" >&2
	exit 1
fi

if [ ! -r "$*" ]
then
	echo "Vous n'avez pas les droits de lecture sur $*" >&2
	exit 2
fi

exit 0

