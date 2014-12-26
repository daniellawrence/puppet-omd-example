#!/bin/bash

ID=$(docker ps | awk '$2 ~ /puppetmaster:latest/ {print $1}')
NAME=$(docker inspect --format '{{.Name}}' ${ID})


echo "puppet agent -t --server \$PUPPETMASTER_PORT_8140_TCP_ADDR --environment default"

# Run the agent with the provided hostname & args
docker build -t omd .
docker run -i -t --link=${NAME}:puppetmaster omd bash
