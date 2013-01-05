#!/bin/bash
# -*- coding: UTF8 -*-

if ! `file $*|grep -q "image"`
then
	echo "$* n'est pas une image" >&2
fi
