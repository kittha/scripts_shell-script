#!/bin/bash

echo "### adding script path to cron job ###"
add_cron_job() {
    SCRIPT_PATH=$(realpath "$0")
    CRON_JOB="*/30 6-18 * * * $SCRIPT_PATH"
    
    crontab -l | grep -q "$SCRIPT_PATH"
    if [ $? -eq 0 ]; then
        echo "Cron job already exists."
    else
        (crontab -l; echo "$CRON_JOB") | crontab -
        echo "Cron job added: $CRON_JOB"
    fi
}


scan_and_notify() {
    echo "init ggshield repo scanning"
    SCRIPT_PATH=$(dirname "$(realpath "$0")")
    
    output=$(ggshield secret scan repo "$SCRIPT_PATH" 2>&1)
    
    echo $(date +%Y%m%d-%H%M%S) "$output" >> log_file_ggshield_scan_result.txt

    if echo "$output" | grep -q "incident"; then
         notify-send "Incident detected" "API Key leaks was detected during the scan.\nCheck the terminal for details."
         
    log_file_incident="incident_api_key_leak_$(date +%Y%m%d-%H%M%S).log"
    echo "$output" > "$log_file_incident"
    fi
}


clean_crontab() {
    echo "### Cleaning the crontab ###"
    crontab -r
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
