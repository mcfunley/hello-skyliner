#!/bin/bash
set -euo pipefail # enable strict mode
IFS=$'\n\t'

TOKEN="${1-}"
if [ -z $TOKEN ]; then
    echo "./upload.sh <app token>"
    exit -1
fi

# build the image
docker build -t hello-skyliner .

# save the image to a TAR file
docker save hello-skyliner -o image.tar

# find the full git commit hash for the current commit
COMMIT=$(git rev-parse HEAD)

# get the upload URL
URL=$(curl -s -X POST http://localhost:8080/images/docker/$TOKEN/$COMMIT)

# upload to S3
curl --progress-bar --upload-file image.tar $URL > /dev/null
