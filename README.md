# Dockerized Multi-service Monitoring Stack

This project consists of two simple backend Python applications and an Nginx reverse proxy, all put in Docker containers and spun up appropriately with the correct configuration and network settings.
Bash scripts are used to automate the build of the stack and health checks.

## Architecture

The Nginx application is built through a Docker image which uses `nginx:latest` as the base image and copies an `nginx.conf` file into the image, which listens on port 80 and directs traffic to both applications on port 8000.

Nginx is used as a reverse proxy to act as an entry point for both applications. The docker-compose file spins up the Docker containers and creates the custom-built network, which only exposes the Nginx container to the host. It allows network traffic to be directed to the host through port 8080 and links it to Nginx through port 80, which is the port the `nginx.conf` file configures Nginx to listen on. Both Python applications listen on port 8000 but are not exposed to the host. Only Nginx is reachable from outside the network, keeping the backend apps isolated.

## Project Structure

├── docker-compose.yml
├── nginx/
│ ├── Dockerfile
│ └── nginx.conf
├── app-a/
├── app-b/
├── scripts/
│ ├── deploy.sh
│ └── healthcheck.sh
└── logs/


## How to run it

The whole stack can be run by simply running the Bash script `deploy.sh`, which calls the docker-compose file to build and spin up all the containers. `deploy.sh` polls each service until it's ready rather than exiting immediately after `docker-compose up`, and it prints a message once both App A and App B are confirmed working.

## How to check it's working

Running `healthcheck.sh` timestamps each check and hits both App A and App B (through Nginx) to confirm they're responding correctly. Each result pass or fail is logged with its timestamp to the `logs/` directory. If either service fails to respond as expected, the script exits with a non-zero exit code, making it suitable for use in automated monitoring or CI pipelines.
