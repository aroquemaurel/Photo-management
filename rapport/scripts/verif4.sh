# Verification de ./Change_date_modif.sh
[23] (!)  ./Change_date_modif.sh  [OK]
toto n'est pas un fichier
[24] (!)  ./Change_date_modif.sh toto [OK]
Vous n'avez pas les droits de lecture sur photos/Arbres.JPG
[25] (!) chmod u-r "photos/Arbres.JPG"; ./Change_date_modif.sh photos/Arbres.JPG [OK]
Vous n'avez pas les droits d'écriture sur le fichier
[26] (!) chmod u-w "photos/Arbres.JPG"; ./Change_date_modif.sh photos/Arbres.JPG [OK]
[27]     cp "photos/Arbres.JPG" "_Arbres.JPG";./Change_date_modif.sh "_Arbres.JPG";  echo 
2012:11:03 15:17:17| grep " 15:17" && echo 
2012:11:03 15:17:17| grep "3 " [OK]

