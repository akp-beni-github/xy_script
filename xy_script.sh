#!/bin/bash

# initial variables
x=0
y=0
direction="North"

# functions
update_direction() {
  local turn=$1
  case $direction in
    "North")
      if [ "$turn" == "R" ]; then
        direction="East"
      else
        direction="West"
      fi
      ;;
    "East")
      if [ "$turn" == "R" ]; then
        direction="South"
      else
        direction="North"
      fi
      ;;
    "South")
      if [ "$turn" == "R" ]; then
        direction="West"
      else
        direction="East"
      fi
      ;;
    "West")
      if [ "$turn" == "R" ]; then
        direction="North"
      else
        direction="South"
      fi
      ;;
  esac
}


move_forward() {
  local steps=$1
  case $direction in
    "North")
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

# read command
read -p "Enter commands (e.g., W15 R W5 L W10): " user_input
commands=($user_input)

# main program
for command in "${commands[@]}"; do
  if [[ $command == R || $command == L ]]; then
    update_direction $command
  elif [[ $command == W* ]]; then
    steps=${command:1}
    move_forward $steps
  fi
done

# output 
echo "X: $x, Y: $y, Direction: $direction "  