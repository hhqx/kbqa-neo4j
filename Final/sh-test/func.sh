#!/bin/bash

echo $0
echo $1
echo $2
echo $3

# 判断参数是否存在
if [ $1 ]
    then
    echo "参数1存在"
fi
if [ $2 ]
    then
    echo "参数2存在"
fi
if [ $3 ]
    then
    echo "参数3存在"
fi
if [ $4 ]
    then
    echo "参数4存在"
fi

function mytest()
{
    echo "arg1 = $1"
    if [ $1 = "1" ] ;then
        return 1 
    else
        return 0
    fi
}
function argsIsEmpty()
{
    echo "arg0 = $0"
    echo "arg1 = $1"
    if [ $1 ] ;then
        return 0 
    else
        return 1
    fi
}
# argsIsEmpty 1 2 3
# echo res: $?
# echo "1" | argsIsEmpty
# echo 
# echo "mytest 1"
# mytest 1
# echo $?         # print return result

# a = lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs echo
# echo a=$a


################################# Shell编程--获取命令执行返回结果 #################################
# text=`cat /etc/passwd|cut -d ':' -f1`
# # text=`echo 'echo something'`
# i=1
# for element in $text   
# do 
#     echo "第$i行为$element"
#     i=`expr $i + 1`
# done


################################# 判断端口8888是否被占用, 未被占用则启动jupyter #################################
CMD_PID=`lsof -i:8888 | grep 'LISTEN'  | grep 'IPv4' | awk '{print $1":"$2}' | xargs echo`

if [ $CMD_PID ]
    then
    echo "占用8888端口的进程: $CMD_PID"
else
    # 开启jupyter
    echo "开启jupyter..."
fi










exit 0

# echo "# 查看监听8888端口的进程"
# 打印监听8888端口的进程
# lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs echo
# lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs argsIsEmpty
# echo $?         # print return result

# return 'test'

# if [ lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs echo]
#     then
#     echo "端口8888已经被占用"
# fi

# lsof -i:8888

