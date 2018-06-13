FROM eoitek/centos-baseos:1.9
MAINTAINER Gavin Wang <gavin.wang@eoitek.com>

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.1
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Install Kafka, Zookeeper and other needed things
RUN yum update -y && \
    rm -rf /var/lib/apt/lists/* && \
    yum clean all
RUN yum install -y wget
RUN    wget -q http://mirror.bit.edu.cn/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz 
RUN    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

ADD start-kafka.sh /usr/bin/start-kafka.sh
RUN chmod +x /usr/bin/start-kafka.sh

# 9092 is kafka
EXPOSE  9092

CMD ["/bin/sh", "-c", "/usr/bin/start-kafka.sh"]


COPY entrypoint.sh /

ENTRYPOINT ["/usr/local/bin/dumb-init", "/entrypoint.sh"]

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zookeeper/bin

CMD ["zkServer.sh", "start-foreground"]