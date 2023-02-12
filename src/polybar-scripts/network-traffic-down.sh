#!/bin/bash

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "$1/1000" | bc -l | LANG=C xargs printf "%.f\n") kB/s"
    else
        bytes="$(echo "$1/1000000" | bc -l | LANG=C xargs printf "%.1f\n") MB/s"
    fi

    echo "$bytes"
}

INTERVAL=10

declare -A bytes

interface="wlan10"
bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
while true; do
    down=0
    bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
    bytes_down=$(((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]}) / INTERVAL))
    down=$(( "$down" + "$bytes_down" ))
    bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
    echo "$(print_bytes $down)"
    sleep INTERVAL
done
