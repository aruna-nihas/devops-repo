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

