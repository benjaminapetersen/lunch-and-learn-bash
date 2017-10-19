#!/bin/bash

# these commands work in the terminal, but they do not get stored in variables
# INUSE=free | grep Mem | awk '{print $3/$2 * 100.0}'
# AVAILABLE=free | grep Mem | awk '{print $4/$2 * 100.0}'
# echo "Percent of memory in use: ${INUSE}%"
# echo "Percent of memory available: ${AVAILABLE}%"

TOTALKB=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
FREEKB=$(awk '/^MemFree:/{print $2}' /proc/meminfo)
FREEMB=$((FREEKB/1024))
FREEGB=$((FREEMB/1024))

# now, invoke the arithmetic expansion operator
# you don't have to convert string to number
echo "Total Memory ${TOTALKB} kb"
echo "Free Memory ${FREEKB} kb"
echo "Free Memory ${FREEMB} mb"
echo "Free Memory ${FREEGB} gb"
