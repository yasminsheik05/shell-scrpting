#!/bin/bash

COMPONENT=Mongo
source components/common.sh
INFO "Setup Mongo component"

INFO "Setup MongoDB YUM Repository"

echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.
STAT $? "Repository setup"

INFO "Install Mongodb"
yum install -y mongodb-org &>>$LOG_FILE
STAT $? "MongoDB Install"

# systemctl enable mongod
# systemctl start mongod
#/etc/mongod.conf from 127.0.0.1 to 0.0.0.0
