# centos一键安装ss5
wget --no-check-certificate https://raw.githubusercontent.com//mfkd1000/ss5/main/ss5.sh && chmod +x ss5.sh && bash ss5.sh


# 修改账号密码 默认账号m1001  密码m1001
vi /etc/opt/ss5/ss5.passwd
# 修改端口 默认端口1080
vi /etc/sysconfig/ss5
