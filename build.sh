#!/bin/bash
export BUILD_DATE=$(date "+%Y-%m-%d")
export PACKER_LOG=1
export PACKER_LOG_PATH=/tmp/windows10-$BUILD_DATE.log

cd "$( dirname "${BASH_SOURCE[0]}" )"

packer build -var-file=./vars/$1.json $1.json
#packer build -var-file=./vars/$1.json $1-ova.json 
