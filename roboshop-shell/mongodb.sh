#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then
    echo "ERROR....Plz use root user"
    exit 1
    else
        echo "u r a root user"
fi
cp mongodb.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y 

systemctl enable mongod

systemctl start mongod

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

systemctl restart mongod
