#!/bin/bash
obs_path='obs://obs-east-bkt001/origin_data/log'
${do_date}
hive=/opt/module/hive/bin/hive
hadoop=/opt/module/hadoop-3.1.1/bin/hadoop
# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$1" ] ;then
   do_date=$1
else 
   do_date=`date -d "-1 day" +%F`
fi 

#
sql="
load data inpath '${obs_path}/${do_date}' into table ods_log partition(dt='$do_date');
"
$hive -e "$sql"
