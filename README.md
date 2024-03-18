# tmd-weather-bash
Get weather information in Thailand from free RSS service provided by Thai Meteorological Deapartment (TMD) in Bash script.

This project is for education and ease of use only, to properly using their service, please use API provided by TMD.

requirements: ``bash``, ``curl`` and ``xmlstarlet``

เพื่อการศึกษาและความสะดวกในการใช้งานเท่านั้น

ดึงข้อมูลจาก: https://tmd.go.th/service/rss

## Usage
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

## Example - summary information
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

## Example - print specific information
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
