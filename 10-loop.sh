#!/bin/bash

##for loop
for i in frontend catalogue mongo
do
  echo component = $i
  sleep1
done

i=10
while [ $i -gt 0 ]; do
  echo $i
  i=$(($i-1))
done
