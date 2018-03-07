#!/bin/bash

set -e

# docker build -t headless .

docker run -it --rm \
  --name headless \
  --shm-size=1024m \
  -p=127.0.0.1:9222:9222 \
  --cap-add=SYS_ADMIN \
  headless
