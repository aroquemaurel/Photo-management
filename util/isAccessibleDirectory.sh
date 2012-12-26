#!/bin/sh
# -*- coding: UTF8 -*-

if [ ! -d "$*" ]
then
	echo "$1 n'est pas un repertoire" >&2
	exit 1
fi

if [ ! -r "$*" ]
then
	echo "Vous n'avez pas les droits de lecture sur $1" >&2
	exit 2
fi

if [ ! -x "$*" ]
then
	echo "Vous n'avez pas le droit d'execution sur $1" >&2
	exit 2
fi

if [ ! -w "$*" ]
then
	echo "Vous n'avez pas le droit d'écriture sur $1" >&2
	exit 2
fi

exit 0

