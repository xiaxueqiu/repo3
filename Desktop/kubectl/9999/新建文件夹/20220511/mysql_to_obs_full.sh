#!/bin/bash
DATAX_HOME=/opt/module/datax
database=$1
domain=$3

#传入数据库的名称
# 如果传入日期则do_date等于传入的日期，否则等于前一天日期
if [ -n "$2" ] ;then
do_date=$2
else
do_date=`date -d "-1 day" +%F`
fi

#obs_target="obs://obs-east-bkt001/origin_data/db/user_full/$do_date/$domain"

#处理目标路径，此处的处理逻辑是，如果目标路径不存在，则创建；
#若存在，则清空，目的是保证同步任务可重复执行
handle_targetdir() {

obs_target="obs://obs-east-bkt001/${1}"

hadoop fs -test -e $obs_target
  if [[ $? -eq 1 ]]; then
    echo "路径$1不存在，正在创建......"
	echo "${1}"
    hadoop fs -mkdir -p "$obs_target"
  else
    echo "路径$1已经存在"
#fs_count=$(hadoop fs -count $1)
#content_size=$(echo $fs_count | awk '{print $3}')
		
		#  if [[ $content_size -eq 0 ]]; then
		#  echo "路径$1为空"
		#  else
		#  echo "路径$1不为空，正在清空......"
	    #hadoop fs -rm -r -f $1/*
	    #	fi
  fi
}

#数据同步
import_data() {
datax_config=$1
target_dir=$2

handle_targetdir $target_dir
  python $DATAX_HOME/bin/datax.py -p"-Dtargetdir=$target_dir -Ddatabase=$database" $datax_config
}


 echo -e "${database} #### ${do_date}-------${domain} "


import_data /opt/module/datax/job/import/tenant_user.json /origin_data/db/user_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_t_order.json /origin_data/db/t_order_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_t_service_sku.json /origin_data/db/t_service_sku_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_t_task.json /origin_data/db/t_task_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_t_service_option.json /origin_data/db/t_service_option_full/$do_date/$domain/$database 
import_data /opt/module/datax/job/import/tenant_t_housekeeper_service.json /origin_data/db/t_housekeeper_service_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_message.json /origin_data/db/message_full/$do_date/$domain/$database
import_data /opt/module/datax/job/import/tenant_t_service_specification.json /origin_data/db/t_service_specification_full/$do_date/$domain/$database
