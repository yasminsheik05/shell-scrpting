#!/bin/bash

function SAMPLE() {
     echo B=$b
     echo Hello from SAMPLE function
     a=10
}
SAMPLE1() {
     echo Hello from SAMPLE1 function
}
b=20
SAMPLE
SAMPLE1
echo A=$a
SAMPLE2() {
  echo First argument = $1
  echo Second argument = $2
}
SAMPLE2 10 20
