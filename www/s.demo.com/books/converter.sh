#!/bin/bash

echo "Ubicando comandos"
GS="`which gs`"
MKDIR="`which mkdir`"
CONVERT="`which convert`"

if [ "$1" != "" ]
then
	if [ "$2" != "" ]
	then
		if [ ! -d "$1" ]
		then
			echo "Creando el directorio"
			$MKDIR $1 	
		fi

		echo "Convirtiendo pdf"
		$GS -sDEVICE=pcx256 -r150x150 -dNOPAUSE -sOutputFile=$1/%d $2
		
		for dff in $1/*
		do 
		    $CONVERT "$dff" "$dff".gif
		    rm "$dff"
		    echo "Convirtiendo (large) $dff" 
		    $CONVERT "$dff".gif -resize 1000x1294 "$dff"-large.gif
		    echo "Convirtiendo (normal) $dff" 
		    $CONVERT "$dff".gif -resize 700x906 "$dff"-normal.gif
		    echo "Convirtiendo (small) $dff" 
		    $CONVERT "$dff".gif -resize 180x233 "$dff"-small.gif
		    rm "$dff".gif
		done
	else
		echo "Ingrese el nombre del archivo a convertir"
	fi
else
	echo "Ingrese el directorio donde van a quedar las imagenes"
fi
