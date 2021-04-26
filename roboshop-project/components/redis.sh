#!/bin/bash

COMPONENT=redis
source components/common.sh

INFO "Setup Redis component"

INFO "Setup Redis YUM Repos"
yum install epel-release yum-utils -y &>>$LOG_FILE
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG_FILE
yum-config-manager --enable remi &>>$LOG_FILE
STAT $? "Yum Repos Configured"

INFO "Install Redis"
yum install redis -y &>>$LOG_FILE
STAT $? "Redis Install"

INFO "Configure Redis Configuration"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf
STAT $? "Redis Configuration Setup"

INFO "Start Redis Service"
systemctl enable redis &>>$LOG_FILE
systemctl start redis &>>$LOG_FILE
STAT $? "Redis Service Startup"
