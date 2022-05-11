#!/bin/bash
sh  mysql_to_obs_full.sh   'tenant_0f044adadbd240a08b35a1786b5dc62e'  '2020-06-15'  'xinhuacun' 
#sh  mysql_to_obs_full.sh   'tenant_2fbeb8c3e0c34760952d16b6672fdbc2'  '2020-06-15'  'loudong'
sh obs_ods_hive.sh    '2020-06-15'  'xinhuacun'
#sh obs_ods_hive.sh    '2020-06-15'  'loudong'

#sh  mysql_to_obs_full.sh   $tenant_id   $do_date  $domain 
