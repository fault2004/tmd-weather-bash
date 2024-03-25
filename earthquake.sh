#!/bin/bash
# https://github.com/fault2004/tmd-weather-bash
# This script using free RSS service from https://earthquake.tmd.go.th/feed/rss_inside.xml

EARTHQUAKE_DATA="$HOME/earthquakedata"

usage() {
	echo "Usage: ./earthquake.sh <mode> [options]"
	echo "mode:"
	echo " get [latest]     get data from TMD - latest, get only latest data"
	echo " view [cat]       view data - use cat for reading"
	echo " clear            clear data cache"
	echo "This script using free RSS service from https://earthquake.tmd.go.th/feed/rss_inside.xml"
	exit 0
}

err() {
	echo "error: $1"
	exit 1
}

viewdata() {
	[ ! -f "$EARTHQUAKE_DATA" ] && err 'data not found! please use "./earthquake.sh get" first.'
	
	if [ "$1" == "cat" ]; then
		cat "$EARTHQUAKE_DATA"
	else
		more "$EARTHQUAKE_DATA"
	fi
	
	exit 0
}

cleardata() {
	[ -f "$EARTHQUAKE_DATA" ] && rm "$EARTHQUAKE_DATA"
	[ -f "$EARTHQUAKE_DATA.2" ] && rm "$EARTHQUAKE_DATA.2"
	exit 0
}

getdata() {
	echo "Downloading..."
	DATA="$(curl -s "https://earthquake.tmd.go.th/feed/rss_inside.xml")"
	W_COUNT=$(echo "$DATA" | xmlstarlet sel -t -v "count(rss/channel/item)")
	[ -f "$EARTHQUAKE_DATA" ] && rm "$EARTHQUAKE_DATA"
	[ -f "$EARTHQUAKE_DATA.2" ] && rm "$EARTHQUAKE_DATA.2"

	[ "$1" == "latest" ] && W_COUNT="1"

	echo "Please wait, processing data..."
	for ((i=0;i<=W_COUNT;i++)); do
		W_TITLE=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/title)")
		W_DEST=$(echo "$DATA" | xmlstarlet sel -t -v "(rss/channel/item[$i]/description)")

		echo "$W_TITLE" >> "$EARTHQUAKE_DATA.2"
		echo "$W_DEST" >> "$EARTHQUAKE_DATA.2"
		echo >> "$EARTHQUAKE_DATA.2"
	done

	sed -i 's/&lt;br&gt;/ /g' "$EARTHQUAKE_DATA.2"
	tail -n +4 "$EARTHQUAKE_DATA.2" > "$EARTHQUAKE_DATA"
	rm "$EARTHQUAKE_DATA.2"

	echo "Saved in $EARTHQUAKE_DATA"
	echo 'type "./earthquake.sh view" to view data'
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
