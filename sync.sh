#!/bin/bash

ID=$(docker ps | awk '$2 ~ /puppetmaster:latest/ {print $1}')

docker exec -it ${ID} puppet module install puppetlabs/stdlib
docker exec -it ${ID} puppet module install puppetlabs/apt
docker exec -it ${ID} puppet module install stahnma/epel
docker exec -it ${ID} puppet module install nanliu/staging
docker exec -it ${ID} puppet module install puppetlabs/xinetd
docker exec -it ${ID} puppet module install puppetlabs/concat
docker exec -it ${ID} puppet module install dalen/puppetdbquery

./docker-cp/docker-cp ./puppet-code/ ${ID}:/etc/puppet/environments/default/
docker exec -it ${ID} supervisorctl restart unicorn


