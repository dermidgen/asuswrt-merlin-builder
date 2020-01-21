#!/usr/bin/env bash

# docker build -t asus-merlin-docker:latest ./

docker run \
  -it --rm \
  -v $(pwd)/docker-entry.sh:/opt/merlin/docker-entry.sh \
  -v $(pwd)/src:/opt/merlin/src \
  asus-merlin-docker:latest /opt/merlin/docker-entry.sh "$@"
