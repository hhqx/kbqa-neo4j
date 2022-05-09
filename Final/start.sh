#!/bin/bash
sleep 1
################################# 判断端口7474是否被占用, 未被占用则启动neo4j服务器 #################################
CMD_PID=`lsof -i:7474 | grep 'LISTEN'  | grep 'IPv4' | awk '{print $1":"$2}' | xargs echo`
if [ $CMD_PID ]
    then
    echo "端口7474已被占用: $CMD_PID"
    # to stop: using 'neo4j stop' or 'kill -9 PID'
else
    # 创建文件
    touch /app/logs/neo4j.log
    # 开启neo4j
    /app/neo4j-community-4.4.6/bin/neo4j console >> /app/logs/neo4j.log &
    echo 'waitting neo4j to start...'
    sleep 5
fi

################################# 判断端口8888是否被占用, 未被占用则启动jupyter服务器 #################################
CMD_PID=`lsof -i:8888 | grep 'LISTEN'  | grep 'IPv4' | awk '{print $1":"$2}' | xargs echo`
if [ $CMD_PID ]
    then
    echo "端口8888已被占用: $CMD_PID"
    # 查看jupyter进程
    # ps -ef | grep 'jupyter-notebook --notebook-dir=' | grep -v grep
    # 杀死包含'jupyter-notebook --notebook-dir=' 命令的jupyter进程
    # ps -ef | grep 'jupyter-notebook --notebook-dir=' | grep -v grep | awk '{print $2}' | xargs kill -9
else
    # 创建文件
    touch /app/logs/jupyter.log
    # 开启jupyter
    echo "waitting jupyter to start...."
    nohup jupyter-notebook --notebook-dir='/app/jupyter' --allow-root --port=8888 >> /app/logs/jupyter.log 2>&1 &
    sleep 2
fi
bash
# 查看neo4j进程
# ps -aux |grep neo4j|grep -v grep 

# 修改neo4j默认密码为kbqa
# RUN app/change-neo4j-default-password.sh
#/app/change-neo4j-pwr

#echo "\n\n\nloading csv data..."
# 导入本地csv数据
#cd /app/jupyter/src
#python3.6 -u csv2neo4j.py

# echo "\n\n\开启jupyter-notebook...\n\n"
# 查看jupyter进程
# ps -ef | grep 'jupyter-notebook --notebook-dir=' | grep -v grep
# 杀死jupyter进程
# ps -ef | grep 'jupyter-notebook --notebook-dir=' | grep -v grep | awk '{print $2}' | xargs kill -9

# # 开启jupyter
# jupyter-notebook --notebook-dir='/app/jupyter' --allow-root --port=8888

# ps -aux |grep gerrit |grep -v grep |awk '{print "kill -9 " $2}'
# ps -aux |grep jupyter|grep -v grep |awk '{print "kill -9 " $2}'

# # 查看jupyter进程
# ps -aux |grep jupyter|grep -v grep 
# # 杀死jupyter进程
# ps -aux |grep jupyter|grep -v grep |awk '{kill -9 $2}'

# 查看start.sh进程
# ps -aux |grep start.sh|grep -v grep 

# ps -ef | grep 'jupyter-notebook --notebook-dir=' | grep -v grep | awk '{print $2}' | xargs ./if-test.sh 


# lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs ./if-test.sh 