#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R Failed $N"
        else
            echo "$2....$G successful $N"
    fi
}
if [ $ID -ne 0 ]
then
    echo -e "$R ERROR....Plz use root user $N"
    exit 1
    else
        echo -e "$Y u r a root user $N"
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
