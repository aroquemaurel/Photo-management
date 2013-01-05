#! /bin/sh
afficher=""
res=""
verif_photo(){
file -b -i $1 | grep -q image
if [ $? -eq 0 ]
then
	return 0
else
	echo "Le fichier $1 n'est pas une photo."
	return 1
fi
}


if [ $# -eq 0 ]
then
	echo "Aucun fichier en entree.">&2
	echo "Usage: $0 [-o] fichier_photo [fichier_photo ...]">&2
	exit 1
fi


if [ $1 = "-o" ]
	then
	shift
	for fichier in $*
	do
		if [ ! -f $fichier -o ! -r $fichier ]
		then
			echo "$fichier n'est pas un fichier ou est inaccessible.">&2
			exit 2
		fi
	done
	for photo in $*
	do
		verif_photo "$photo"
		if [ $? -eq 0 ]
		then
			afficher=`exiv2 $photo | grep "Image timestamp" | cut -c19-29`
			res="$photo: $afficher"
			echo $res | sort -k 2
		fi
	done
	exit 0
else
	for fichier in $*
	do
		if [ ! -f $fichier -o ! -r $fichier ]
		then
			echo "$fichier n'est pas un fichier ou est inaccessible.">&2
			exit 3
		fi
	done
	for photo in $*
	do
		verif_photo "$photo"
		if [ $? -eq 0 ]
		then
			afficher=`exiv2 $photo | grep "Image timestamp" | cut -c19-29`
			echo "$photo:" $afficher
		fi
	done
	exit 0
fi

exit 0
