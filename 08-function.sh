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
SAMPLE2
echo A=$a