#!/bin/bash

echo "Choose an option:"
echo "1. Add cron job (schedule scan)"
echo "2. ggshield manual scan once"
echo "3. Clean crontab (schedule scan)"
echo "4. Exit"
read -p "Enter your choice [1-4]: " choice

case $choice in
    1)
        ./ggshield_002-scanner.sh add
        ;;
    2)  
        ./ggshield_002-scanner.sh scan
        ;;  
    3)
        ./ggshield_002-scanner.sh clean
        ;;
    4)
        echo "Exiting."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        ;;
esac
