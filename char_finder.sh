#!/usr/bin/env bash

#############################################################################################################
############################## Not much to do (for now), just a simple script. ##############################
#############################################################################################################
############################################## by Hygor Hailer ##############################################

# Color definition
YELLOW='\e[33;1m'

# ANSI escape sequence to reset the terminal color
RESET='\e[0m'

# Get the character name
clear -x
echo -e "${YELLOW}Character name:${RESET}"
read char
char_param=$(echo $char | sed 's/ /\+/g')
echo 

# Tibia URL
URL="https://www.tibia.com/community/?name=$char_param+"

# Get page source
HTML=$(wget -q -O - "$URL")

# Extract the info
name=$(echo "$HTML" | grep -oP 'Name:</td><td>\K[^<]+')
title=$(echo "$HTML" | grep -oP '>Title:</td><td>\K[^<]+')
sex=$(echo "$HTML" | grep -oP 'Sex:</td><td>\K[^<]+')
vocation=$(echo "$HTML" | grep -oP 'Vocation:</td><td>\K[^<]+')
level=$(echo "$HTML" | grep -oP 'Level:</td><td>\K[^<]+')
world=$(echo "$HTML" | grep -oP 'World:</td><td>\K[^<]+')
residence=$(echo "$HTML" | grep -oP 'Residence:</td><td>\K[^<]+')
llogin=$(echo "$HTML" | grep -oP 'Last Login:</td><td>\K[^<]+' | sed 's/&#160;/ /g')
astatus=$(echo "$HTML" | grep -oP ">Account&#160;Status:</td><td>\K[^<]+")

# Check if the character exists
if [[ $? -ne 0 ]];then echo -e "${YELLOW}Character not found!${RESET}" && exit 0;fi

# Show results
clear -x
echo
echo -e "${YELLOW}Name:${RESET} $name"
echo -e "${YELLOW}Title:${RESET} $title"
echo -e "${YELLOW}Sex:${RESET} $sex"
echo -e "${YELLOW}Vocation:${RESET} $vocation"
echo -e "${YELLOW}Level:${RESET} $level"
echo -e "${YELLOW}World:${RESET} $world"
echo -e "${YELLOW}Residence:${RESET} $residence"
echo -e "${YELLOW}Last Login:${RESET} $llogin"
echo -e "${YELLOW}Account Status:${RESET} $astatus"

exit 0
