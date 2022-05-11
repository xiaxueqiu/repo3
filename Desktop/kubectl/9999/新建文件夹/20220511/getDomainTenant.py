# coding=utf-8
import json
import getopt
import os
import sys
import MySQLdb

#MySQL相关配置，需根据实际情况作出修改
#mysql_host = "124.71.34.207"
mysql_host = "saasdb"
mysql_port = "3306"
mysql_user = "root"
mysql_passwd = "Saas!@HouseKeeper2022"
#文件名
filename = '/opt/module/datax/job/import/domain_tenant.txt'

#获取mysql连接
def get_connection():
    return MySQLdb.connect(host=mysql_host, port=int(mysql_port), user=mysql_user, passwd=mysql_passwd)


def get_mysql_column():
    result = []
    try:
       connection = get_connection()
       cursor = connection.cursor()
       sql = "select domain,tenant_id from housekeeperdb.tenant where tag=1"
       cursor.execute(sql)
       alldata = cursor.fetchall()
       for rec in alldata:
           result.append(rec[0]+'#'+rec[1])
    except Exception as e:
        print('Error msg :'+e)
    finally:
       cursor.close()
       connection.close()
    return result

#获取mysql表的指定列数据

def main(args):
    	mysql_columns = get_mysql_column()
        with open(filename,'a+') as f:
            for result in mysql_columns:         
                 f.write(str(result)+'\n')
        f.close()
if __name__ == '__main__':
    main(sys.argv[1:])
