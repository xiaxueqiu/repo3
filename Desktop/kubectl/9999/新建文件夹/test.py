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
mysql_passwd = "Saas1234"

#获取mysql连接
def get_connection():
    return MySQLdb.connect(host=mysql_host, port=int(mysql_port), user=mysql_user, passwd=mysql_passwd)

def get_databases():
    connection = get_connection()
    cursor = connection.cursor()
    sql = "show databases"
    cursor.execute(sql)
    fetchall = cursor.fetchall()
    cursor.close()
    connection.close()
    return fetchall

#获取mysql表的列名
def get_databases_columns():
    return map(lambda x: x[0], get_databases())
    
    
    
    
    
##################################


#生成json文件

def main(args):

     databasesname = get_databases_columns()
     print databasesname

if __name__ == '__main__':
    main(sys.argv[1:])
