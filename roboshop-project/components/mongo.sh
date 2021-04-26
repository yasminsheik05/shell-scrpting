#!/bin/bash

COMPONENT=Mongodb
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

INFO "Update MongoDB Configuration"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $? "MongoDB Configuration Update"

INFO "Restart MongoDb"
systemctl enable mongod $LOG_FILE
systemctl restart mongod $LOG_FILE
STAT $? "MongoDB Restart"

INFO "Downloading MongoDB Schema"
DOWNLOAD_ARTIFACT  "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/03f2af34-e227-44b8-a9f2-c26720b34942/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

cd /tmp
INFO "Extract Artifact"
unzip -o mongodb.zip &>>$LOG_FILE
STAT $? "Artifact Extract"

INFO "Load shema-catalogue service"
mongo < catalogue.js &>>$LOG_FILE
STAT $? "Catalogue Schema Load"

INFO "Load Schema - User Service"
mongo < users.js &>>$LOG_FILE
STAT $? "User Schema Load"
