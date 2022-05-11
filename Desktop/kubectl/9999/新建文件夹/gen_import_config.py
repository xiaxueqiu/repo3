# coding=utf-8
import json
import getopt
import os
import sys
import MySQLdb

#MySQL配置
#mysql_host = "124.71.34.207"
mysql_host = "saasdb"
mysql_port = "3306"
mysql_user = "root"
mysql_passwd = "Saas!@HouseKeeper2022"


#生成配置文件的目标路径，可根据实际情况作出修改
output_path = "/opt/module/datax/job/import"
#obs路径，可根据实际情况作出修改
obs_addr = "obs://obs-east-bkt001"
#获取mysql连接
def get_connection():
    return MySQLdb.connect(host=mysql_host, port=int(mysql_port), user=mysql_user, passwd=mysql_passwd)

#获取表格的元数据  包含列名和数据类型
def get_mysql_meta(database, table):
    connection = get_connection()
    cursor = connection.cursor()
    sql = "SELECT COLUMN_NAME,DATA_TYPE from information_schema.COLUMNS WHERE TABLE_SCHEMA=%s AND TABLE_NAME=%s ORDER BY ORDINAL_POSITION"
    cursor.execute(sql, [database, table])
    fetchall = cursor.fetchall()
    cursor.close()
    connection.close()
    return fetchall

#获取mysql表的列名
def get_mysql_columns(database, table):
    return map(lambda x: x[0], get_mysql_meta(database, table))

#将获取的元数据中mysql的数据类型转换为hive的数据类型  写入到hdfswriter中
def get_hive_columns(database, table):
    def type_mapping(mysql_type):
        mappings = {
            "bigint": "bigint",
            "int": "bigint",
            "smallint": "bigint",
            "tinyint": "bigint",
            "decimal": "string",
            "double": "double",
            "float": "float",
            "binary": "string",
            "char": "string",
            "varchar": "string",
            "datetime": "string",
            "time": "string",
            "timestamp": "string",
            "date": "string",
            "text": "string",
            "mediumtext": "string"
        }
        return mappings[mysql_type]

    meta = get_mysql_meta(database, table)
    return map(lambda x: {"name": x[0], "type": type_mapping(x[1].lower())}, meta)

#生成json文件
def generate_json(source_database, source_table):
    job = {
        "job": {
            "setting": {
                "speed": {
                    "channel": 3
                },
                "errorLimit": {
                    "record": 0,
                    "percentage": 0.02
                }
            },
            "content": [{
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "username": mysql_user,
                        "password": mysql_passwd,
                        "column": get_mysql_columns(source_database, source_table),
                        "splitPk": "",
                        "connection": [{
                            "table": [source_table],
                            "jdbcUrl": ["jdbc:mysql://" + mysql_host + ":" + mysql_port + "/" + source_database]
                        }]
                    }
                },
                "writer": {
                    "name": "hdfswriter",
                    "parameter": {
                        "defaultFS": obs_addr,
                        "fileType": "text",
                        "path": "${targetdir}",
                        "fileName": source_table,
                        "column": get_hive_columns(source_database, source_table),
                        "writeMode": "append",
                        "fieldDelimiter": "\t",
                        "compress": "gzip",
                        "hadoopConfig": {
                            "fs.obs.impl": "org.apache.hadoop.fs.obs.OBSFileSystem",
                            "fs.AbstractFileSystem.obs.impl": "org.apache.hadoop.fs.obs.OBS",
                            "fs.obs.access.key": "S5QNTCSGERXH8FSD3MIL",
                            "fs.obs.secret.key": "JtxwXFqlmykoo0yY2VjHmaCghP4xh4zCGUhJQg0o",
                            "fs.obs.endpoint": "obs.cn-north-4.myhuaweicloud.com"
                         }  
                        
                    }
                }
            }]
        }
    }
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    with open(os.path.join(output_path, ".".join(["tenant_"+source_table, "json"])), "w") as f:
        json.dump(job, f)


def main(args):
    source_database = ""
    source_table = ""

    options, arguments = getopt.getopt(args, '-d:-t:-y:', ['sourcedb=', 'sourcetbl=','sourcedomain='])
    for opt_name, opt_value in options:
        if opt_name in ('-d', '--sourcedb'):
            source_database = opt_value
        if opt_name in ('-t', '--sourcetbl'):
            source_table = opt_value

    generate_json(source_database, source_table)


if __name__ == '__main__':
    main(sys.argv[1:])
