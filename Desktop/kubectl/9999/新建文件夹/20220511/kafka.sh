#! /bin/bash

case $1 in
"start"){
    for i in cce02xiaxueqiu cce03xiaxueqiu cce04xiaxueqiu
    do
        echo " --------启动 $i Kafka-------"
        ssh $i "/opt/module/kafka/bin/kafka-server-start.sh -daemon /opt/module/kafka/config/server.properties"
    done
};;
"stop"){
    for i in cce02xiaxueqiu cce03xiaxueqiu cce04xiaxueqiu
    do
        echo " --------停止 $i Kafka-------"
        ssh $i "/opt/module/kafka/bin/kafka-server-stop.sh stop"
    done
};;
esac

