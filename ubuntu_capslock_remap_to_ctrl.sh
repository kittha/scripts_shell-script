#!/bin/bash

PS3='Please enter your choice: '
options=("Option 1: remap 'Caps Lock' to 'Ctrl'" "Option 2: remap 'Caps Lock' to 'Caps Lock'" "Quit")
select option in "${options[@]}"
do
  case $option in
	"Option 1: remap 'Caps Lock' to 'Ctrl'")
		echo "You chose Option 1: remap 'Caps Lock' to 'Ctrl'"
		gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']" 
		break
		;;
	"Option 2: remap 'Caps Lock' to 'Caps Lock'")
		echo "You chose Option 2: remap 'Caps Lock' to 'Caps Lock'"
		gsettings set org.gnome.desktop.input-sources xkb-options "[]"
		break
		;;
	"Quit")
		break
		;;
	*) echo "invalid option $REPLY";;
	esac
done
