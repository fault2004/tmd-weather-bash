# TMD Weather in Bash scripts.
Get weather information in Thailand from free RSS service provided by Thai Meteorological Deapartment (TMD) in Bash script.

This project is for education and ease of use only, to properly using their service, please use API provided by TMD.

requirements: ``bash``, ``curl`` and ``xmlstarlet``

เพื่อการศึกษาและความสะดวกในการใช้งานเท่านั้น

ดึงข้อมูลจาก: https://tmd.go.th/service/rss

## Using

1. ``git clone https://github.com/fault2004/tmd-weather-bash && cd tmd-weather-bash``
2. ``chmod +x *.sh``

## weather.sh Usage
```
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh help
Usage: ./weather.sh <station_number> [options]
options (print specific information): 
 temp
 humid (humidity)
 press (pressure)
 wind
 visi (visibility)
 climate
 tlrain (total rain)
 sunrise
 sunset
This script using free RSS service from https://tmd.go.th/service/rss
```

## weather.sh Example - summary information
```
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567
รายงานสภาวะอากาศ - ตรัง : อ.เมือง จ.ตรัง วันที่ : 18/03/2024 เวลา 07:00 นาฬิกา
======================================================
อุณหภูมิ: 24.0 องศาเซลเซียส
ความชื้นสัมพัทธ์: 87%
ความกดอากาศ: 1010.52 มิลลิบาร์
ทิศทางลม: ลมสงบ
ทัศนวิสัย: 8.0 กิโลเมตร
ลักษณะอากาศ: มีหมอกน้ำค้าง
ฝนสะสมวันนี้: 0.0 มิลลิเมตร
พระอาทิตย์ขึ้นเช้าพรุ่งนี้: 06:26 น.
พระอาทิตย์ตกเย็นวันนี้: 18:32 น.
======================================================
```

## weather.sh Example - print specific information
```
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 temp
24.0
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 humid
87
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 wind
ลมสงบ
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 press
1010.52
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 sunrise
06:26
terry@procn:~/prj/tmd-weather-bash$ ./weather.sh 48567 sunset
18:32
```

## stormtracking.sh Usage
```
terry@procn:~/prj/tmd-weather-bash$ ./stormtracking.sh 
Usage: ./stormtracking.sh <mode> [options]
mode:
 get [latest]     get data from TMD
 view [cat]       view data
 clear            clear data cache
This script using free RSS service from https://tmd.go.th/api/xml/storm-tracking
```

## stormtracking.sh Example - get data
```
terry@procn:~/prj/tmd-weather-bash$ ./stormtracking.sh help
Usage: ./stormtracking.sh <mode> [options]
mode:
 get [latest]     get data from TMD - latest, get only latest data
 view [cat]       view data - use cat for reading
 clear            clear data cache
This script using free RSS service from https://tmd.go.th/api/xml/storm-tracking
```

## stormtracking.sh Example - view data
```



พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 8 (67/2567) (มีผลกระทบจนถึงวันที่ 20 มีนาคม 2567)
บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีน ได้แผ่ลงมาปกคลุมประเทศไทยตอนบนและทะเลจีนใต้แล้ว 

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 7 (66/2567) (มีผลกระทบจนถึงวันที่ 20 มีนาคม 2567)
บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนได้แผ่ลงมาปกคลุมประเทศไทยตอนบนและทะเลจีนใต้ 

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 6 (65/2567) (มีผลกระทบจนถึงวันที่ 20 มีนาคม 2567)
บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนจะแผ่ลงมาปกคลุมประเทศไทยตอนบนและทะเลจีนใต้ ในขณะที่ประเทศไทยตอ
นบนมีอากาศร้อนถึงร้อนจัด

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 5 (64/2567) (มีผลกระทบในช่วงวันที่ 19-20 มีนาคม 2567)
ในช่วงวันที่ 19-20 มีนาคม 2567 บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนจะแผ่ลงมาปกคลุมประเทศไทยตอนบนและ
ทะเลจีนใต้ 

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 4 (63/2567) (มีผลกระทบในช่วงวันที่ 19-20 มีนาคม 2567)
ในช่วงวันที่ 19-20 มีนาคม 2567 บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนจะแผ่ลงมาปกคลุมประเทศไทยตอนบนและ
ทะเลจีนใต้ 

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 3 (62/2567) (มีผลกระทบในช่วงวันที่ 19-20 มีนาคม 2567)
ในช่วงวันที่ 19-20 มีนาคม 2567 บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนจะแผ่ลงมาปกคลุมประเทศไทยตอนบนและ
ทะเลจีนใต้ 

พายุฤดูร้อนบริเวณประเทศไทย ฉบับที่ 2 (61/2567) (มีผลกระทบในช่วงวันที่ 19-20 มีนาคม 2567)
ในช่วงวันที่ 19-20 มีนาคม 2567 บริเวณความกดอากาศสูงหรือมวลอากาศเย็นกำลังปานกลางจากประเทศจีนจะแผ่ลงมาปกคลุมประเทศไทยตอนบนและ
--More--(0%)
```
