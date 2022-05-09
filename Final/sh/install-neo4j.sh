#!/bin/bash

cd /app

# 下载java-jdk
echo '\n Download and install java-jdk ...'
wget https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/11/jre/x64/linux/OpenJDK11U-jre_x64_linux_hotspot_11.0.14.1_1.tar.gz --no-check-certificate
echo tar | tar -zxvf OpenJDK11U-jre_x64_linux_hotspot_11.0.14.1_1.tar.gz

# 添加JAVA_HOME环境变量
echo 'JAVA_HOME=/app/jdk-11.0.14.1+1-jre
export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
# 让修改生效
source ~/.bashrc


cd /app
# 下载解压neo4j
echo '\n Download and install neo4j ...'
# wget https://dist.neo4j.org/neo4j-community-4.4.6-unix.tar.gz
# wget https://we-yun.com/doc/neo4j/4.3.9/neo4j-community-4.3.9-unix.tar.gz
echo | tar -zxvf neo4j-community-4.4.6-unix.tar.gz

# 添加NEO4J_HOME环境变量
echo 'NEO4J_HOME=/app/neo4j-community-4.4.6
export PATH=$PATH:$NEO4J_HOME/bin' >> ~/.bashrc
# 让修改生效
source ~/.bashrc


# 配置本机以外的ip可访问
# echo 'dbms.security.auth_enabled=false' >> /app/neo4j-community-4.4.6/conf/neo4j.conf
echo 'dbms.default_listen_address=0.0.0.0' >> /app/neo4j-community-4.4.6/conf/neo4j.conf

# sleep 3


# 首次启动neo4j, 会自动创建 用户:neo4j 和 密码:neo4j
# 首次启动之后必须关闭重启才能登录修改密码---这个巨坑
#echo 'initializing neo4j...'
## debug print
#ls /app | awk '{print $1}' | xargs echo
#sh /app/neo4j-community-4.4.6/bin/neo4j start
#sh /app/neo4j-community-4.4.6/bin/neo4j stop