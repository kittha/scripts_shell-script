#!/bin/bash

echo "### adding script path to cron job ###"
add_cron_job() {
    local SCRIPT_PATH
    SCRIPT_PATH=$(realpath "$0")
    CRON_JOB="*/30 6-18 * * * $SCRIPT_PATH"
    
    crontab -l 2>/dev/null | grep -q "$SCRIPT_PATH"
    if [ $? -eq 0 ]; then
        echo "Cron job already exists."
    else
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        echo "Cron job added: $CRON_JOB"
    fi
}


scan_and_notify() {
    echo "init ggshield repo scanning"
    SCRIPT_PATH=$(dirname "$(realpath "$0")")
    
    output=$(ggshield secret scan path --exclude '**/.env' -ry "$SCRIPT_PATH" 2>&1)
    
    
    if echo "$output" | grep -q "incident"; then
         notify-send "Incident detected" "API Key leaks was detected during the scan.\nCheck the terminal for details."
         
         log_file_incident="incident_api_key_leak_$(date +%Y%m%d-%H%M%S).log"
   echo $(date +%Y%m%d-%H%M%S) "Secret key leak, please check!" > "$log_file_incident"
    
    # Start: Danger zone
    # use for debugging only: high risk to expose api key!
    # echo $(date +%Y%m%d-%H%M%S) "$output" > "$log_file_incident" # Don't use this in production!
    # End: Danger zone
   
    elif echo "$output" | grep -q "No secrets have been found"; then
          echo $(date +%Y%m%d-%H%M%S) "No secrets have been found" >> log_file_ggshield_scan_result.txt
    else
          echo "$(date +%Y%m%d-%H%M%S) An unexpected error occurred during the scan." >> log_file_ggshield_scan_result.txt
    fi
}


clean_crontab() {
    echo "### Cleaning the crontab ###"
      crontab -r 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Crontab successfully cleaned."
    else
        echo "Failed to clean the crontab or no crontab to clean."
    fi
}


main() {
    if [ "$1" == "add" ]; then
        add_cron_job
    elif [ "$1" == "scan" ]; then
        scan_and_notify
    elif [ "$1" == "clean" ]; then
        clean_crontab
    else
        echo "Usage: $0 {add|scan|clean}"
        exit 1
    fi
}

main "$@"
