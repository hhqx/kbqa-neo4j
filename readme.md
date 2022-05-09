

# 基于neo4j和模板匹配的kbqa

## 运行说明

### 下载

```
git clone ...
cd ./kbqa-neo4j/Final
```

### 创建镜像

```shell
# 创建镜像
docker build  -f "Dockerfile" -t kbqa:neo4j-v1.0 .

# 创建容器 from 
docker run -deteach -p 9974:7474 -p 9987:7687 -p 9988:8888 --interactive --tty --name kbqa-neo4j-p8487 kbqa:neo4j-v1.0

# 进入容器
docker exec -ti neo4jv3.1 /bin/bash
```

修改





