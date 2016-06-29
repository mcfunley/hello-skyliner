#!/bin/bash
set -euo pipefail # enable strict mode
IFS=$'\n\t'

# log into the ECR registry
eval $(aws ecr get-login)
APP=${PWD##*/}

# get the ECR repository name
IMAGE=$(aws ecr describe-repositories --repository-names $APP --query 'repositories[0].repositoryUri' --output text)

# get the Git commit hash
SHA=$(git rev-parse HEAD)

# build the image
docker build -t $IMAGE:$SHA .

# push the image to the ECR repository
docker push $IMAGE
