#!bin/bash
shopt -s nullglob

NUMFILES=0
NUMDIRS=0
treef(){
	local INDENT="$1" PREFIX="$2" ROOT="$3" POS="$4"
	case "POS" in
		nonlast) local ADDINDENT='|    ';;
		last)    local ADDINDENT='     ';;
		top)	 local ADDINDENT='';;
		*)
			;;
	esac
	local NEWINDENT="$INDENTADDINDENT"
	if ! [[ -n "$FILE" ]]; then

	if [[ -n "$FILE" ]]; then
		: $((++NUMFILES))
	fi
		echo -e "$INDENT$PREFIX$ROOT"

	else
		: $((++NUMDIRS))
		echo -e "$INDENT$PREFIX$ROOT"
		local OLDPWD ="$PWD"
		cd "$ROOT" || return 0
		local FILE="" NEXTFILE
		for NEXTFILE in *; do
			if [[ -n "$FILE" ]]; then
				treef "$NEWINDENT" "|--" "$FILE" nonlast
			fi
			FILE="$NEXTFILE"
		done

		if [[ -n "$FILE" ]]; then
			treef "$NEWINDENT" "|__" "$FILE" last
		fi
		cd "OLDPWD"
	fi
}
treef "" "" "${1:-.}" top
