#!/bin/bash
tenant_id=$1
do_date=$2
domain=$3
obs_path='obs://obs-east-bkt001/origin_data/db'
ods_user="
load data inpath '${obs_path}/user_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_user partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_order="
load data inpath '${obs_path}/t_order_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_order  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_service_sku="
load data inpath '${obs_path}/t_service_sku_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_service_sku  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_task="
load data inpath '${obs_path}/t_task_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_task  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_message="
load data inpath '${obs_path}/message_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_message  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_housekeeper_service="
load data inpath '${obs_path}/t_housekeeper_service_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_housekeeper_service  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_service_option="
load data inpath '${obs_path}/t_service_option_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_service_option  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

ods_t_service_specification="
load data inpath '${obs_path}/t_service_specification_full/${do_date}/${domain}/${tenant_id}' OVERWRITE into table ods_t_service_specification  partition(dt='${do_date}',domain='${domain}',tenant_id='${tenant_id}');"

hive -e "$ods_user$ods_t_service_sku$ods_t_order$ods_t_task$ods_message$ods_t_housekeeper_service$ods_t_service_option$ods_t_service_specification"
