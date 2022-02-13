#!/bin/bash
export LANG=en.UTF-8
NUMFILES=0
NUMDIRS=-1
treef(){
	local INDENT="$1" PREFIX="$2" ROOT="$3" POS="$4"
	case "$POS" in
		nonlast) local ADDINDENT='\u2502\u00A0\u00A0\u00A0';;
		last)	 local ADDINDENT='	';;
		top)	 local ADDINDENT='';;
		*)
		    ;;
	esac
	local NEWINDENT="$INDENT$ADDINDENT"
	if ! [[ -d "$ROOT" ]]; then
	    echo -e "$INDENT$PREFIX$ROOT"
	    : $((++NUMFILES))
	else
	    : $((++NUMDIRS))
	    echo -e "$INDENT$PREFIX$ROOT"
	    local OLDPWD ="$PWD"
	    cd "$ROOT" || return 0
	    local FILE ="" NEXTFILE
	    for NEXTFILE in *;do
		   if [[ -n "$FILE" ]]; then
			   treef "$NEWINDENT" "\u251C\u2500\u2500 " "$FILE" nonlast
		   fi
		   FILE="$NEXTFILE"
	    done

	   if [[ -n "$FILE"  ]];then
		   treef "$NEWINDENT" "\u2514\u2500\u2500" "$FILE" last
	   fi
	   cd "$OLDPWD"
	fi
}
treef "" "" "${1:-.}" top
echo ''
if [$NUMDIRS -ne 1 ] && [$NUMFILES -ne 1]; then
	echo "$NUMDIRS directories, $NUMFILES files"
elif [ $NUMDIRS -eq 1] && [$NUMFILES -eq 1]; then
	echo "$NUMDIRS directory, $NUMFILES file"
elif[$NUMDIRS -eq 1] && [$NUMFILES -ne 1]; then
	echo "$NUMDIRS directory, $NUMFILES files"
elif[$NUMDIRS -ne 1] && [$NUMFILES -eq 1]; then
	echo "$NUMDIRS directories, $NUMFILES files"
fi
