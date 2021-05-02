#!/bin/bash


if [ "$1" == "DevOps" ]; then
  echo "Welcome To DevOps Training"
  elif [ "$1" == "AWS" ]; then
    echo Welcome To AWS Training
fi


if [ $# -eq 1 ]; then
  echo Number Of Argumets = 1
  else
    echo Number O f Arguments != 1
fi