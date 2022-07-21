#!/bin/bash
#执行下面代码或者直接复制全部粘贴
# 安装SS5环境
yum -y install gcc automake make
#下载SS5依赖包

yum -y install pam-devel openldap-devel cyrus-sasl-devel openssl-devel

#下载SS5源码包

wget http://jaist.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz

#进入下载目录解压

tar -xf ss5-3.8.9-8.tar.gz
cd ss5-3.8.9/
#自动配置编译参数
./configure
#编译
make
#安装
make install
#配置密码访问
cat << "EOF" > /etc/opt/ss5/ss5.conf
auth 0.0.0.0/0 - u
permit u 0.0.0.0/0 - 0.0.0.0/0 - - - - -
EOF
#配置密码(根据需要，改成自己的用户名m1001、密码m1001)
echo 'm1001 m1001' > /etc/opt/ss5/ss5.passwd

#配置SS5网络及端口

echo 'SS5_OPTS=" -u root -b 0.0.0.0:1080"' > /etc/sysconfig/ss5

# 开机自启动(3.8.9-8的一个bug，重启会删掉/var/run/ss5/,导致开机自启动时无法创建pid文件
echo 'mkdir /var/run/ss5/' >> /etc/rc.d/rc.local ;\
chmod +x /etc/rc.d/rc.local ;\
/sbin/chkconfig ss5 on

#增加SS5启动权限

chmod +x /etc/rc.d/init.d/ss5
chkconfig --add ss5
chkconfig ss5 on
#启动SS5
service ss5 start
#防火墙开启端口可以修改其他端口和上面的端口要一致

firewall-cmd --add-port=1080/tcp --permanent ;\
firewall-cmd --reload
cd
rm -rf ss5-3.8.9-8.tar.gz
rm -rf ss5.sh
#重启
reboot
