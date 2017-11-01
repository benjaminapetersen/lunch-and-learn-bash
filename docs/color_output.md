# Color bash output

[ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code)

condensed into this smaller table via [this stack overflow](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)

```bash
# color always starts with: \033[

Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37

# so with the prefix:
BLACK=\033[0;30
GREEN=\033[0;32
BLUE=\033[0;34

RED='\033[0;31m'
NOCOLOR='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'


# etc

```

An example script:

```bash
RED='\033[0;31m'
NOCOLOR='\033[0m'
GREEN='\033[0;32m'

# -e will enable colors
echo -e "${GREEN}Hi! ${NOCOLOR}My name is ${RED}JOHN DOE${NOCOLOR}"
```

As a list of vars (from the same stack overflow link above):

```bash
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow

```
