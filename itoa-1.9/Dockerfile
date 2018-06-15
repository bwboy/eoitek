FROM eoitek/centos-baseos:1.9
MAINTAINER Gavin Wang <gavin.wang@eoitek.com>

RUN mkdir -p /data
COPY itoaServicePackage /itoaServicePackage
WORKDIR /itoaServicePackage


ENV HOST_IP="0.0.0.0"
ENV KAFKA_SERVERS="127.0.0.0:9092"
ENV ZOOKEEPER_SERVERS="127.0.0.0:2181"
ENV DBCONN_IP="127.0.0.1"
ENV ROOT_PASSWD="eoitek"
ENV REDIS_LIST="192.168.32.21:6379, 192.168.32.22:6379, 192.168.32.23:6379"
ENV AKKA_IPS="akka.tcp://itoa@192.168.32.21:2551,akka.tcp://itoa@192.168.32.22:2551,akka.tcp://itoa@192.168.32.23:2551"

ENTRYPOINT ["/usr/local/bin/dumb-init", "/itoaServicePackage/itoaService-restart.sh"]

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/itoaServicePackage/bin

CMD ["init_config.sh", "start-foreground"]