#!/bin/bash

LOG_FILE="access.log"
NUM_ENTRIES=10000 

> $LOG_FILE

IPS=("127.0.0.1" "192.168.1.1" "192.168.1.2" "10.0.0.1" "172.16.0.1" "8.8.8.8" "1.1.1.1")
METHODS=("GET" "POST")
PATHS=("/index.html" "/login" "/api/data" "/home" "/profile" "/search" "/cart" "/checkout")
STATUS_CODES=("200" "201" "301" "400" "401" "403" "404" "500" "502" "503")
DAYS=("09/May/2025" "10/May/2025" "11/May/2025" "12/May/2025")


for ((i=0; i<NUM_ENTRIES; i++)); do
   
    IP=${IPS[$RANDOM % ${#IPS[@]}]}
    METHOD=${METHODS[$RANDOM % ${#METHODS[@]}]}
    PATH=${PATHS[$RANDOM % ${#PATHS[@]}]}
    STATUS=${STATUS_CODES[$RANDOM % ${#STATUS_CODES[@]}]}
    DAY=${DAYS[$RANDOM % ${#DAYS[@]}]}
    HOUR=$(printf "%02d" $((RANDOM % 24)))  
    MIN=$(printf "%02d" $((RANDOM % 60)))   
    SEC=$(printf "%02d" $((RANDOM % 60)))  
    SIZE=$((RANDOM % 10000 + 500))         

    echo "$IP - - [$DAY:$HOUR:$MIN:$SEC +0000] \"$METHOD $PATH HTTP/1.1\" $STATUS $SIZE" >> $LOG_FILE
done

echo "Generated $LOG_FILE with $NUM_ENTRIES entries"

