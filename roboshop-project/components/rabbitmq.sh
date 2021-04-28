#!/bin/bash

COMPONENT=rabbitmq
source components/common.sh

INFO "Setup RabbitMQ component"

INFO "Install Erlang"
 yum list esl-erlang &>>$LOG_FILE
 case $1 in
   0)
     STAT 0 "Erlang Installation"
   ;;
   1)
     yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y &>>$LOG_FILE
     STAT $? "Erlang Installation"
   ;;
 esac
INFO "Setup RabbitMQ Installation"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $? "RabbitMQ Yum Repos Setup"

INFO "Install RabbitMQ Server"
yum install rabbitmq-server -y &>>$LOG_FILE
STAT $? "RabbitMQ Server Install"

INFO "Start RabbitMQ Server"
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $? "Start RabbitMQ Service"

INFO "Create Roboshop App User In RabbitMQ"
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
STAT $? "Roboshop App User Create"