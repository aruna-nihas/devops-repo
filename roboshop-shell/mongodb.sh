#!/bin/bash
ID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2....Failed"
        else
            echo "$2....successful"
    fi
}
if [ $ID -ne 0 ]
then
    echo "ERROR....Plz use root user"
    exit 1
    else
        echo "u r a root user"
fi
cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y 

VALIDATE $? "mongodb installation"

systemctl enable mongod

VALIDATE $? "enabling mongodb"

systemctl start mongod

VALIDATE $? "starting mongodb"

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

systemctl restart mongod

VALIDATE $? "restarting mongodb"
