#!/bin/bash

#从第1个参数获取cube_name
cube_name=$1

#从第2个参数获取构建cube时间
if [ -n "$2" ]
then
    do_date=$2
else
    do_date=`date -d '-1 day' +%F`
fi

#获取执行时间的00:00:00时间戳(0时区)
start_date_unix=`date -d "$do_date 08:00:00" +%s`
#秒级时间戳变毫秒级
#s%获取秒级时间戳


start_date=$(($start_date_unix*1000))
#rest api里面需要毫秒级的时间戳

#获取执行时间的24:00的时间戳
stop_date=$(($start_date+86400000))

curl -X PUT -H "Authorization: Basic QURNSU46S1lMSU4=" -H 'Content-Type: application/json' -d '{"startTime":'$start_date', "endTime":'$stop_date', "buildType":"BUILD"}' http://hadoop102:7070/kylin/api/cubes/$cube_name/build
