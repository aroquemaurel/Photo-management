########################################
# Verification de ./Date_prise_de_vue.sh
[1] (!)  ./Date_prise_de_vue.sh  [OK]
[2] (!)  ./Date_prise_de_vue.sh -o [OK]
tutu n'est pas un fichier
[3] (!)  ./Date_prise_de_vue.sh tutu [OK]
[4]      ./Date_prise_de_vue.sh photos/*.JPG [OK]
[5]       ./Date_prise_de_vue.sh photos/Arbres.JPG| grep '2012:11:03 15:17:17' [OK]
[6]       echo "
photos/Arbres.JPG: 2012:11:03 15:17:17
 photos/Souvenirs.JPG: 2012:11:03 16:02:27"|grep "photos/Arbres.JPG.*photos/Souvenirs.JPG"
 [OK]
 Vous n'avez pas les droits de lecture sur photos/Arbres.JPG
 [7] (!) chmod u-r "photos/Arbres.JPG"; ./Date_prise_de_vue.sh photos/Arbres.JPG [OK]
 Vous n'avez pas les droits de lecture sur photos/Arbres.JPG
 [8] (!) chmod u-r "photos/Arbres.JPG"; ./Date_prise_de_vue.sh photos/*.JPG [OK]

