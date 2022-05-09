#!/bin/sh
# if test then... elif test then... else... fi
# if [ -d $1 ]		#其中[]替换了test,判断占位($1)的需要输入的文件是否是目录。
#     then
#     echo "is a directory!"
# elif [ -f $1 ]
#     t`hen
#     ech`o "is a file!"
# else
#     echo "error!"
# fi

# lsof -i:8888 |grep -v grep | echo $1

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
if [ $3=="" ]
    then
    echo "参数3不存在"
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

echo 
echo "mytest 1"
mytest 1
echo $?         # print return result

# 查看监听8888端口的进程
# lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs echo

# return 'test'

# if [ lsof -i:8888 | grep 'LISTEN'  | grep -v grep | awk '{print $2}' | xargs echo]
#     then
#     echo "端口8888已经被占用"
# fi

# lsof -i:8888
