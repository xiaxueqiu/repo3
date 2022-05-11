#!/bin/bash
for i in cce02xiaxueqiu cce03xiaxueqiu; do
    echo "========== $i =========="
    ssh $i "cd /opt/module/applog/; java -jar gmall2020-mock-log-2021-01-22.jar >/dev/null 2>&1 &"
done
