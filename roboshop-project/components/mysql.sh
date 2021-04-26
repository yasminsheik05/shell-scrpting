#!/bin/bash

COMPONENT=mysql
source components/common.sh

INFO "Setup MySQL component"

INFO "Setup MySQL YUM Repositories"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $? "Setup Repository"

INFO "Install MySQL Service"
yum remove mariadb-libs -y &>>LOG_FILE
yum install mysql-community-server -y &>>LOG_FILE
STAT $? "MySQL Installation"

INFO "Start MySQL Service"
systemctl enable mysqld &>>LOG_FILE
systemctl start mysqld &>>LOG_FILE
STAT $? "MySQL Service Startup"