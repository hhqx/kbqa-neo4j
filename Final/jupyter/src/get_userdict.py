# -*- coding: utf-8 -*-
"""
Created on Fri Oct 29 14:29:17 2021

@author: ASUS
"""
# 安装neo4j驱动包:
# pip install --pre neo4j -i https://pypi.org/simple


# %% function definition
def query_from_neo4j(neo4j_driver, cypher_query, returned_names):
    query_results = []
    for i in range(len(returned_names)):
        query_results.append([])

    with neo4j_driver.session(database="neo4j") as session:
        results = session.read_transaction(
            lambda tx: tx.run(cypher_query, limit="10").data()
        )
        for i in range(len(results)):
            for j in range(len(returned_names)):
                query_results[j].append(results[i][returned_names[j]])
            # print(record['Genre.name'])

    return query_results


# %% 调用neo4j接口进行查询
from neo4j import GraphDatabase, basic_auth

neo4j_driver = GraphDatabase.driver(
    "bolt://3.234.154.25:7687", auth=basic_auth("neo4j", "saddle-clouds-catchers")
)

cypher_query = [
    "MATCH (Genre:Genre) RETURN Genre.gid,Genre.name",
    "MATCH (Movie:Movie) RETURN Movie.mid,Movie.title",
    "MATCH (Person:Person) RETURN Person.pid,Person.pname,Person.eng_name",
]
name_query = [
    [
        "Genre.name",
    ],
    [
        "Movie.title",
    ],
    [
        "Person.pname",
        "Person.eng_name",
    ],
]
query_results = [[], [], []]

# 查询
for i in range(len(query_results)):
    query_results[i] = query_from_neo4j(neo4j_driver, cypher_query[i], name_query[i])

neo4j_driver.close()

# %% 生成userdict
userdict_label = ["ng", "nm", "nnt"]
userdict_number = 10000
userdict = []
delimiter = " "

# 将没有中文名字的人用英文名字替换
for j in range(len(query_results[2][0])):
    if query_results[2][0][j] is None:
        query_results[2][0][j] = query_results[2][1][j]

for i in range(len(query_results)):
    query_results[i] = query_results[i][0]

# 生成最终结果
for i in range(len(query_results)):
    for j in range(len(query_results[i])):
        if query_results[i][j] is not None:
            string = (
                query_results[i][j]
                + delimiter
                + str(userdict_number)
                + delimiter
                + userdict_label[i]
            )
            userdict.append(string)

# %% 保存到文件
userdict_fname = "data/userdict.txt"
f = open(userdict_fname, mode="w", encoding="utf-8")
for i in range(len(userdict)):
    f.write(userdict[i] + "\n")  # 调用 fwrite() 写入到文件
f.close()

print("共写了: ", len(userdict), "* 3", "个数据")

# %% 再次读入验证
import csv

data = []
with open(userdict_fname, encoding="utf-8") as csvfile:
    reader = csv.reader(csvfile, delimiter=delimiter)
    for row in reader:
        data.append(row)
        if len(row) != 3:
            print(row)

# 查看读入了多少个数据
cnt = 0
for datai in data:
    cnt = cnt + len(datai)

print("共读入了: ", cnt / 3, "* 3", "个数据")

#%%
