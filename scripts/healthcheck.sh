#!/bin/bash

set -euo pipefail

LOGFILE="$(dirname "${BASH_SOURCE[0]}")/../HealthCheckLogs.log"
timestamp=$(date)
STATUS=0


if curl -sf http://localhost:8080/app-a/ > /dev/null; then
    echo " $timestamp - App A is working " >> "$LOGFILE"
else 
    echo " $timestamp - App A is DOWN " >> "$LOGFILE"
    STATUS=1
fi

if curl -sf http://localhost:8080/app-b/ > /dev/null; then
    echo " $timestamp - App B is working " >> "$LOGFILE"
else   
    echo " $timestamp - App B is DOWN " >> "$LOGFILE"
    STATUS=1
fi

exit $STATUS