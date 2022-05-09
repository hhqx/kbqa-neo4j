#!/bin/bash

# 安装jupyter
pip install jupyter -i https://pypi.tuna.tsinghua.edu.cn/simple

# 生成配置文件
jupyter-notebook --generate-config 

# 设置jupyter端口为8888, 密码为jupyter
echo "
c = get_config()
# c.NotebookApp.certfile = R'\yourdomain.com.crt'
# c.NotebookApp.keyfile = R'\yourdomain.com.key'
# Set ip to '*' to bind on all interfaces (ips) for the public server
c.NotebookApp.ip = '*'
# 创建密码文本的哈希值, 密码jupyter
c.NotebookApp.password = 'argon2:\$argon2id\$v=19\$m=10240,t=10,p=8\$qb/7xVmPMHRnFPNfEcuxXQ\$43myWYYBr2/7WrcRMWKUxPE+NmO4ia1evH7WxnFF2uc'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False

#允许远程访问
c.NotebookApp.allow_remote_access = True" >> ~/.jupyter/jupyter_notebook_config.py
