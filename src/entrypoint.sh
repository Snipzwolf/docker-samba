#!/usr/bin/env bash
EXTRA_SCRIPT="";
RUN_NMBD="false";

while getopts s:n option
do
 case "${option}"
 in
 s) EXTRA_SCRIPT=${OPTARG};;
 n) RUN_NMBD="true";;
 esac
done

set -x;

if [ -f "$EXTRA_SCRIPT" ]; then
	bash $EXTRA_SCRIPT;
fi

if [ "$RUN_NMBD" = true ]; then
	exec ionice -c 3 nmbd -D < /dev/null;
fi

exec ionice -c 3 smbd -F < /dev/null;
