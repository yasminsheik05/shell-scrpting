#!/bin/bash

case $1 in
  launch)
    for component in frontend catalogue mongo cart user shipping payment mysql rabbitmq redis; do
      aws ec2 run-instances --launch-template LaunchTemplateId=lt-025292828ff70c560 --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${component}]"
      done
    ;;
    routes)
      echo updating routes
    ;;
  esac