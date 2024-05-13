FROM ubuntu:20.04

# Passed into `docker build` command
ARG S3BUCKETNAME
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Some utilities
RUN apt-get update -y && \
    apt-get install -y build-essential libfuse-dev libcurl4-openssl-dev libxml2-dev pkg-config libssl-dev mime-support automake libtool wget tar git unzip
RUN apt-get install lsb-release -y  && apt-get install zip -y && apt-get install vim -y

## Install AWS CLI
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && apt-get clean

RUN pip3 --no-cache-dir install --upgrade awscli

RUN pip3 --no-cache-dir install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

ADD requirements.txt .
RUN pip3 --no-cache-dir install -r requirements.txt

## Install S3 Fuse
RUN rm -rf /usr/src/s3fs-fuse
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse/ /usr/src/s3fs-fuse
WORKDIR /usr/src/s3fs-fuse 
RUN ./autogen.sh && ./configure && make && make install

## change workdir to /root
WORKDIR /root

## Set the directory where you want to mount your s3 bucket
ENV S3_MOUNT_DIRECTORY=/root/aws

## Replace with your s3 bucket name
ENV S3_BUCKET_NAME=${S3BUCKETNAME}

## Entry Point
#ADD start-script.sh .
COPY start-script.sh /usr/local/bin/start-script.sh
RUN chmod 755 /usr/local/bin/start-script.sh 
CMD ["/bin/bash"]
