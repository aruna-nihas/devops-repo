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

dnf install nginx -y &>> $LOGFILE

VALIDATE $? "Installed Nginx"

systemctl enable nginx &>> $LOGFILE

VALIDATE $? "enabled Nginx"

systemctl start nginx &>> $LOGFILE

VALIDATE $? "started Nginx"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE

VALIDATE $? "removed nginx html page"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE

VALIDATE $? "Downloaded web page of roboshop"

cd /usr/share/nginx/html 

unzip -o /tmp/web.zip &>> $LOGFILE

VALIDATE $? "unzipped the web page"

cp /home/ec2-user/devops-repo/roboshop-shell/roboshop.config /etc/nginx/default.d/roboshop.conf  &>> $LOGFILE

VALIDATE $? "downloaded the roboshop application"

systemctl restart nginx &>> $LOGFILE

VALIDATE $? "Restarted nginx"


