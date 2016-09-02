FROM ubuntu:16.04
MAINTAINER Steve Kite <steve@actor.im>

RUN apt-get update && apt-get install -y openjdk-8-jre && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /data