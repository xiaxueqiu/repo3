case $1 in
  start)
        for i in cce02xiaxueqiu cce03xiaxueqiu cce04xiaxueqiu;do
        echo "========$i=========="
    ssh $i "/opt/module/zookeeper-3.5.7/bin/zkServer.sh start"
        done
   ;;
  stop)
        for i in cce02xiaxueqiu cce03xiaxueqiu cce04xiaxueqiu;do
        echo "========$i=========="
    ssh $i "/opt/module/zookeeper-3.5.7/bin/zkServer.sh stop"
        done
   ;;
  status)
        for i in cce02xiaxueqiu cce03xiaxueqiu cce04xiaxueqiu;do
        echo "========$i=========="
    ssh $i "/opt/module/zookeeper-3.5.7/bin/zkServer.sh status"
        done
   ;;
esac
