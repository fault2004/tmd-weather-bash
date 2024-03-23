#!/bin/bash
# https://github.com/fault2004/tmd-weather-bash
# This script using free RSS service from https://tmd.go.th/api/xml/storm-tracking

STORMDATA="$HOME/stormdata"

usage() {
	echo "Usage: ./stormtracking.sh <mode> [options]"
	echo "mode:"
	echo " get [latest]     get data from TMD"
	echo " view             view data"
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
	more "$STORMDATA"
	exit 0
}

cleardata() {
	[ -f "$STORMDATA" ] && rm "$STORMDATA"
	exit 0
}

getdata() {
	echo "Downloading..."
	DATA="$(curl -s "https://tmd.go.th/api/xml/storm-tracking")"
	W_COUNT=$(echo "$DATA" | xmlstarlet sel -t -v "count(rss/channel/item)")
	[ -f "$STORMDATA" ] && rm "$STORMDATA"
	
	[ "$1" == "latest" ] && W_COUNT="1"

	echo "Please wait, processing data..."
	for ((i=0;i<=W_COUNT;i++)); do
		W_TITLE=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/title)")
		W_DEST=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/description)")

		echo "$W_TITLE" >> "$STORMDATA"
		echo "$W_DEST" >> "$STORMDATA"
		echo >> "$STORMDATA"
	done

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
		viewdata
	;;
	"clear")
		cleardata
	;;
	*)
		usage
	;;
esac
