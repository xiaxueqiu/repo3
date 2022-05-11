#!/bin/bash


#!/bin/bash
if [ $# -lt 1 ]
then
    echo "No Args Input..."
    exit ;
fi
case $1 in
"start")
        echo " =================== 启动 hadoop集群 ==================="
         hdp.sh start
         sleep 10
        echo " =================== 启动 zk  ==================="
         zk.sh start
         sleep 10
         echo " ===================启动 kafka ==================="
         kafka.sh start
;;
"stop")

         echo " ===================关闭  kafka ==================="
         kafka.sh stop
	 sleep 10
          echo " =================== 关闭  zk  ==================="
         zk.sh stop
         sleep 10
        echo " =================== 关闭 hadoop集群 ==================="
         hdp.sh stop

;;
*)
    echo "Input Args Error..."
;;
esac

