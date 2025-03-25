#! /bin/bash

diap=$(echo "$(hostname -I | awk -F'.' '{print $1"."$2"."$3}')")
echo $diap

start=1
end=254

ping_ip() {
    ip="$1"
    ping -c 1 -W 1 $ip &> /dev/null

    if [ $? -eq 0 ]; then
        printf "\e[32m%s\e[0m\n" "$ip available"
    fi
}

export -f ping_ip 

seq $start $end | parallel -j 100 "ping_ip $diap.{1}"