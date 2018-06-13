#!/bin/sh


cat > /kafka/config/server.properties <<EOF
##Server Basics##
#broker.id=1 //不同服务器id不可重复
delete.topic.enable=true
##Socket Server Settings##
#listeners=PLAINTEXT://192.168.32.21:9092
#advertised.listeners=PLAINTEXT://localhost:9092
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/data/kafka-2.11-0.10.2.1/log
##Log Basics##
log.dirs=/data/kafka-2.11-0.10.2.1/kafka-logs
num.partitions=3
num.recovery.threads.per.data.dir=1
##Log Retention Policy##
log.retention.hours=24
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
##Zookeeper集群地址##
#zookeeper.connect=192.168.32.21:2181,192.168.32.22:2181,192.168.32.23:2181
##Timeout in ms for connecting to zookeeper##
zookeeper.connection.timeout.ms=6000
EOF

#broker.id
echo "broker.id=\"$ID !">> /kafka/config/server.properties
echo "listeners=PLAINTEXT://\"$PLAINTEXT\" :9092!" >> /kafka/config/server.properties
echo "advertised.listeners=PLAINTEXT://\"$PLAINTEXT\":9092!" >> /kafka/config/server.properties

# zookeeper Server conigure
if [ -n "$SERVERS" ]; then
    printf '%s' "$SERVERS" | awk 'BEGIN { RS = "," }; { printf "server.%i=%s:2888:3888\n", NR, $0 }' >> /kafka/config/server.properties
fi