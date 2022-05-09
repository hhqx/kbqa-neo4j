FROM ubuntu:18.04

# 替换为清华源
RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list

RUN apt-get update

# 安装网络端口相关工具包
RUN apt-get -y install net-tools
RUN apt-get -y install lsof
# 安装python3.6和相关包
RUN apt-get -y install python3.6
RUN apt-get -y install python3.6-dev
RUN apt-get -y install python3-pip
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pip --upgrade

RUN pip install py2neo==4.3.0 jieba sklearn -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt-get install wget -y

# 复制文件到镜像
COPY ./sh /app/sh
COPY ./jupyter /app/jupyter
COPY ./start.sh /app
COPY ./neo4j-community-4.4.6-unix.tar.gz /app
WORKDIR /app

# debug print
RUN ls /app | awk '{print $1}' | xargs echo

# 安装neo4j
RUN /bin/bash /app/sh/install-neo4j.sh

# 添加环境变量
ENV JAVA_HOME=/app/jdk-11.0.14.1+1-jre NEO4J_HOME=/app/neo4j-community-4.4.6
RUN PATH="$JAVA_HOME/bin:$PATH"
RUN export PATH
RUN PATH="$NEO4J_HOME/bin:$PATH"
RUN export PATH

# 首次启动neo4j, 会自动创建 用户:neo4j 和 密码:neo4j
# 首次启动之后必须关闭重启才能登录修改密码---这个巨坑
RUN echo 'initializing neo4j...'
# debug print
RUN ls /app | awk '{print $1}' | xargs echo
# RUN sh /app/neo4j-community-4.4.6/bin/neo4j start
# RUN sh /app/neo4j-community-4.4.6/bin/neo4j stop


# 将data文件夹链接到neo4j图数据库的import目录下
RUN ln -s /app/jupyter/src/data $NEO4J_HOME/import


# 安装并配置jupyter
RUN sh /app/sh/install-jupyter.sh

# EXPOSE 7474 8888 


# 添加环境变量
RUN echo '\nexport PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin' >> /etc/profile
RUN export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# # 启动neo4j 和 jupyter
RUN mkdir /app/logs
# RUN ["chmod", "+x", "./start.sh"]
# CMD ["/app/start.sh"]
ENTRYPOINT /bin/bash /app/start.sh && /bin/bash

