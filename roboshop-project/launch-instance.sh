#!/bin/bash


case $1 in
  launch)
    for component in frontend catalogue cart user shipping payment mysql mongo rabbitmq redis; do
      echo "Launching $component Spot Instance"
      aws ec2 run-instances --launch-template LaunchTemplateId=lt-025292828ff70c560 --tag-specifications "ResourceType=instance,Tags=[{Key=name,Value=${component}}]" &>>/tmp/instance-launch
      done
    ;;
    routes)
      echo updating routes
       for component in frontend catalogue cart user shipping payment mysql mongo rabbitmq redis; do
      IP=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${component} Name=instance-state-name,Values=running | jq  '.Reservations[].Instances[].PrivateIpAddress')
      sed -e "s/COMPONENT/${component}" -e "s/IPADDRESS/${IP}/" record.json >/tmp/${component} .json aws route53 change-resource-record-sets --hosted-zone-id Z08751272HPPGTS2GU52M --change-batch file:///tmp/${component}.json

      done
    ;;
esac