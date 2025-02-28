#!/usr/bin/env bash

set -x

docker stop jupyter-server || true
docker rm jupyter-server || true

# Create the volume if it doesn't exist
docker volume create jupyter-cache || true

docker run -d \
	--gpus all \
	--network=host \
	--restart always \
	-v jupyter-cache:/root/.cache \
	--name jupyter-server \
	florinandrei/jupyter-server:latest

echo "wait 10 seconds..."
sleep 10

docker logs jupyter-server
