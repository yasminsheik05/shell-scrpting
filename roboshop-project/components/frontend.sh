#!/bin/bash

COMPONENT=frontend

. components/common.sh

INFO "frontend component"
INFO "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
STAT $? "Nginx Installation"
INFO "Download Artifact"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f4b641c1-99db-46d1-8110-5c6c24ce2fb9/_apis/git/repositories/a781da9c-8fca-4605-8928-53c962282b74/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"