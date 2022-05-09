#!/usr/bin/expect 


send_user '\n尝试更改neo4j初始密码...\n'
set timeout 5
spawn /app/neo4j-community-4.4.6/bin/cypher-shell

set user neo4j
set oldpassword neo4j
set newpassword kbqa
expect {
	"new password:" { send "$newpassword\r"; exp_continue }
	"*confirm password:" { send "$newpassword\r";  }
	"*Connection refused*" { send_user '\nneo4服务未开启!\n'; }
	"*Connected to Neo4j*" { send ":exit\r"; send_user '\n初始密码修改成功! 已改为: kbqa \n'}
    "username:" { send "$user\r"; exp_continue }
	"password:" { send "$oldpassword\r"; send_user ":$oldpassword"; exp_continue }
    "*unauthorized due to authentication failure*" { send_user '\n初始密码之前已修改过!\n';
        # send_user '\n尝试用新密码登录\n'; 
        # expect{
        #     "*Connected to Neo4j*" { send ":exit\r"; send_user '\n新密码登录成功! \n';}
        #     "username:" { send "$user\r"; exp_continue }
        #     "password:" { send "$newpassword\r"; exp_continue }
        #     "*unauthorized due to authentication failure*" { send_user '\n新密码登录失败, 密码在别处已修改过!\n'; send ":exit\r"}
        # }
    }
}

expect eof 
