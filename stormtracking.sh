#!/bin/bash
# https://github.com/fault2004/tmd-weather-bash
# This script using free RSS service from https://tmd.go.th/api/xml/storm-tracking

STORMDATA="$HOME/stormdata"

usage() {
	echo "Usage: ./stormtracking.sh <mode> [options]"
	echo "mode:"
	echo " get [latest]     get data from TMD - latest, get only latest data"
	echo " view [cat]       view data - use cat for reading"
	echo " clear            clear data cache"
	echo "This script using free RSS service from https://tmd.go.th/api/xml/storm-tracking"
	exit 0
}

err() {
	echo "error: $1"
	exit 1
}

viewdata() {
	[ ! -f "$STORMDATA" ] && err 'data not found! please use "./stormtracking.sh get" first.'
	
	if [ "$1" == "cat" ]; then
		cat "$STORMDATA"
	else
		more "$STORMDATA"
	fi
	
	exit 0
}

cleardata() {
	[ -f "$STORMDATA" ] && rm "$STORMDATA"
	[ -f "$STORMDATA.2" ] && rm "$STORMDATA.2"
	exit 0
}

getdata() {
	echo "Downloading..."
	DATA="$(curl -s "https://tmd.go.th/api/xml/storm-tracking")"
	W_COUNT=$(echo "$DATA" | xmlstarlet sel -t -v "count(rss/channel/item)")
	[ -f "$STORMDATA" ] && rm "$STORMDATA"
	[ -f "$STORMDATA.2" ] && rm "$STORMDATA.2"

	[ "$1" == "latest" ] && W_COUNT="1"

	echo "Please wait, processing data..."
	for ((i=0;i<=W_COUNT;i++)); do
		W_TITLE=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/title)")
		W_DEST=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/description)")

		echo "$W_TITLE" >> "$STORMDATA.2"
		echo "$W_DEST" >> "$STORMDATA.2"
		echo >> "$STORMDATA.2"
	done

	tail -n +4 "$STORMDATA.2" > "$STORMDATA"
	rm "$STORMDATA.2"

	echo "Saved in $STORMDATA"
	echo 'type "./stormtracking.sh view" to view data'
	exit 0
}

case "$1" in 
	"help")
		usage
	;;
	"get")
		getdata "$2"
	;;
	"view")
		viewdata "$2"
	;;
	"clear")
		cleardata
	;;
	*)
		usage
	;;
esac
