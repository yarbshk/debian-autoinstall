#!/bin/bash
set -e

# Usage:
# ./build-docker-image.sh --build-arg COMPONENT_NAME=xyz

docker build -t mykali:latest "$@" .
