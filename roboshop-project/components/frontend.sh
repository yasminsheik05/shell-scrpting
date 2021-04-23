#!/bin/bash

COMPONENT=frontend

. components/common.sh

INFO "frontend component"
INFO "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
STAT $? "Nginx Installation"