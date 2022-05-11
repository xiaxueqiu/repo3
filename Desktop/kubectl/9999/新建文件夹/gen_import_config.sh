#!/bin/bash

#DataX配置文件批量生成脚本
tenant_database=tenant_0f044adadbd240a08b35a1786b5dc62e
python ~/bin/gen_import_config.py -d ${tenant_database} -t user
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_order
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_service_sku
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_task
python ~/bin/gen_import_config.py -d ${tenant_database} -t message
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_housekeeper_service
python ~/bin/gen_import_config.py -d ${tenant_database} -t flyway_schema_history
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_service_option              
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_customization
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_service_selection
python ~/bin/gen_import_config.py -d ${tenant_database} -t t_service_specification
