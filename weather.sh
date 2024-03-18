#!/bin/bash
# https://github.com/fault2004/tmd-weather-bash
# This script using free RSS service from https://tmd.go.th/service/rss

if [ "$1" == "" ]; then
	echo "error: station number required."
	echo "กรุณาระบุหมายเลขสถานนี"
	exit 1
fi

if [ "$1" == "help" ]; then
	echo "Usage: ./weather.sh <station_number> [options]"
	echo "options (print specific information): "
	echo " temp"
	echo " humid (humidity)"
	echo " press (pressure)"
	echo " wind"
	echo " visi (visibility)"
	echo " climate"
	echo " tlrain (total rain)"
	echo " sunrise"
	echo " sunset"
	echo "This script using free RSS service from https://tmd.go.th/service/rss"
	exit 0
fi

summary() {
	echo $W_TITLE
	echo "======================================================"
	echo $W_TEMP_FULL
	echo $W_HUMID_FULL
	echo $W_PRESS_FULL
	echo $W_WIND_FULL
	echo $W_VISI_FULL
	echo $W_CLIMATE_FULL
	echo $W_TLRAIN_FULL
	echo $W_SUNRISE_FULL
	echo $W_SUNSET_FULL
	echo "======================================================"
}

DATA=$(curl -s "https://tmd.go.th/api/xml/weather-report?stationnumber=${1}")

W_TITLE=$(echo $DATA | xmlstarlet sel -t -v "(rss/channel/item/title)")

W_INFO="$(echo $DATA | xmlstarlet sel -t -v "(rss/channel/item/description)" | sed 's/&lt;b&gt; //g' | sed 's/&lt;\/b&gt;//g')"

# Temp
W_TEMP=${W_INFO##*อุณหภูมิ : }
W_TEMP=${W_TEMP% องศาเซลเซียส *}
W_TEMP_FULL="อุณหภูมิ: ${W_TEMP} องศาเซลเซียส"

# Humidity
W_HUMID=${W_INFO##*ความชื้นสัมพัทธ์ : }
W_HUMID=${W_HUMID% \%*}
W_HUMID_FULL="ความชื้นสัมพัทธ์: ${W_HUMID}%"

# Pressure
W_PRESS=${W_INFO##*ความกดอากาศ : }
W_PRESS=${W_PRESS% มิลลิบาร์ *}
W_PRESS_FULL="ความกดอากาศ: ${W_PRESS} มิลลิบาร์ "

# Wind
W_WIND=${W_INFO##*ทิศทางลม : }
W_WIND=$(echo $W_WIND | cut -f1 -d' ')
W_WIND_FULL="ทิศทางลม: ${W_WIND}"

# Visibility
W_VISI=${W_INFO##*ทัศนวิสัย : }
W_VISI=${W_VISI% กิโลเมตร *}
W_VISI_FULL="ทัศนวิสัย: ${W_VISI} กิโลเมตร "

# Climate
W_CLIMATE=${W_INFO##*ลักษณะอากาศ : }
W_CLIMATE=$(echo $W_CLIMATE | cut -f1 -d'&')
W_CLIMATE_FULL="ลักษณะอากาศ: ${W_CLIMATE}"

# Total Rain
W_TLRAIN=${W_INFO##*ฝนสะสมวันนี้ : &lt;/ b &gt;}
W_TLRAIN=${W_TLRAIN% มิลลิเมตร*}
W_TLRAIN_FULL="ฝนสะสมวันนี้: ${W_TLRAIN} มิลลิเมตร"

# Sunrise Time
W_SUNRISE=${W_INFO##*พระอาทิตย์ขึ้นเช้าพรุ่งนี้: }
W_SUNRISE=${W_SUNRISE% น. *}
W_SUNRISE_FULL="พระอาทิตย์ขึ้นเช้าพรุ่งนี้: ${W_SUNRISE} น."

# Sunset Time
W_SUNSET=${W_INFO##*พระอาทิตย์ตกเย็นวันนี้: }
W_SUNSET=${W_SUNSET% น.*}
W_SUNSET_FULL="พระอาทิตย์ตกเย็นวันนี้: ${W_SUNSET} น."

case $2 in
	"")
		summary
	;;
	"temp")
		echo $W_TEMP
	;;
	"humid")
		echo $W_HUMID
	;;
	"press")
		echo $W_PRESS
	;;
	"wind")
		echo $W_WIND
	;;
	"visi")
		echo $W_VISI
	;;
	"climate")
		echo $W_CLIMATE
	;;
	"tlrain")
		echo $W_TLRAIN
	;;
	"sunrise")
		echo $W_SUNRISE
	;;
	"sunset")
		echo $W_SUNSET
	;;
	*)
	;;
esac
