#!/bin/bash
if [ "$1" == "" ];then
 echo "comming soon, hehe"
 exit 0
fi
clear
echo
echo -e " \e[32;1m########################################################\e[0m"
echo -e " \e[32;1m##\e[0m      \e[35;1mPengecekan Kuota Tersedia Magang MSIB 6.      \e[0m\e[32;1m##\e[0m"
echo -e " \e[32;1m############### \e[0m \e[38;1mby : fb.com/ibnue19 \e[0m \e[32;1m##################\e[0m"
echo
read -p "masukkan nama mitra (perusahaan) : " mitra


result=$(curl -s 'https://api.kampusmerdeka.kemdikbud.go.id/studi/browse/activity?offset=0&limit=200&location_key=&mitra_key='$mitra'&keyword=&sector_id=&sort_by=published_time&order=desc' \
  -H 'sec-ch-ua: "Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"' \
  -H 'Referer: https://kampusmerdeka.kemdikbud.go.id/' \
  -H 'DNT: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Windows"')

# echo $result | jq -r .data[].name

echo
echo  -e "Berikut nama program yang berhubungan dengan mitra \e[35;1m($mitra)\e[0m yang di cari :"
count=1
IFS=$'\n'   # Set Internal Field Separator to newline to handle spaces in names
for line in $(echo "$result" | jq -r '.data[] | "\(.name) ; id = \(.id)"'); do
    echo "$count. $line"
    ((count++))
done

echo;echo
#read -p "apakah anda ingin mebngcek kuota penerimaannya ? (y/t) :" pilihan
#if [ "$ilihan" == "t" ]; then
# exit 0
#fi

read -p "masukkan id mitra yang ingin di cek kuotanya : " id

result=$(curl -s 'https://api.kampusmerdeka.kemdikbud.go.id/studi/browse/activity/'$id \
  -H 'authority: api.kampusmerdeka.kemdikbud.go.id' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYTE3NDVhMWQtNjg2Yi00Mjg2LWE5YjktOTNlNTFjYWExNWVlIiwicnQiOmZhbHNlLCJleHAiOjE3MDU2Mzc1MzksImlhdCI6MTcwNTYzNTczOSwiaXNzIjoiV2FydGVrLUlEIiwibmFtZSI6IklCTlVERElOIExBU0FXQUxJIiwicm9sZXMiOlsibWFoYXNpc3dhIl0sInB0X2NvZGUiOiIwMDEwMjgiLCJpZF9zcCI6bnVsbCwiaGFzX2FkbWluX3JvbGUiOmZhbHNlLCJtaXRyYV9pZCI6IjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMCIsImVtYWlsIjoiYWt1bmZvcm1hbDE5QGdtYWlsLmNvbSIsInNla29sYWhfbnBzbiI6IiJ9.Kdic4wRrSS-S1qOkrIX_ip1cY5HDfru8gYecrqm8ckzt7BeI2AXjs-3mGqCjc5uPyeTFTWzSoMsddrhPiX0M_V' \
  -H 'dnt: 1' \
  -H 'origin: https://kampusmerdeka.kemdikbud.go.id' \
  -H 'priority: u=1, i' \
  -H 'referer: https://kampusmerdeka.kemdikbud.go.id/' \
  -H 'sec-ch-ua: "Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')

echo;echo
echo "   berikut status nya"
echo -e "\e[36;3m nama program       :\e[0m \e[36;1m $(echo $result | jq .data.name) \e[0m"
echo -e "\e[36;3m available_to_apply :\e[0m \e[36;1m $(echo $result | jq .data.available_to_apply) \e[0m"
echo -e "\e[36;3m quota_full         :\e[0m \e[36;1m $(echo $result | jq .data.is_quota_full) \e[0m"

echo -e "\e[31;1m
 ket :
   1. jika \e[0m available_to_apply \e[31;1mbernilai \e[31;1mtrue\e[31;1m, maka masih buka pendaftaran (karena kamdek belum nutup pendaftaran)
   2. jika \e[31;1mquota_full\e[0m bernilai \e[31;1mtrue\e[0m, \e[31;1mmaka anda tidak bisa daftar (karena karena mitra sudah memenuhi kuota target).
\e[0m
"
