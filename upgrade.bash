#!/bin/bash

TAG=9.5.10.3777
MANAGEMENT_CONSOLE_TAG=1.0.97
REGISTRY='zartifactory.zerto.local:8081/zvm-docker-registry/release/jameson_u1'
VERSION=$(echo $TAG | rev | cut -d"." -f2-  | rev)
LOG_FILE=$VERSION.log
LOG_DIR=/var/log/zerto/containers/upgrade

sudo mkdir -p $LOG_DIR

log(){    

     echo -e "$(date) $1" | sudo tee -a "$LOG_DIR/$LOG_FILE"

}

log "Replacing registry path"
sed -i 's|localhost:5000|'$REGISTRY'|g' /opt/zerto/zvr/docker-compose.local.yml

log "About to upgrade containers to "$VERSION 
TAG=$TAG MANAGEMENT_CONSOLE_TAG=$MANAGEMENT_CONSOLE_TAG docker-compose -f /opt/zerto/zvr/docker-compose.local.yml -f /opt/zerto/zvr/docker-compose.yml --env-file /opt/zerto/zvr/.env up -d

log "Finshied updgrade containers of version "$VERSION 

