FROM maven:3.5.3-jdk-8-alpine AS builder

RUN apk update && apk add --no-cache git
RUN git clone https://github.com/Scrin/RuuviCollector
WORKDIR ./RuuviCollector 
RUN mvn clean package



FROM ubuntu:20.10

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "APT::Get::Assume-Yes \"true\";" >> /etc/apt/apt.conf.d/90forceyes
RUN echo "APT::Get::force-yes \"true\";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update 
RUN apt-get install apt-utils
RUN apt-get upgrade

RUN apt-get install bluez bluez-hcidump openjdk-14-jre-headless pi-bluetooth && \
	apt autoremove && apt clean
COPY --from=builder /RuuviCollector ./RuuviCollector
WORKDIR ./RuuviCollector
RUN echo "influxUrl=http://192.168.1.20:8086" > ruuvi-collector.properties
CMD ["java", "-jar", "target/ruuvi-collector-0.2.jar"]

