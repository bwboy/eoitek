FROM eoitek/centos-baseos:1.9
MAINTAINER Gavin Wang <gavin.wang@eoitek.com>

ARG ES_VERSION=5.4.3
# avoid conflicts with debian host systems when mounting to host volume
ARG DEFAULT_ES_USER_UID=1100

ADD https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION.tar.gz /tmp
# need to adapt to both Docker's new remote-unpack-ADD behavior and the old behavior
RUN cd /usr/share && \
  if [ -f /tmp/elasticsearch-$ES_VERSION.tar.gz ]; then \
    tar xf /tmp/elasticsearch-$ES_VERSION.tar.gz; \
    else mv /tmp/elasticsearch-${ES_VERSION} /usr/share; \
    fi && \
  rm -f /tmp/elasticsearch-$ES_VERSION.tar.gz

EXPOSE 9200 9300

HEALTHCHECK --timeout=5s CMD wget -q -O - http://$HOSTNAME:9200/_cat/health

ENV ES_HOME=/usr/share/elasticsearch-$ES_VERSION \
    DEFAULT_ES_USER=elasticsearch \
    DEFAULT_ES_USER_UID=$DEFAULT_ES_USER_UID \
    ES_JAVA_OPTS="-Xms1g -Xmx1g"

RUN adduser -r -s /bin/sh -u $DEFAULT_ES_USER_UID $DEFAULT_ES_USER

VOLUME ["/data","/conf"]

WORKDIR $ES_HOME

COPY java.policy /usr/java/jdk1.8.0_172/jre/lib/security/
COPY start /start
COPY log4j2.properties $ES_HOME/config/

CMD ["/start"]

RUN mkdir -p /data/elasticsearch/data
VOLUME /data/elasticsearch/data

COPY entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/entrypoint.sh"]
CMD ["elasticsearch"]