#!/bin/bash

COMPONENT=shipping
source components/common.sh

INFO "Setup shipping component"

INFO "Install Maven"
yum install maven -y &>>$LOG_FILE
STAT $? "Maven Installation"
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

INFO "Download shipping Application"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/9c06b317-6353-43f6-81e2-aa4f5f258b2d/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

INFO "Extract Artifacts"
mkdir -p /home/roboshop/${COMPONENT}
cd /home/roboshop/${COMPONENT}
unzip -o /tmp/${COMPONENT}.zip &>>$LOG_FILE
STAT $? "Artifact extract"

INFO "Compile shipping application"
mvn clean package &>>$LOG_FILE
mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
STAT $? "Shipping Compile"

chown roboshop:roboshop /home/roboshop/${COMPONENT} -R
INFO "Configuring shipping startup script"
sed -i -e "s/CARTENDPOINT/cart-test.ms-word.tk/" -e "s/DBHOST/mysql-test.ms-word.tk/" /home/roboshop/${COMPONENT}/systemd.service
STAT $? "Startup script Configuration"

INFO "Setup systemD service for user"
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
systemctl daemon-reload
STAT $? "Shipping systemD service"


INFO "Starting Shipping service"
systemctl enable ${COMPONENT} &>>$LOG_FILE
systemctl restart ${COMPONENT} &>>$LOG_FILE
STAT $? "Shipping service start"
