#!/bin/bash
if [ -f /opt/module/datax/job/import/domain_tenant.txt  ]; then
  rm -rf /opt/module/datax/job/import/domain_tenant.txt
fi
python ~/bin/getDomainTenant.py

# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$1" ] ;then
    do_date=$1
else 
    do_date=`date -d "-1 day" +%F`
fi

do_date='2020-06-14'
cat /opt/module/datax/job/import/domain_tenant.txt | while read line
do
  OLD_IFS="$IFS"   
  IFS="#"   
  arr=($line)
  domain=${arr[0]}
  tenant=${arr[1]}
  tenant_id="tenant_${tenant}"

sh  mysql_to_obs_full.sh   ${tenant_id}   ${do_date}   ${domain}     
sh  obs_hive_ods.sh   ${tenant_id}   ${do_date}   ${domain}   
  IFS="$OLD_IFS"   
done

#恢复原来的分隔符
IFS="$OLD_IFS"

sh  obs_to_ods_log.sh  ${do_date} 