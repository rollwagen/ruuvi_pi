FROM maven:3.5.3-jdk-8-alpine AS builder

RUN apk update && apk add --no-cache git
ADD . /ruuvi-collector
WORKDIR /ruuvi-collector
RUN git clone https://github.com/Scrin/RuuviCollector && cd RuuviCollector && mvn clean package



FROM ubuntu:20.10

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "APT::Get::Assume-Yes \"true\";" >> /etc/apt/apt.conf.d/90forceyes
RUN echo "APT::Get::force-yes \"true\";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update 
RUN apt-get install apt-utils
RUN apt-get upgrade

RUN apt-get install bluez bluez-hcidump openjdk-14-jre-headless pi-bluetooth
RUN apt autoremove
RUN apt clean
CMD ["java", "--version"]
