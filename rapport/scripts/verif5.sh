# Verification de ./Range_selon_date_et_description.sh
[28] (!)  ./Range_selon_date_et_description.sh  [OK]
[29] (!)  ./Range_selon_date_et_description.sh -c [OK]
[30] (!)  ./Range_selon_date_et_description.sh -a [OK]
-a n'est pas un fichier
[31] (!)  ./Range_selon_date_et_description.sh -c -a [OK]
toto n'est pas un fichier
[32] (!)  ./Range_selon_date_et_description.sh toto [OK]
tutu n'est pas un repertoire
[33] (!)  ./Range_selon_date_et_description.sh photos/Arbres.JPG tutu [OK]
[34]       test `./Range_selon_date_et_description.sh -a photos/Arbres.JPG` =
"2012/11/Wangenbourg" -o `./Range_selon_date_et_description.sh -a photos/Arbres.JPG` =
"./2012/11/Wangenbourg" [OK]
[: 137: Illegal number: 0 
[35]       ./Range_selon_date_et_description.sh -c "photos/Arbres.JPG"; test -d
2012/11/Wangenbourg -a -w 2012/11/Wangenbourg -a -r 2012/11/Wangenbourg -a -x
2012/11/Wangenbourg [OK]
[: 137: Illegal number: 0 
[36]       ./Range_selon_date_et_description.sh -c "photos/Arbres.JPG"; test -d
2012/11/Wangenbourg -a -w 2012/11/Wangenbourg -a -r 2012/11/Wangenbourg -a -x
2012/11/Wangenbourg [OK]
[37]       ./Range_selon_date_et_description.sh "photos/Arbres.JPG";test -f
2012/11/Wangenbourg/Arbres.JPG [OK]
[38]       ./Range_selon_date_et_description.sh "photos/Souvenirs.JPG";test -f
2012/11/Wangenbourg/Souvenirs.JPG [OK]
Vous n'avez pas les droits de lecture sur photos/Arbres.JPG
[39] (!) chmod u-r "photos/Arbres.JPG"; ./Range_selon_date_et_description.sh -a
photos/Arbres.JPG [OK]
[40]     cp photos/Arbres.JPG _Arbres.JPG;./Change_description.sh _Arbres.JPG "espace
et'";./Range_selon_date_et_description.sh "_Arbres.JPG"; test -f
2012/11/espace_et_/_Arbres.JPG  [OK]
[41]     cp photos/Arbres.JPG _Arbres.JPG;./Change_description.sh _Arbres.JPG
"";./Range_selon_date_et_description.sh "_Arbres.JPG" test -f 2012/11/_Arbres.JPG  [OK]

