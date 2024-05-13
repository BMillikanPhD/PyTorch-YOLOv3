#!/bin/bash

docker run -d --rm -it                              \
    --runtime=nvidia                                \
    --gpus all                                      \
    --ipc=host                                      \
    --device /dev/fuse                              \
    --cap-add SYS_ADMIN                             \
    --security-opt apparmor:unconfined              \
    --volume "${HOME}:/root"                        \
    --env AWS_ACCESS_KEY=$AWS_ACCESS_KEY_ID         \
    --env AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY     \
    yolov3_aws:latest
