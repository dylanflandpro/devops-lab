#!/bin/bash
# Simule une application web

LOG_FILE="/tmp/webapp.log"

cleanup() {
    echo "[$(date)] Arrêt propre de l'application..." >> "$LOG_FILE"
    exit 0
}

trap cleanup SIGTERM SIGINT

echo "[$(date)] Application démarrée (PID: $$)" >> "$LOG_FILE"

counter=0
while true; do
    echo "[$(date)] Heartbeat #$counter" >> "$LOG_FILE"
    ((counter++))
    
    # Simule un crash aléatoire (1 chance sur 20)
    if (( RANDOM % 20 == 0 )); then
        echo "[$(date)] CRASH SIMULÉ!" >> "$LOG_FILE"
        exit 1
    fi
    
    sleep 5
done
