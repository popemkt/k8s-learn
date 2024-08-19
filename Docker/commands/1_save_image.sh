#!/bin/bash

# Pull the hello-world image
docker pull hello-world

# Run the hello-world image
docker run hello-world

# Save the hello-world image to a tar file
docker save hello-world --output hello-world.tar
# for podman
podman save --format docker-archive --output hello-world.tar hello-world

# Load the hello-world image from the tar file
docker load -i hello-world.tar

# Quick and dirty way to get a running container quickly
docker run -it alpine sh &
# Save the running container as a new image
CONTAINER_ID=$(docker ps -q --filter "ancestor=alpine" --filter "status=running" | head -n 1)
docker commit $CONTAINER_ID saved-container-image

# Save the new image to a tar file
docker save saved-container-image --output saved-container-image.tar
