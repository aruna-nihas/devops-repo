#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo -e "$G The script started at $TIMESTAMP $N"

VALIDATE () {
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

VALIDATE $? "disabling nodejs"

dnf module enable nodejs:20 -y &>> $LOGFILE

VALIDATE $? "enabling nodejs:20"

dnf install nodejs -y &>> $LOGFILE

VALIDATE $? "installing nodejs"

useradd roboshop

VALIDATE $?"added roboshop"


mkdir /app

VALIDATE $? "created app dir"


curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE

VALIDATE $? "downloading catalogue"

cd /app 

unzip /tmp/catalogue.zip &>> $LOGFILE

VALIDATE $? "unzipping catalogue"

npm install &>> $LOGFILE

VALIDATE $? "installing dependencies"

cp /home/ec2-user/devops-repo/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>> $LOGFILE

VALIDATE $? "copying catalogue service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "daemon-reloading"

systemctl enable catalogue &>> $LOGFILE

VALIDATE $? "enabling catalogue"

systemctl start catalogue &>> $LOGFILE

VALIDATE $? "starting catalogue"

cp /home/ec2-user/devops-repo/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "copying mongodb client"

dnf install -y mongodb-mongosh &>> $LOGFILE

VALIDATE $? "installing mongodb"

mongosh --host 172.31.20.214 </app/schema/catalogue.js &>> $LOGFILE

VALIDATE $? "updating schema"

