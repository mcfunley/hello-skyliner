#!/bin/bash
set -euo pipefail # enable strict mode
IFS=$'\n\t'

if [[ (-z "${1-}") || (-z "${2-}") ]]; then
    echo "./push.sh <app token> <image filename>"
    exit -1
fi

TOKEN=$1
FILENAME=$2

# find the full git commit hash for the current commit
COMMIT=$(git rev-parse HEAD)
# get the upload URL
URL=$(curl -s -X POST https://www.skyliner.io/images/docker/$TOKEN/$COMMIT)
# upload to S3
curl --progress-bar --upload-file $FILENAME $URL > /dev/null
