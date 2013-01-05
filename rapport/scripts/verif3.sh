# Verification de ./Met_date_dans_nom.sh
[9] (!) chmod u-r "photos/Arbres.JPG"; ./Met_date_dans_nom.sh -a [OK]
toto n'est pas un fichier
[10] (!) chmod u-r "photos/Arbres.JPG"; ./Met_date_dans_nom.sh toto [OK]
"photos/Arbres.JPG" n'est pas un fichier
[11] (!) chmod u-r "photos/Arbres.JPG"; ./Met_date_dans_nom.sh "photos/Arbres.JPG"
"photos/Fort_Foch.JPG" "photos/Fosse.JPG" "photos/Historique_du" "chateau.JPG" "photos/Les"
"Mam'zelles.JPG" "photos/Maison_jaune.JPG" "photos/Moulin_des_pres.JPG"
"photos/Panneaux_Randonnees.JPG" "photos/Plan_3D.JPG" "photos/Pont_du_chateau.JPG"
"photos/Souvenirs.JPG" "photos/Transilien.JPG" "photos/Vue_du_donjon.JPG" [OK]
[12]     chmod u-r "photos/Arbres.JPG"; ./Met_date_dans_nom.sh -a photos/Arbres.JPG [OK]
[13]     chmod u-r "photos/Arbres.JPG";  ./Met_date_dans_nom.sh -a photos/Arbres.JPG | grep
'\.[1-2][0-9]\{3\}-[0-1][0-9]-[0-3][0-9]_[0-2][0-9]\.[0-6][0-9]\.[0-6][0-9]' [OK]
Le fichier  est déjà correctement nommé
[14] (!) chmod u-r "photos/Arbres.JPG"; ./Met_date_dans_nom.sh
photos/Arbres.2012-11-03_15.17.17.JPG [OK]
Vous n'avez pas les droits d'écriture sur le fichier
[15]     chmod u-w "photos/Arbres.JPG"; ./Met_date_dans_nom.sh photos/Arbres.JPG [OK]
Le repertoire n'est pas accesible en écriture
[16] (!) chmod u-w "photos"; ./Met_date_dans_nom.sh photos/Arbres.JPG [OK]

