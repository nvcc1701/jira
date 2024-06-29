#!/usr/bin/env bash

# Get the absolute path of the directory containing this script
shDir=$(cd $(dirname $0) && pwd)

# Set the path for the .env file
ENVFILE=${shDir}/docker/.env

# If the .env file doesn't exist, copy the .env.dist file to it
if [ ! -f "$ENVFILE" ]; then
  cp ${shDir}/docker/.env.dist ${ENVFILE}
fi

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi

# Start the Docker services defined in docker-compose.yml with detached mode and rebuilding images
docker-compose -f "docker/docker-compose.yml" up -d --build