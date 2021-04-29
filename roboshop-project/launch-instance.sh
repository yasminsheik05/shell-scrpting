#!/bin/bash

case $1 in
  launch)
    for component in frontend catalogue cart user shipping payment mysql mongo rabbitmq redis; do
      echo "Launching $component Spot instance"
      aws ec2 run-instances --launch-template LaunchTemplateId=lt-025292828ff70c560 --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${component}}]" &>>/tmp/instance-launch
      done
    ;;
    routes)
      echo updating routes
    ;;
  esac