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
interface="wlan0"

declare -A bytes

bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

while true; do
    up=0
    bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"
    bytes_up=$(((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]}) / INTERVAL))
    up=$(( "$up" + "$bytes_up" ))
    bytes[past_tx_$interface]=${bytes[now_tx_$interface]}
    echo "$(print_bytes $up)"
    sleep $INTERVAL
done
