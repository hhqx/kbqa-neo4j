#!/bin/sh

# 开启neo4j服务器
/app/neo4j-community-4.4.6/bin/neo4j start
sleep 6

# 修改neo4j默认密码为kbqa
# RUN app/change-neo4j-default-password.sh
# /app/change-neo4j-pwr.sh.sh

# 导入本地csv数据
cd /app/jupyter/src
python3.6 -m csv2neo4j.py

# 开启jupyter
jupyter-notebook --notebook-dir='/app/jupyter' --allow-root &

