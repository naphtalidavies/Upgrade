#!/bin/bash

LOG_DIR=/var/log/zerto/containers/upgrade

TAG=9.5.10.3777
MANAGEMENT_CONSOLE_TAG=1.0.97
VERSION=$(echo $TAG | rev | cut -d"." -f2-  | rev)
 echo $VERSION
LOG_FILE=$VERSION.log

sudo mkdir -p $LOG_DIR
log(){    

     echo -e "$(date) $1" | sudo tee -a "$LOG_DIR/$LOG_FILE"

}

log "Replacing registry path"
sed -i 's|localhost:5000|zartifactory.zerto.local:8081/zvm-docker-registry/release/jameson_u1|g' docker-compose.local.yml

log "About to upgrade containers to "$VERSION 
TAG=$TAG MANAGEMENT_CONSOLE_TAG=$MANAGEMENT_CONSOLE_TAG docker-compose -f /home/naphtali/zlinux/zvm/docker-compose.local.yml -f /home/naphtali/zlinux/zvm/docker-compose.yml --env-file /home/naphtali/zlinux/zvm/.env up -d

log "Finshied updgrade containers of version "$VERSION 

