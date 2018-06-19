#!/bin/sh

# based on https://github.com/apache/zookeeper/blob/trunk/conf/zoo_sample.cfg
cat > /itoaServicePackage/itoaservice.conf <<EOF
##采集器上报数据的路由信息
agent {
hosts = ["$HOST_IP"] //实际部署中,为客户采集器ip地址
port = "5044"
metadata = ["@collectiontime=Date", "@hostname=String", "@rownumber=Long", "@path=String", "@subpath=String",
"@sourceip=String", "@message=String"]
}
##ITOA Service信息设置
server {
ip = "$HOST_IP" //ip 一般为当前服务器IP,可以用默认值"0.0.0.0"
port = 6688
urlSecret = "EBA7AA43D165FC6BF49C0549A8A55D35"
sessionTimeout = 6
groupId = "itoaServiceConsumerDev"
isRedis = false //是否启用session保存在redis中,如果为否session保存到数据库
}
##kafka信息设置
kafka {
kafka.bootstrap.servers = "$KAFKA_SERVERS"
zookeeper.connect = "$ZOOKEEPER_SERVERS"
partitions = 1
replications = 2 //副本数建议设置为2
polltimeout = 5000
}
##ITOA管理信息交互，kafka topic设置
topic {
itoa_to_gw_req = "ITOA_TO_GW_REQ"
itoa_to_gw_rsp = "ITOA_TO_GW_RSP"
gw_to_itoa_req = "GW_TO_ITOA_REQ"
gw_to_itoa_rsp = "GW_TO_ITOA_RSP"
itoa_to_sm_req = "ITOA_TO_SM_REQ"
itoa_to_sm_rsp = "ITOA_TO_SM_RSP"
sm_to_itoa_req = "SM_TO_ITOA_REQ"
sm_to_itoa_rsp = "SM_TO_ITOA_RSP"
itoa_to_hub_req = "ITOA_TO_HUB_REQ"
itoa_to_hub_rsp = "ITOA_TO_HUB_RSP"
hub_to_itoa_req = "HUB_TO_ITOA_REQ"
hub_to_itoa_rsp = "HUB_TO_ITOA_RSP"
itoa_to_alarm_req = "ITOA_TO_ALARM_REQ"
itoa_to_alarm_rsp = "ITOA_TO_ALARM_RSP"
alarmEventTopic = "event_out"
alarm_to_itoa_req = "ALARM_TO_ITOA_REQ"
alarm_to_itoa_rsp = "ALARM_TO_ITOA_RSP"
itoa_to_dm_req = "ITOA_TO_DM_REQ"
itoa_to_dm_rsp = "ITOA_TO_DM_RSP"
dm_to_itoa_req = "DM_TO_ITOA_REQ"
dm_to_itoa_rsp = "DM_TO_ITOA_RSP"
itoa_to_pm_req = "ITOA_TO_PM_REQ"
itoa_to_pm_rsp = "ITOA_TO_PM_RSP"
pm_to_itoa_req = "PM_TO_ITOA_REQ"
pm_to_itoa_rsp = "PM_TO_ITOA_RSP"
alarmEventTopic = "event_out"
}
##数据库连接设置 设置数据库名与密码 集群中不同节点配置同一数据库即可
dbConnection {
drives = "jdbc:mysql://$DBCONN_IP:3306/DB01?characterEncoding=utf8&useSSL=false"
user = "root"
password = "$ROOT_PASSWD"
}
##redis连接设置
redis {
clusterList = "$REDIS_LIST"
prefix = "DevTest"
}
##itoa id生成，集群中设置0~4
snowflake {
worker_id = 0
}
##akka集群中设置
akkaCluster {
clusterNodes = "$AKKA_IPS"
hostname = "$HOST_IP" //当前服务器节点,当集群环境为多个服务器是,必须制定IP
port = 2551
}
##spl集群中设置
spl {
url = "http://192.168.32.21:9910"
requestTimeout = 10
}
##sso设置
sso {
classname = "s.com.eoi.service.user.SSODefaultServiceImp"
authserver = "http://192.168.32.21:18088/sso/auth"
isRawLogin = true
}
EOF