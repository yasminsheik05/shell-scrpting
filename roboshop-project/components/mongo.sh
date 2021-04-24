#!/bin/bash

COMPONENT=Mongo
source components/common.sh

INFO "Setup Mongo component"
INFO "Setup mongoDB yum repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo

STAT $? "Repository setup"
INFO "Installing mongoDB"
yum install -y mongodb.org &>>$LOG_FILE
STAT $? "MongoDB Install"