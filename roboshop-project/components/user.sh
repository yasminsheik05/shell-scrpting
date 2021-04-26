#!/bin/bash

COMPONENT=user
source components/common.sh

INFO "Setup user component"
INFO "Install nodeJS"
yum install nodejs make gcc-c++ -y &>>$LOG_FILE
STAT $? "NODEJS Installation"
INFO "Create Application User"
id roboshop &>>$LOG_FILE
case $? in
 0)
   STAT 0 "Application user creation"
   ;;
 1)
   useradd roboshop &>>LOG_FILE
  STAT $? "Application user creation"
  ;;
esac
INFO "Download user Application"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

INFO "Extract Artifacts"
mkdir -p /home/roboshop/${COMPONENT}
cd /home/roboshop/${COMPONENT}
unzip -o /tmp/${COMPONENT}.zip &>>$LOG_FILE

STAT $? "Artifact extract"
INFO "Install nodeJS dependencies"
npm install --unsafe-perm &>>$LOG_FILE
STAT $? "NodeJS Dependencies Installation"

chown roboshop:roboshop /home/roboshop/${COMPONENT} -R
INFO "Configuring user startup script"
sed -i -e "s/MONGO_ENDPOINT/mongodb-test.ms-word.tk/" -e "s/REDIS-ENDPOINT/redis-test.ms-word.tk/" /home/roboshop/${COMPONENT}/systemd.service
STAT $? "Startup script Configuration"

INFO "Setup systemD service for user"
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
systemctl daemon-reload
STAT $? "user systemD service"

INFO "Starting user service"
systemctl start ${COMPONENT} &>>$LOG_FILE
systemctl enable ${COMPONENT} &>>$LOG_FILE
STAT $? "user service start"
