#!/bin/bash

start-web(){

for i in hadoop102;
do
	ssh $i "cd /opt/module/azkaban/azkaban-web;bin/start-web.sh"
done
}

stop-web(){

for i in hadoop102;
do
	ssh $i "cd /opt/module/azkaban/azkaban-web;bin/shutdown-web.sh"
	#;代表前后是两个命令
done
}

start-exec(){

for i in hadoop102 hadoop103 hadoop104;
do
	ssh $i "cd /opt/module/azkaban/azkaban-exec;bin/start-exec.sh"
done
}

activate-exec(){

for i in hadoop102 hadoop103 hadoop104;
do
	ssh $i "curl -G '$i:12321/executor?action=activate' && echo"
done
}

stop-exec(){

for i in hadoop102 hadoop103 hadoop104;
do
	ssh $i "/opt/module/azkaban/azkaban-exec/bin/shutdown-exec.sh"
done
}

case $1 in

start-exec)
	start-exec
	;;
activate-exec)
	activate-exec
	;;
stop-exec)
	stop-exec
	;;
start-web)
	start-web
	;;
stop-web)
	stop-web
	;;
start)
	echo "====启动executor===="
		start-exec
	sleep 10
	echo "====激活executor===="
	    activate-exec
	sleep 5
	echo "====启动webserver===="
	start-web
	;;
stop)
	echo "====关闭executor===="
	stop-exec
	echo "====关闭webserver===="
	stop-web
	;;
*)
	echo '输入参数错误.......'
esac
