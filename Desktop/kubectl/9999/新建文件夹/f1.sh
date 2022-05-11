#! /bin/bash
case $1 in
"start"){
for i in cce02xiaxueqiu cce03xiaxueqiu
do
echo " --------启动 $i 采集flume-------"
ssh $i "nohup /opt/module/flume/bin/flume-ng agent -n a1 -c /opt/module/flume/conf/ -f /opt/module/flume/jobs/taildir_kafka.conf -Dflume.root.logger=INFO,LOGFILE >/dev/null 2>&1&"
done
};;	
"stop"){
for i in cce02xiaxueqiu cce03xiaxueqiu
do
echo " --------停止 $i 采集flume-------"
ssh $i "ps -ef | grep taildir_kafka.conf  | grep -v grep |awk '{print \$2}' | xargs -n1 kill -9 "
done
};;
esac
