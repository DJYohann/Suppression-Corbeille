#!/bin/zsh 

nbF=0
nbD=0

for i in `seq 1 $#` ; do 	
	if [ -d $1 ] ; then
		nbD=$((nbD + 1))
	else 
		nbF=$((nbF + 1))
	fi
	mv $1 ~/.Trash/
	shift 
done

echo "Suppression de $i éléments dont $nbD dossiers et $nbF fichiers dans la corbeille"
