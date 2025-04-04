#!/bin/bash
AMI=ami-09c813fb71547fc4f
SG_ID=sg-0e0d830a74a07d8cf
INSTANCES=("mongodb" "mysql" "rabbitmq" "redis" "catalogue" "user" "cart" "web" "payment" "shipping" "dispatch")

for i in "${INSTANCES[@]}"
do
  if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "redis" ] || [$i == rabbitmq ]
  then
      INSTANCES_TYPE="t2.midium"
      else
      INSTANCES_TYPE="t2.micro"
   fi
      aws ec2 run-instances --image-id $AMI --instance-type $INSTANCES_TYPE --security-group-ids $SG_ID
done