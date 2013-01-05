# Verification de ./Range_Mes_Photos.sh
[42] (!)  ./Range_Mes_Photos.sh  [OK]
[43] (!)  ./Range_Mes_Photos.sh -d [OK]
[44] (!)  ./Range_Mes_Photos.sh -d photos [OK]
toto n'est pas un fichier
[45] (!)  ./Range_Mes_Photos.sh toto [OK]
toto n'est pas un repertoire
[46] (!)  ./Range_Mes_Photos.sh -d toto photos/Arbres.JPG [OK]
[47]     ./Range_Mes_Photos.sh _Arbres.JPG _Souvenirs.JPG; test -f
2012/11/Wangenbourg/_Arbres.JPG -a -f 2012/11/Wangenbourg/_Souvenirs.JPG  [OK]
[48]     ./Range_Mes_Photos.sh -d exemple _Arbres.JPG _Souvenirs.JPG; test -f
exemple/2012/11/Wangenbourg/_Arbres.JPG -a -f exemple/2012/11/Wangenbourg/_Souvenirs.JPG  [OK]

