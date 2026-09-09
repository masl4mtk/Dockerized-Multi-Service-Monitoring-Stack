#!/bin/bash

set -euo pipefail

LOGFILE="/Users/maslamah/monitoring-stack/HealthCheckLogs"
timestamp=$(date)

echo " $timestamp - App check " >> "$LOGFILE"
# if curl returns 0 the first command will run
if curl -sf http://localhost:8080/app-a/ > /dev/null; then
    echo " $timestamp - App A is working " >> "$LOGFILE"
else 
    echo " $timestamp - App A is DOWN " >> "$LOGFILE"
fi

if curl -sf http://localhost:8080/app-b/ > /dev/null; then
    echo " $timestamp - App B is working " >> "$LOGFILE"
else   
    echo " $timestamp - App B is DOWN " >> "$LOGFILE"
fi
