#!/bin/bash

superset_status(){
    result=`ps -ef | awk '/gunicorn/ && !/awk/{print $2}' | wc -l`
	#查找gunicorn进程，看superset是否启动，启动的话，result返回结果不为0
	#过滤gunicorn 和过滤superset效果一样
    if [[ $result -eq 0 ]]; then
        return 0
		##superset未运行
    else
        return 
		#superset已启动
    fi
}
superset_start(){
		source ~/.bashrc
		#防止miniconda环境变量不能用
        superset_status >/dev/null 2>&1
		#调用superset_status     把日志给黑洞
        if [[ $? -eq 0 ]]; then
		#$?  返回上一条命令的结果
		#激活superset环境 再启动superset
            conda activate superset ; gunicorn --workers 5 --timeout 120 --bind hadoop102:8787 --daemon 'superset.app:create_app()'
        else
            echo "superset正在运行"
        fi

}

superset_stop(){
    superset_status >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "superset未在运行"
    else
        ps -ef | awk '/gunicorn/ && !/awk/{print $2}' | xargs kill -9
    fi
}


case $1 in
    start )
        echo "启动Superset"
        superset_start
    ;;
    stop )
        echo "停止Superset"
        superset_stop
    ;;
    restart )
        echo "重启Superset"
        superset_stop
        superset_start
    ;;
    status )
        superset_status >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            echo "superset未在运行"
        else
            echo "superset正在运行"
        fi
esac
