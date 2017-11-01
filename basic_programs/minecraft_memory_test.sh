#!/bin/bash

## TODO: THIS IS BROKEN!!! FIX IT :)

# some vars representing the machine memory size possibilities
# represented in Mb
NANO_EC2_MEM=512
MICRO_EC2_MEM=1024
SMALL_EC2_MEM=2048
MEDIUM_EC2_MEM=4096
LARGE_EC2_MEM=8192

# how much free memory do we have available now?
TOTALKB=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
FREEKB=$(awk '/^MemFree:/{print $2}' /proc/meminfo)
FREEMB=$((FREEKB/1024))

# TODO: DEBUG THIS!
# ECHO OUT THE VALUES...
# SET DEFAULT NUMBER VALUES JUST TO GET THE TOTALKB DEBUGGABLE SINCE /proc/meminfo
# DOESNT EXIST ON MAC
# most of this can be done with dummy files to test!
# 1. compare free mem to a cutoff
# 2. refactor out the repeated code & just set variables
# 3. call the java func once at the end
# 4. set the minecraft server.jar file as a variable
# comparisons:
# http://tldp.org/LDP/abs/html/comparison-ops.html
if ["$TOTALKB" < "$NANO_EC2_MEM" ]; then
  # 512 max @ 75%
  echo "----------------------------------------------------"
  echo "${TOTALKB} KB, starting minecraft with NANO settings"
  echo "----------------------------------------------------"
  nohup java -Xms128M -Xmx448M -jar minecraft_server.1.11.2.jar nogui &
elif ["$TOTALKB" < "$MICRO_EC2_MEM" ]; then
  # 1024 max @ 75%
  echo "----------------------------------------------------"
  echo "${TOTALKB} KB, starting minecraft with MICRO settings"
  echo "----------------------------------------------------"
  nohup java -Xms256M -Xmx768M -jar minecraft_server.1.11.2.jar nogui &
elif ["$TOTALKB" < "$SMALL_EC2_MEM" ]; then
  # 2048 max @ 75%
  echo "----------------------------------------------------"
  echo "${TOTALKB} KB, starting minecraft with SMALL settings"
  echo "----------------------------------------------------"
  nohup java -Xms768M -Xmx1792M -jar minecraft_server.1.11.2.jar nogui &
elif ["$TOTALKB" < "$MEDIUM_EC2_MEM" ]; then
  # 4096 max @ 80%
  echo "----------------------------------------------------"
  echo "${TOTALKB} KB, starting minecraft with MEDIUM settings"
  echo "----------------------------------------------------"
  nohup java -Xms768M -Xmx3072M -jar minecraft_server.1.11.2.jar nogui &
elif ["$TOTALKB" < "$LARGE_EC2_MEM" ]; then
  # 8192 max @ 85%
  echo "----------------------------------------------------"
  echo "${TOTALKB} KB, starting minecraft with LARGE settings"
  echo "----------------------------------------------------"
  nohup java -Xms768M -Xmx6963M -jar minecraft_server.1.11.2.jar nogui &
else
  # The default, if things go weird,
  # will just be to act as if it is an EC2_SMALL instance
  echo "----------------------------------------------------"
  echo "Unknown memory, guessing at a good memory setting!"
  echo "----------------------------------------------------"
  nohup java -Xms768M -Xmx1536M -jar minecraft_server.1.11.2.jar nogui &
fi
