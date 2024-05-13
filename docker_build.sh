#!/bin/bash

docker build --build-arg MYUSERNAME=`whoami` --build-arg S3BUCKETNAME=s22s-sanda -t yolov3_aws:latest .
