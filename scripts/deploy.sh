#!/bin/bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
docker-compose up --build -d

# Until curl returns 0 the waiting message will be shown

until curl -sf http://localhost:8080/app-a/ > /dev/null; do
    echo "Waiting for App A"
    sleep 2
done
echo "App A is working"

until curl -sf http://localhost:8080/app-b/ > /dev/null; do
    echo "Waiting for App B"
    sleep 2
done
echo "App B is working"