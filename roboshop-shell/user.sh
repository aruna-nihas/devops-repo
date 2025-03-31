#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo -e "$G The script started at $TIMESTAMP $N"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R Failed $N"
        else
            echo -e "$2....$G successful $N"
    fi
}
if [ $ID -ne 0 ]
then
    echo -e "$R ERROR....Plz use root user $N"
    exit 1
    else
        echo -e "$Y u r a root user $N"
fi
dnf module disable nodejs -y &>> $LOGFILE

VALIDATE $? "disabled nodejs"

dnf module enable nodejs:20 -y &>> $LOGFILE

VALIDATE $? "enabled nodejs:20"

dnf install nodejs -y &>> $LOGFILE

VALIDATE $? "installed nodejs"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop

    VALIDATE $? "roboshop id added"

    else
        echo -e "$Y roboshop user already exist $N"
fi
mkdir /app

VALIDATE $? "app dir created"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE

VALIDATE $? "downloaded the user applocation"

cd /app 

unzip -o /tmp/user.zip &>> $LOGFILE

VALIDATE $? "unzipped the user application"

npm install &>> $LOGFILE

VALIDATE $? "Dependencies are downloaded"

cp /home/ec2-user/devops-repo/roboshop-shell/user.service /etc/systemd/system/user.service &>> $LOGFILE

VALIDATE $? "copied user service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "user service reloaded"

systemctl enable user  &>> $LOGFILE

VALIDATE $? "user service enabled"

systemctl start user &>> $LOGFILE

VALIDATE $? "user service started"

cp /home/ec2-user/devops-repo/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "copied mongodb repository"

dnf install mongodb-mongosh -y &>> $LOGFILE

VALIDATE $? "Installed mongodb client"

mongosh --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>> $LOGFILE

VALIDATE $? "schema loaded to user" 