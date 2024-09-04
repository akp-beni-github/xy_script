#!/bin/bash

#functions
update_direction() {
    local turn=$1
    case $dir in
        "North")
        if [[ "$turn" == "R" ]]; then 
            dir="East"
        else
            dir="West"
        fi
        ;;
        "East")
        if [[ "$turn" == "R" ]]; then 
            dir="South"
        else
            dir="North"
        fi
        ;;
        "South")
        if [[ "$turn" == "R" ]]; then 
            dir="West"
        else
            dir="East"
        fi
        ;;
        "West")
        if [[ "$turn" == "R" ]]; then 
            dir="North"
        else
            dir="South"
        fi
        ;;
    esac 
}

move_forward() {
    local steps=$1
    case $dir in
    "North")
        #y=${y}+${steps}
        y=$((y + steps))
        ;;
    "East")
        x=$((x + steps))
        ;;
    "South")
        y=$((y - steps))
        ;;
    "West")  
        x=$((x - steps))
        ;;
    esac
}

#init
x=0
y=0
dir=North

commands=()

#input 
read -p "enter cmd: " user_input

# regex precisely parsing string to array 
while [[ $user_input =~ ([R]|[L]|W[0-9]+) ]]; do
    #echo "${BASH_REMATCH[1]}"
    commands+=("${BASH_REMATCH[1]}") # push to array as an array
    #echo "${commands[@]}" 
    user_input=${user_input#*"${BASH_REMATCH[1]}"} #clear the input string 
    #echo "${user_input}"
done

#main prog
for cmd in "${commands[@]}"; do
    if [[ $cmd == R || $cmd == L ]]; then 
        #echo "${cmd}"
        update_direction $cmd
    elif [[ $cmd == W* ]]; then 
        steps=${cmd:1}
        #echo "${cmd:1}"
        move_forward $steps
    fi    
done

# output
echo "Final position: X = $x, Y = $y, Direction = $dir"



