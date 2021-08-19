#!/bin/bash

# Exit early if any command fails
set -e

# Print all commands
set -x 

pwd

# ensure you're not running it on local machine
if [ -z "$CI" ] || [ -z "$GITHUB_REF" ]; then
    echo "Running on a local machine! Exiting!"
    exit 127
else
    echo "Running on CI"
fi




# BRANCH=$(git rev-parse --abbrev-ref HEAD)
# On Github the line above does not work, instead:
BRANCH=${GITHUB_REF##*/}
echo "on branch $BRANCH"
if [[ "$BRANCH" != "master" ]]; then
    echo 'Not on master branch! Aborting script!';
    exit 1;
fi


git clean -fdx .

GIT_COMMIT_HASH=$(git rev-parse --short "$GITHUB_SHA")


docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx ls
docker buildx create --name mybuilder
docker buildx use mybuilder


IMAGE_NAME=caprover/nginx-reverse-proxy
IMAGE_VERSION=1-$GIT_COMMIT_HASH

docker buildx build --platform linux/amd64,linux/arm64,linux/arm -t $IMAGE_NAME:$IMAGE_VERSION -t $IMAGE_NAME:latest -f Dockerfile --push .