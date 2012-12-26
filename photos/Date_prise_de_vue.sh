#! /bin/sh


	if [ "$#" -eq 0 -o "$#" -eq 1 -a "$1" = "-o" ]
	then
		echo "USAGE: $0 [-o] fichier_image [fichier_image…]">&2
		exit 1
	fi
	
	for i
	do
		if [ "$i" != "-o" -a ! -f "$i" -o ! -r "$i" -o ! -x "$i" ]
		then
			echo "$i n'a pas pu etre ouvert, il ne possede pas les droits de lecture et/ou d'ecriture ou n'est pas un fichier">&2
		else
			annee=`exiv2 $i | grep 'Image timestamp' | cut -f4 -d' ' | cut -f1 -d':'`
			mois=`exiv2 $i | grep 'Image timestamp' | cut -f3 -d':'`
			jour=`exiv2 $i | grep 'Image timestamp' | cut -f4 -d' ' | cut -f3 -d':'` 
				
			echo "Exif.$i.$jour:$mois:$annee"
		fi 
	done
	
	exit 0

