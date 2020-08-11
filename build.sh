#!/bin/bash
if [ -z "$2" ]
then
    export BUILD_DATE=$(date "+%Y-%m-%d")
else
    export BUILD_DATE=$2
fi

export PACKER_LOG=1
export PACKER_LOG_PATH=/tmp/windows10-$BUILD_DATE.log

cd "$( dirname "${BASH_SOURCE[0]}" )"

echo $BUILD_DATE

packer build -var-file=./vars/$1.json windows-base.json
packer build -var-file=./vars/$1.json windows-cloud.json
packer build -var-file=./vars/$1.json windows-ova.json
