#!/bin/bash
# Usage: sudo lvm_monitor.sh 80
threshold=$1
LOGFILE="/var/log/lvm_monitor.log"

# Ensure log file exists
touch $LOGFILE
chmod 666 $LOGFILE

for mount_point in /mnt/data1 /mnt/data2 /mnt/data3; do
    if mountpoint -q "$mount_point"; then
        lv_path=$(df "$mount_point" | tail -1 | awk '{print $1}')
        used=$(df -h "$mount_point" | awk 'NR==2 {print $5}' | tr -d '%')

        echo "$(date) - Checking $mount_point: $used%" >> $LOGFILE

        if (( used >= threshold )); then
            echo "$(date) - WARNING: $mount_point is at ${used}% FULL" >> $LOGFILE
            /usr/local/bin/lvm_manager.sh "$lv_path" "$mount_point" "$threshold" >> $LOGFILE 2>&1
        fi
    else
        echo "$(date) - SKIPPED: $mount_point is not mounted" >> $LOGFILE
    fi
done
