#!/bin/bash

ID=$(docker ps | awk '$2 ~ /puppetmaster:latest/ {print $1}')
NAME=$(docker inspect --format '{{.Name}}' ${ID})


echo "puppet agent -t --server \$PUPPETMASTER_PORT_8140_TCP_ADDR --environment default"

# Run the agent with the provided hostname & args
docker build -t omd .
ID=$(docker run --privileged=true -d -t -h omdmaster04 --link=${NAME}:puppetmaster omd bash)

docker exec -it ${ID} /usr/bin/omd stop
docker exec -it ${ID} /usr/bin/omd config default set APACHE_TCP_ADDR 0.0.0.0
docker exec -it ${ID} /usr/bin/omd start
docker exec -it ${ID} bash

