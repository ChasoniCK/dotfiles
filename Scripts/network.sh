#!/bin/sh
INTERFACE="wlan0"  # Замените на ваш интерфейс
SSID=$(iw dev $INTERFACE info | grep ssid | awk '{for(i=2;i<=NF;i++) printf $i " "; print ""}')
echo $SSID
