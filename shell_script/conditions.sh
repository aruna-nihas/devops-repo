#!/bin/bash
NUMBER=$1
if [ $NUMBER -gt 100 ]
then
echo "given $NUMBER is greater than 100"
else
echo "given $NUMBER is not greater than 100"
fi