
#! /bin/sh

verif()
{
  optionverif="$1"
  scriptverif="$2"

  shift 2
  retourverif=0
  for param
  do
    $scriptverif $param >/dev/null #2>/dev/null

    if [ $optionverif $? -eq 0 ]
    then
      if [ ! "$optionverif" ]
      then
        echo "[$cpt]     $text `echo $scriptverif|sed -e 's/^ *eval//g'` $param [OK]"
      else
        echo "[$cpt] ($optionverif) $text `echo $scriptverif|sed -e 's/^ *eval//g'` $param [OK]"
      fi
    else
      /bin/echo -e "\033[01;31m[$cpt] $text `echo $scriptverif|sed -e 's/^ *eval//g'` $param [ERREUR]\033[0m"
      retourverif=1
      nberreur=`expr $nberreur + 1`
    fi
    cpt=`expr $cpt + 1`
  done

  return $retourverif
}

renomer()
{
  nom=`basename "$1"|sed -e 's/\.[a-zA-Z]*$//g'`
  if [ ! -f "$1" ]
  then
    #echo $nom
    #echo mv "$repphotos/"`ls $repphotos| grep "$nom"` "$fichier"
    mv "$repphotos/"`ls $repphotos| grep "$nom"` "$fichier"
  fi
}

existe()
{
  if [ ! -f "$1" -o ! -x "$1" ]
  then
    /bin/echo -e "\033[01;31m# $1 n'existe pas ou est protege en execution \033[0m" >&2
    nberreur=`expr $nberreur + 1`
    return 1
  fi
  /bin/echo -e "\033[01;32m# Verification de $1\033[0m"
  if [ "$parchive" ]
  then
    tar -xjf "$archive"
  fi

  return 0
}

erreur()
{
  cat >&2 <<sep
  USAGE  : $0 [-a] [repertoire_photos]
           $0 doit etre dans le meme repertoir que vos scripts
  OPTION : -a
          Extraction des photos ($archive) avant la verification de chaque script
  RETOUR :
          Nombre d'erreurs
sep
}


###-------------------------------------------###
#debut du script

rep=.
if [ $# -eq 0 ]
then
  repphotos=photos
elif [ $# -eq 1 ]
then
  if [ "$1" = "-a" ]
  then
    parchive="Oui"
    repphotos=photos
     if [ ! -d photos ]
     then
      mkdir photos
     fi
  else
    repphotos="$1"
  fi
elif [ $# -eq 2 -a "$1" = "-a" ]
then
  parchive="Oui"
  repphotos="$2"
else
  erreur
  exit 2
fi

archive="photos.tar.bz2"
fichier="$repphotos/Arbres.JPG"
fichier1="$repphotos/Souvenirs.JPG"

if [ "$parchive" = "Oui" -a \( ! -f "$archive" -o ! -r "$archive" \) ]
then
 echo "$archive n'est pas accessible !!!">&2
 exit 1
fi

if [ ! -d "$repphotos" -o ! -r "$repphotos" -o ! -x "$repphotos" ]
then
  echo "$repphotos n'est pas accessible !!!">&2
  exit 1
fi

cpt=1
nom=`basename $fichier .JPG`
nberreur=0

/bin/echo -e "\n\033[01;32m*** Attention : ce script de test fonctionne uniquement avec le fichier original de photos \"$archive\" !!!!\033[0m"
/bin/echo -e "\033[01;32m***             $0 utilise les codes de retour de vos scripts \033[0m"

/bin/echo -e "\n\033[01;32m########################################\033[0m"

###-------------------------------------------###
script="$rep/Date_prise_de_vue.sh"
###-------------------------------------------###
if existe "$script"
then
    verif ! "$script" "" "-o" tutu
    verif "" "$script" "$repphotos/*.JPG"

    cmd="$script $fichier| grep '2012:11:03 15:17:17'"
    verif "" eval "$cmd"
    cmd="echo \"`$script -o $fichier $fichier1`\"|grep \"$fichier.*$fichier1\""
    verif "" eval "$cmd"

    chmod u-r "$fichier"
    text="chmod u-r \"$fichier\";"
    verif ! "$script" "$fichier" "$repphotos/*.JPG"
    chmod u+r "$fichier"
    echo
fi

###-------------------------------------------###
script="$rep/Met_date_dans_nom.sh"
###-------------------------------------------###
if existe "$script"
then
    verif ! "$script" "-a" toto "\"`echo "$repphotos"/*.JPG|sed -e 's/ /" "/g'`\""

    verif "" "$script" "-a $fichier"
    cmd="$script -a $fichier | grep '\.[1-2][0-9]\{3\}-[0-1][0-9]-[0-3][0-9]_[0-2][0-9]\.[0-6][0-9]\.[0-6][0-9]'"
    verif "" eval "$cmd"
    "$script" "$fichier"
    verif ! "$script" "$repphotos/`ls $repphotos| grep "$nom"`"
    renomer "$fichier"

    chmod u-w "$fichier"
    text="chmod u-w \"$fichier\";"
    verif "" "$script" "$fichier"
    renomer "$fichier"
    chmod u+w "$fichier"

    chmod u-w "$repphotos"
    text="chmod u-w \"$repphotos\";"
    verif ! "$script" "$fichier"
    renomer "$fichier"
    chmod u+w "$repphotos"
    echo
fi

###-------------------------------------------###
script="$rep/Change_description.sh"
###-------------------------------------------###
if existe "$script"
then
    nom1=`basename $fichier`
    cp "$fichier" "_$nom1"

    text=""
    verif ! "$script" "" "toto"
    verif "" "$script" "_$nom1 tt" "_$nom1 \"\""

    chmod u-r "_$nom1"
    text="chmod u-r \"_$nom1\";"
    verif ! "$script" "_$nom1 tt"
    chmod u+r "_$nom1"


    cp "_$nom1" "_$nom"
    $script "_$nom1" super
    text="cp \"_$nom1\" \"_$nom\";$script \"_$nom1\" super;"
    verif ! "cmp \"_$nom1\" \"_$nom\"" ""
    rm "_$nom1" "_$nom"
    echo
fi

###-------------------------------------------###
script="$rep/Change_date_modif.sh"
###-------------------------------------------###
if existe "$script"
then
    text=""
    verif ! "$script" "" "toto"

    chmod u-r "$fichier"
    text="chmod u-r \"$fichier\";"
    verif ! "$script" "$fichier"
    chmod u+r "$fichier"

    chmod u-w "$fichier"
    text="chmod u-w \"$fichier\";"
    verif ! "$script" "$fichier"
    chmod u+w "$fichier"

    nom1=`basename $fichier`
    cp "$fichier" "_$nom1"
    $script "_$nom1"
    date1=`ls -l "_$nom1"| tr -s ' '| cut -f6-8 -d' '`
    date2=`$rep/Date_prise_de_vue.sh "$fichier"| tr -s ' '| cut -f2-3 -d' '`
    cmd="echo $date2| grep \" `echo $date1|cut -f3 -d' '`\" && echo $date2| grep \"`echo $date1|cut -f2 -d' '` \""
    text="cp \"$fichier\" \"_$nom1\";$script \"_$nom1\";"
    verif "" eval "$cmd"
    rm "_$nom1"
    echo
fi

###-------------------------------------------###
script="$rep/Range_selon_date_et_description.sh"
###-------------------------------------------###
if existe "$script"
then
  text=""
  verif ! "$script" "" "-c" "-a" "-c -a" toto "$fichier tutu"
  cmd="test \`$script -a $fichier\` = \"2012/11/Wangenbourg\" -o \`$script -a $fichier\` = \"./2012/11/Wangenbourg\""
  text=""
  verif "" eval "$cmd"

  cmd="$script -c \"$fichier\"; test -d 2012/11/Wangenbourg -a -w 2012/11/Wangenbourg -a -r 2012/11/Wangenbourg -a -x
2012/11/Wangenbourg"
  text=""
  verif "" eval "$cmd"
  verif "" eval "$cmd"
  rm -rf 2012

  cmd="$script \"$fichier\";test -f 2012/11/Wangenbourg/`basename $fichier`"
  text=""
  verif "" eval "$cmd"
  mv 2012/11/Wangenbourg/`basename $fichier` "$repphotos"
  rm -rf 2012

  cmd="$script \"$fichier1\";test -f 2012/11/Wangenbourg/`basename $fichier1`"
  text=""
  verif "" eval "$cmd"
  mv 2012/11/Wangenbourg/`basename $fichier1` "$repphotos"
  rm -rf 2012

  chmod u-r "$fichier"
  text="chmod u-r \"$fichier\";"
  verif ! "$script" "-a $fichier"
  chmod u+r "$fichier"

  text=""
  nom1=`basename $fichier`
  cp "$fichier" "_$nom1"
  text="cp "$fichier" "_$nom1";$rep/Change_description.sh _$nom1 \"espace et'\";$script \"_$nom1\";"

  "$rep/Change_description.sh" "_$nom1" "espace et'"
  "$script" "_$nom1"
  verif "" "test -f 2012/11/espace_et_/_$nom1" ""
  rm -rf 2012

  text=""
  nom1=`basename $fichier`
  cp "$fichier" "_$nom1"
  text="cp "$fichier" "_$nom1";$rep/Change_description.sh _$nom1 \"\";$script \"_$nom1\""

  "$rep/Change_description.sh" "_$nom1" ""
  "$script" "_$nom1"
   verif "" "test -f 2012/11/_$nom1" ""
  rm -rf 2012

  echo

fi

###-------------------------------------------###
script="$rep/Range_Mes_Photos.sh"
###-------------------------------------------###
if existe "$script"
then
  text=""
  verif ! "$script" "" "-d" "-d $repphotos" toto "-d toto $fichier"


  nom1=`basename $fichier`
  cp "$fichier" "_$nom1"
  nom2=`basename $fichier1`
  cp "$fichier1" "_$nom2"

  text="$script _$nom1 _$nom2;"
  "$script" "_$nom1" "_$nom2"
  verif "" "test -f 2012/11/Wangenbourg/_$nom1 -a -f 2012/11/Wangenbourg/_$nom2" ""
  rm -rf 2012

  nom1=`basename $fichier`
  cp "$fichier" "_$nom1"
  nom2=`basename $fichier1`
  cp "$fichier1" "_$nom2"
  mkdir exemple

  text="$script -d exemple _$nom1 _$nom2;"
  "$script" -d exemple "_$nom1" "_$nom2"
  verif "" "test -f exemple/2012/11/Wangenbourg/_$nom1 -a -f exemple/2012/11/Wangenbourg/_$nom2" ""
  rm -rf exemple

fi
exit $nberreur
