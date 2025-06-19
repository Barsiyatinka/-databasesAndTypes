#!/bin/bash

LOGFILE="/var/log/backup_home.log" #укажем расположение лог файла

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S') #укажем время запуска

echo "[$TIMESTAMP] Starting backup..." >> "$LOGFILE" # сделаем запись о начале работ

rsync -a --delete --checksum --exclude='.*' "/home" "/tmp/backup" >> "$LOGFILE" 2>&1 # выполнение  самого скрипта

# выведем результат корректности копирования в лог файл
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Backup completed successfully." >> "$LOGFILE"
    logger "Backup of home directory completed successfully."
else
    echo "[$TIMESTAMP] Backup FAILED!" >> "$LOGFILE"
    logger "Backup of home directory FAILED!"
fi
